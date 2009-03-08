package org.infinite.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.objects.Character;
import org.infinite.objects.Map;

public class MapMove extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		
		String next = req.getParameter("m");
		
		if(next==null){
			//TODO redirect indietro con errore
		}
		
		Area nextArea = (Area)Manager.listByQery("select a from org.infinite.db.dao.Area a where a.name='"+next+"'").get(0);
		
		Character c = (Character)req.getSession().getAttribute("character");
		
		Area currArea = c.getArea();
		
		if( c.moveToArea(nextArea) ){
			req.getSession().setAttribute("map", new Map(nextArea));
			req.getSession().setAttribute("character", c);
		}
		else{
			req.getSession().setAttribute("error", "You cannot move to that area");
			req.getSession().setAttribute("map", new Map(currArea) );
		}
		
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAP );
		
		
	}
	
}
