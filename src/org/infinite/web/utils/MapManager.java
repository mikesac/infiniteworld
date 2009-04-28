package org.infinite.web.utils;

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
import org.infinite.util.GenericUtil;
import org.infinite.util.ImageUtil;

public class MapManager extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {


		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

		// Parse the request
		try {
			List<FileItem> items = upload.parseRequest(req);

			InputStream is = null;

			Iterator iter = items.iterator();			
			String szFileName = "error.png";

			int nx = 1,ny = 1;
			
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();

				if (item.isFormField()) {
					String name = item.getFieldName();
					if(name.equalsIgnoreCase("x"))
						nx = GenericUtil.toInt(item.getString(), 1);
					else
						ny = GenericUtil.toInt(item.getString(), 1);
				}
				else{
					is = item.getInputStream();
					szFileName = item.getName();
				}
			}

			String szPath ="";
			if(is!=null && is.available()>0){

				szPath = this.getServletContext().getRealPath("/imgs/maps/tmp");
				ImageUtil.prepareMapStripes(is,nx,ny,szPath);
//				File f = new File("/tmp/test.png");
//				ImageIO.write(bi, "png", f);

			}
			
			req.getSession().setAttribute("nx", nx);
			req.getSession().setAttribute("ny", ny);
			req.getSession().setAttribute("path", szPath);
			
			req.getRequestDispatcher("/admin/map/mapUtilPreview.jsp").forward(req,resp);
			

		} catch (FileUploadException e) {

			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}



	}

}
