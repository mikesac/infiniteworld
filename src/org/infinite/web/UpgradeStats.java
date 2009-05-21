package org.infinite.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.objects.Character;
import org.infinite.util.GenericUtil;

public class UpgradeStats extends HttpServlet {

	private static final long serialVersionUID = 8147788760105886310L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {

		try{
			
			int type = GenericUtil.toInt( req.getParameter("attType") , -1);

			Character c = PagesCst.getCharacter(req, resp);
			if(c==null)
				return;

			if( type == -1 ){
				throw new Exception("Could not access this page directly, missing parameters!");
			}
			
			if( c.getDao().getAssign() <= 0 ){
				throw new Exception("No points to assign!");
			}
						
			c.upgradeStatus(type);
						
		}
		catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, e.getMessage());
		}
		
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_STATUS );
	}

}
