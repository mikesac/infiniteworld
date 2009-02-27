package org.infinite.web.account;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.TomcatRoles;
import org.infinite.db.dao.TomcatUsers;

import com.octo.captcha.service.CaptchaServiceException;

public class Register extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {

		String err = "";
		String next = "/login/register.jsp";

		if(validateCaptchaForId(req))
		{

			try{

				String user = req.getParameter("username");
				String pass = req.getParameter("password");
				String email = req.getParameter("email");



				if(user==null || user.length()==0 ){
					throw new Exception("Invalid Username");
				}

				if(pass==null || pass.length()==0 ){
					throw new Exception("Invalid Password");
				}

				if(email==null || email.length()==0 || email.indexOf("@")==-1){
					throw new Exception("Invalid email");
				}

				List<TomcatUsers> l = Manager.listByQery("select u from TomcatUsers u where u.user='"+user+"' or u.email='"+email+"'");

				if(l.size()!=0){
					throw new Exception("USERNAME or EMAIL already in use, please choose a different ones");
				}
				
				TomcatUsers u = new TomcatUsers(user,pass,email);
				TomcatRoles r = new TomcatRoles(user,u,"player");
				Manager.create(u);
				Manager.create(r);
				

				err ="Account created,login as "+user;
				next = "/index.jsp";
			}
			catch (Exception e) {
				err = e.getMessage();
			}

		}
		else{
			err ="incorrect captcha";

		}
		req.setAttribute("error", err);

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(next);
		dispatcher.forward(req,resp);
	}

	private boolean validateCaptchaForId(HttpServletRequest req) {

		boolean isResponseCorrect = false;
		//awe need an id to validate!
		String captchaId = req.getSession().getId();
		// retrieve the response
		String response = req.getParameter("j_captcha_response");
		// Call the Service method
		try {
			isResponseCorrect = CaptchaServiceSingleton.getInstance()
			.validateResponseForID(captchaId, response);
		} catch (CaptchaServiceException e) {
			// should not happen, may be thrown if the id is not valid
		}

		return isResponseCorrect;
	}

}