package org.infinite.web.utils;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.Area;
import org.infinite.db.dao.Locks;
import org.infinite.util.GenericUtil;
import org.infinite.web.PagesCst;

public class MapSave extends HttpServlet {

	private static final long serialVersionUID = 8180683124275414176L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {


		try {

			String areaName = req.getParameter("area_name");
			String areaDesc = req.getParameter("area_desc");
			int areaWorld = GenericUtil.toInt(req.getParameter("area_world"),0);
			int areaCost = 	GenericUtil.toInt(req.getParameter("area_cost"),1);
			int areaX = 	GenericUtil.toInt(req.getParameter("area_x"),-1);
			int areaY = 	GenericUtil.toInt(req.getParameter("area_y"),-1);
			String path = req.getParameter("area_path");


			if(areaName==null || areaName.length()==0)
				throw new Exception("Invalid NAME");

			if(areaDesc==null || areaDesc.length()==0)
				throw new Exception("Invalid DESCRIPTION");

			if(areaX<0)
				throw new Exception("Invalid X");

			if(areaY<0)
				throw new Exception("Invalid Y");

			if(path==null || path.length()==0)
				throw new Exception("Error computing path, please re-upload image");



			String destPath = this.getServletContext().getRealPath("/imgs/maps/");
			String patchPath = destPath;// "/vault/InfinteWorld/vpworkspace/InfiniteWeb/WebContent/imgs/maps/";
			File dir = new File(patchPath +"/"+ areaName);
			if(dir.exists())
				throw new Exception("An Area with this name already exist, please rename it");

			dir.mkdir();

			for (int i = 0; i < areaY; i++) {
				for (int j = 0; j < areaX; j++) {

					String src = destPath + "/tmp/crop_" + i + j + ".jpg";
					String dst = patchPath +"/"+ areaName+"/"+areaName+"_" + i + j + ".jpg";
					File f = new File(src);
					if(!f.exists()){
						throw new Exception("Error accessing file, please re-upload image");
					}
					f.renameTo( new File(dst) );					
				}
			}

			Area area = new Area(
					(Locks) Manager.findById(Locks.class.getName(), 3), //TODO handle locks
					areaName,
					areaDesc,
					areaWorld,
					areaX,
					areaY,
					areaCost				
					);
			try{
			Manager.create(area);
			}
			catch (Exception e) {
				throw new Exception("Could not save Area "+areaName + " please contact admin");
			}



		} catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,e.getMessage());
			GenericUtil.err("MapSave Exception", e);
			req.getRequestDispatcher(PagesCst.ADMIN_MAPPREVIEW).forward(req,resp);
		}

		req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,"Area Created");
		req.getRequestDispatcher(PagesCst.ADMIN_MAPUTIL).forward(req,resp);

	}

}
