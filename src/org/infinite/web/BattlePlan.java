package org.infinite.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.objects.Character;


public class BattlePlan extends HttpServlet {

	private static final long serialVersionUID = 7440038948740992484L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		
		String serializedPlan = req.getParameter("serialized");
		
		Character c = PagesCst.getCharacter(req, resp);
		if(c==null){
			//redirect already set in getCharacter
			return;
		}
		
		
		if( serializedPlan == null){
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Could not access this page directly, missing parameters!");
		}
		else{

			try {
				c.setBattlePlan( c.deserializeBattlePlan(serializedPlan) );				
			} 
			catch (Exception e) {
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Error saving Battle Plan");
				e.printStackTrace();
			}
			
		}
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_BATTLEPLAN );
		
	}
	
	
	
	
}
