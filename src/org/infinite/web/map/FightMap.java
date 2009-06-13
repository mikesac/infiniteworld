package org.infinite.web.map;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.infinite.db.Manager;
import org.infinite.engines.AI.newAIEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.engines.fight.FightRound;
import org.infinite.engines.fight.PlayerInterface;
import org.infinite.objects.Character;
import org.infinite.web.PagesCst;

public class FightMap  extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Log log;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		log = LogFactory.getLog( this.getClass().getName() );
	}
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
			
		
		try{
			
			if(req.getRemoteUser()==null){
				resp.sendRedirect(req.getContextPath());
			}		
			
			//Party one is player, party 2 depends on map area				
			ArrayList<PlayerInterface> side1  = new ArrayList<PlayerInterface>();
			ArrayList<PlayerInterface> side2  = new ArrayList<PlayerInterface>();

			Character c = (Character)req.getSession().getAttribute( PagesCst.CONTEXT_CHARACTER);
			
			if(c.getPointsLife()<=0){
				throw new Exception("Cannot enter fight, insufficent Life Points");
			}
						
			side1.add(c);
			
			//get monster based on player level
			int level = c.getLevel();
			level = newAIEngine.getMatchingLevel(level);
			
			if(level==0){
				throw new Exception("No monsters encounter this time!");
			}
			
			ArrayList<String> list = (ArrayList<String>)Manager.listByQuery("select n.name from org.infinite.db.dao.Npc n where n.level="+level+" and n.ismonster=1");
			
			if(list.size()==0){
				throw new Exception("No monsters matching your level ("+level+")");
			}
			
			int index = newAIEngine.getRandomNumber(0, list.size());
			
			try {
				side2.add( newAIEngine.spawn("Goblin"));//list.get(index)) );
			} catch (Exception e1) {
				log.error("Error Spawining Monster", e1);
				e1.printStackTrace();
				throw new Exception("Error Spawining Monster"); 
			}
			
					

			try {
				//sides must be saved first, after fight death pc are missing
				req.getSession().setAttribute(PagesCst.CONTEXT_FIGHT_REPORT_S1, side1.clone());
				req.getSession().setAttribute(PagesCst.CONTEXT_FIGHT_REPORT_S2, side2.clone());
				
				ArrayList<FightRound> report = FightEngine.runFight(side1,side2);				
				req.getSession().setAttribute(PagesCst.CONTEXT_FIGHT_REPORT, report);
				
				
				
			} catch (Exception e) {
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,e.getMessage());
				log.error("runFight Error",e);
				return;
			}
			
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAPFIGHT);
		}
		catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,e.getMessage());
			log.error("Generic Error",e);
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAP);
		}	
		
	}
}
