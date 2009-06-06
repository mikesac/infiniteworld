package org.infinite.web.map;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.AreaItem;
import org.infinite.engines.map.InaccessibleAreaException;
import org.infinite.engines.map.MapEngine;
import org.infinite.objects.Character;
import org.infinite.objects.Map;
import org.infinite.util.GenericUtil;
import org.infinite.web.PagesCst;

public class MapMove extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final String FORWARD = "ff";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {

		Character c = PagesCst.getCharacter(req, resp);
		if(c==null){
			//redirect already set in getCharacter
			return;
		}
		
		//check for regeneration for AP
		Character.checkForRegeneration(c);

		String next = req.getParameter("m");
		String ff = (String)req.getSession().getAttribute(FORWARD);
		req.getSession().removeAttribute(FORWARD);
		boolean moved = false;
		AreaItem nextArea = null;
		
		if(next==null){
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Could not access this page directly, missing parameters!");
		}
		else{

			nextArea = (AreaItem)Manager.findById(AreaItem.class.getName(), GenericUtil.toInt(next, -1) );

			if(c.getPointsAction() < nextArea.getCost()){
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "You do not have enough Action Point to move to that Area!");
			}
			else{
				Area a=null;
				
				try {
					a = c.moveToAreaItem(nextArea);
					moved = true;
				} catch (InaccessibleAreaException e) {
					a = MapEngine.getAreaFromAreaItem( c.getAreaItem() );
					
					int status = GenericUtil.toInt(e.getMessage(), -1);
					String msg = "unknown error";
					switch (status) {
					case MapEngine.AREA_STATUS_BANNED:
						msg = "your level is too low";
						break;
					case MapEngine.AREA_STATUS_FAR:
						msg = "this area is too far, move nearer";
						break;
					case MapEngine.AREA_STATUS_LOCKED:
						msg = "you do not have proper key";
						break;
					case MapEngine.AREA_STATUS_HIDDEN:
						msg = "hidden area";
						break;
					}
					
					
					req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,"Failed to move to choosen area:"+msg);
				}
				req.getSession().setAttribute(PagesCst.CONTEXT_MAP, new Map(a,c));
				req.getSession().setAttribute(PagesCst.CONTEXT_CHARACTER, c);

			}
		}
		
		if(moved && nextArea.getUrl().length()!=0 & ff==null){
			if(nextArea.isDoublestep()){
				req.getSession().setAttribute(FORWARD, "1");
			}
			resp.sendRedirect( req.getContextPath() + nextArea.getUrl() );
		}
		else
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAP );


	}

}
