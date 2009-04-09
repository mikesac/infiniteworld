package org.infinite.web.account;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.infinite.objects.Character;
import org.infinite.objects.Map;
import org.infinite.web.PagesCst;

public class StartPlaying extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		
		String chName = req.getParameter("chname");
		String acName = req.getRemoteUser();
		
		if(req.getRemoteUser()==null || chName==null || acName.length()==0 || chName.length()==0)
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_ROOT);
		
		Character c;
		try {
			c = new Character(chName,acName);
		} catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, "Error loading character:"+e.getMessage());
			e.printStackTrace();
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_CHARACTER);
			return;
		}		
		Map m = new Map(c.getArea());
		
		//TODO before saving into context check if some regeneration or effect occurred 
		
		
		req.getSession().setAttribute(PagesCst.CONTEXT_CHARACTER, c);
		req.getSession().setAttribute(PagesCst.CONTEXT_MAP, m);
		
		resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_MAP);
		
		
	}
	
	
	public static boolean redirectToCharSelect(HttpSession s,HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		if(s.getAttribute("character")==null){
			response.sendRedirect(request.getContextPath()+"/player/character.jsp");
			return true;
		}
		return false;
	}
}
