package org.infinite.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.AreaItem;
import org.infinite.objects.Character;
import org.infinite.objects.Map;

public class MapMove extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {

		if(req.getRemoteUser()==null){
			resp.sendRedirect(req.getContextPath());
		}

		String next = req.getParameter("m");

		if(next==null){
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Could not access this page directly, missing parameters!");
		}
		else{

			AreaItem nextArea = (AreaItem)Manager.listByQuery("select a from org.infinite.db.dao.AreaItem a where a.id="+next).get(0);

			Character c = (Character)req.getSession().getAttribute("character");

			if(c.getPointsAction() < nextArea.getCost()){
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "You do not have enough Action Point to move to that Area!");
			}
			else{
				AreaItem currArea = c.getAreaItem();

				if( c.moveToAreaItem(nextArea) ){
					req.getSession().setAttribute(PagesCst.CONTEXT_MAP, new Map(nextArea,c));
					req.getSession().setAttribute(PagesCst.CONTEXT_CHARACTER, c);
				}
				else{
					req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "You cannot move to that area");
					req.getSession().setAttribute(PagesCst.CONTEXT_MAP, new Map(currArea,c) );
				}
			}
		}
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAP );


	}

}
