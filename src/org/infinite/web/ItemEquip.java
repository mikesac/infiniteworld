package org.infinite.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.objects.Character;
import org.infinite.util.InfiniteCst;


public class ItemEquip extends HttpServlet {

	private static final long serialVersionUID = -2464305916983419155L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		
		String p_id = req.getParameter("itemid");
		String p_mode = req.getParameter("mode");
		
		Character c = PagesCst.getCharacter(req, resp);
		if(c==null){
			//redirect already set in getCharacter
			return;
		}
		
		
		if( p_id==null || p_mode == null){
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Could not access this page directly, missing parameters!");
		}
		else{
			
			int poiId = Integer.parseInt(p_id);
			int mode = Integer.parseInt(p_mode);
			
			PlayerOwnItem poi = (PlayerOwnItem) Manager.findById(PlayerOwnItem.class.getName(), poiId);
			
			if(poi==null)
				mode=-1;
			
			switch (mode) {
			case InfiniteCst.POI_EQUIP:				
				try {
						c.wearItem(poi);
					} catch (Exception e) {
						req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, e.getMessage());
					}
				break;
			case InfiniteCst.POI_DROP:
				c.dropItem(poi);
				break;
			case InfiniteCst.POI_UNEQUIP:
				c.moveToInventory(poi);
				break;

			default:
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Item ("+poiId+") not found");
				break;
			}
			
			
		}
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_EQUIP );
		
	}
	
	
	
	
}
