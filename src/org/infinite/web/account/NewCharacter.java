package org.infinite.web.account;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.Player;
import org.infinite.db.dao.TomcatUsers;

public class NewCharacter extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
		
		
		String err= "New character created";
		
		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		// Parse the request
		try {
			List<FileItem> items = upload.parseRequest(req);
			
			String charName = "anonymous";
			String charPic = "pg_void.png";
			InputStream is = null;
			
			Iterator iter = items.iterator();			
			while (iter.hasNext()) {
			    FileItem item = (FileItem) iter.next();

			    if (item.isFormField()) {
			    	charName = item.getString().trim();
			    } else {
			        is = item.getInputStream();
			        
			    }
			}
			if(is!=null && is.available()>0){
				String now = ""+(new Date()).getTime();
				charPic = charName+"_"+now;
			}	
			
			List<TomcatUsers> lu = Manager.listByQery("from org.infinite.db.dao.TomcatUsers u where u.user='"+req.getUserPrincipal().getName()+"'");
			List<Area> la = Manager.listByQery("from org.infinite.db.dao.Area u where u.id='1'");
						
			Player p = new Player();
			p.setName(charName);			
			charName = charName.replaceAll(" ", "");			
			p.setImage( charPic );
			p.setTomcatUsers( lu.get(0) );
			p.setArea( la.get(0) );
			Manager.create(p);
			
			
				
				
			

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/player/character.jsp");
			dispatcher.forward(req,resp);
			
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		req.setAttribute("error", err);
	}
	
	}
