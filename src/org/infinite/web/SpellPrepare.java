package org.infinite.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.PlayerKnowSpell;
import org.infinite.db.dao.Spell;
import org.infinite.objects.Character;
import org.infinite.util.InfiniteCst;

public class SpellPrepare extends HttpServlet {

	private static final long serialVersionUID = -5661855671733149974L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {

		try{
			
			String p_id = req.getParameter("spellid");
			String p_mode = req.getParameter("mode");

			Character c = PagesCst.getCharacter(req, resp);
			if(c==null)
				return;

			if( p_id==null || p_mode == null){
				throw new Exception("Could not access this page directly, missing parameters!");
			}
			else{

				int pksId = Integer.parseInt(p_id);
				int mode = Integer.parseInt(p_mode);

				PlayerKnowSpell pks = (PlayerKnowSpell) Manager.findById(PlayerKnowSpell.class.getName(), pksId);

				if(pks==null)
					mode=-1;

				switch (mode) {
				case InfiniteCst.PKS_EQUIP:		
					if(c.getAvailableSpellSlot()==0)
						throw new Exception("No more slots available!");
					c.prepareSpell(pks);					
					break;
				case InfiniteCst.PKS_DROP:
					c.unprepareSpell(pksId);
					break;

				default:
					throw new Exception( "Spell ("+pksId+") not found") ;
				}

			}
			
		}
		catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, e.getMessage());
		}
		
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_SPELL );
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try{

			String p_id = req.getParameter("spellid");
			Character c = PagesCst.getCharacter(req, resp);
			if(c==null){
				//redirect already set in getCharacter
				return;
			}

			if( p_id==null)
				throw new Exception("Could not access this page directly, missing parameters!");

			int pksId = Integer.parseInt(p_id);

			PlayerKnowSpell pks = (PlayerKnowSpell) Manager.findById(PlayerKnowSpell.class.getName(), pksId);

			if(pks==null)
				throw new Exception("You don't know this spell!");

			Spell s = pks.getSpell(); 			
			req.getSession().setAttribute(PagesCst.CONTEXT_SPELLBOOK, s);
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_SPELLBOOK );
			
		}
		catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, e.getMessage() );
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_SPELL );
		}



	}


}
