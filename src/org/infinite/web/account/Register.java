package org.infinite.web.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.engines.account.AccountEngine;
import org.infinite.web.PagesCst;

public class Register extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {

		String err = "";
		String next = PagesCst.PAGE_REGISTER;


			try{

				String user = req.getParameter("username");
				String pass = req.getParameter("password");
				String email = req.getParameter("email");
				String captchaId = req.getSession().getId();
				String captchaResponse = req.getParameter("j_captcha_response");

				AccountEngine.registerNewUser(user, pass, email, captchaId, captchaResponse);
				
				err ="Account created,login as "+user;
				next = PagesCst.PAGE_ROOT;
			}
			catch (Exception e) {
				err = e.getMessage();
			}

		req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, err);
		resp.sendRedirect( req.getContextPath() + next);
		
	}

}