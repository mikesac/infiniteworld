package org.infinite.web.fight;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.engines.AI.AIEngine;
import org.infinite.engines.fight.FightEngine;
import org.infinite.objects.Character;
import org.infinite.objects.FightInterface;
import org.infinite.util.XmlUtil;
import org.infinite.web.PagesCst;

public class FightMap  extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
			
		
		if(req.getRemoteUser()==null){
			resp.sendRedirect(req.getContextPath());
		}
			
		
		
		//Party one is player, party 2 depends on map area
				
		Vector<FightInterface> side1  = new Vector<FightInterface>();
		Vector<FightInterface> side2  = new Vector<FightInterface>();

		Character c = (Character)req.getSession().getAttribute("character");
		
		side1.add(c);
		
		//TODO get party2 randomly
		try {
			side2.add( AIEngine.spawn("Goblin") );
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
				

		try {
			
			String xml =  FightEngine.runFight(side1,side2);
			System.out.println(xml);
			xml = XmlUtil.xml2String(xml, "fight/fight");
			
			req.getSession().setAttribute("mapfight", xml);
			
			
		} catch (Exception e) {
			req.getSession().setAttribute("error",e.toString());
			e.printStackTrace();
			return;
		}
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAPFIGHT);			
		
	}
	

}
