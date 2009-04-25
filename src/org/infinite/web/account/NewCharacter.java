package org.infinite.web.account;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.infinite.db.Manager;
import org.infinite.db.dao.AreaItem;
import org.infinite.db.dao.Player;
import org.infinite.db.dao.TomcatUsers;
import org.infinite.web.PagesCst;

public class NewCharacter extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {


		String err= "New character created";

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		// Parse the request
		try {
			List<FileItem> items = upload.parseRequest(req);

			String charName = "";
			String charPic = "pg_void.png";
			InputStream is = null;
			String szFileName = "";
			String szUser = req.getRemoteUser();

			Iterator iter = items.iterator();			
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();

				if (item.isFormField()) {
					charName = item.getString().trim();
				} else {
					is = item.getInputStream();
					szFileName = item.getName();
				}
			}
			
			//TODO validate username
			if(charName==null || charName.length()==0){
				throw new Exception("Please insert a valid name for your character!");
			}
			
			
			if(is!=null && is.available()>0){
				charPic = charName+"_"+szUser;


				String szPath = this.getServletContext().getRealPath("/imgs/player/");
				szFileName = szFileName.substring( szFileName.lastIndexOf(".") );
				charPic += szFileName;
				szFileName = szPath +"/"+ charPic;

				File f = new File(szFileName);
				f.createNewFile();
				FileOutputStream fos = new FileOutputStream(f);
				byte[] buf = new byte[1024];

				while( is.read(buf) >0 ){
					fos.write(buf);
				}
				fos.flush();
				fos.close();
				is.close();
			}

			List<TomcatUsers> lu = Manager.listByQuery("from org.infinite.db.dao.TomcatUsers u where u.user='"+szUser+"'");
			List<AreaItem> lai = Manager.listByQuery("from org.infinite.db.dao.AreaItem u where u.id='1'");

			charName = charName.replaceAll(" ", "");			
			Player p = new Player(
					lu.get(0),  //user
					lai.get(0),  //Area
					charName,
					charPic,
					5,5,5,5, //str,int,dex,cha
					20,5,10,5, //base
					20,5,10,5, //curr
					(long)0, //stats mod
					1,1,(short)0, //level, px, assign
					0,//status
					0.0f, //gold
					1,"Fists,1d1","" //nattack, attack,battle
					);
			Manager.create(p);

			

		} catch (FileUploadException e) {
			err = e.getMessage();
			e.printStackTrace();
		}
		catch (Exception e) {
			err = e.getMessage();
		}
		req.getSession().setAttribute("error", err);
		resp.sendRedirect( req.getContextPath() +  PagesCst.PAGE_CHARACTER);
		
		
	}

}
