package org.infinite.web.account;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.web.PagesCst;

public class Logout extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {

		//save all player data to DB before closing
		
		req.getSession().invalidate();

		resp.sendRedirect( req.getContextPath() +  PagesCst.PAGE_ROOT);
		
	}

	
}