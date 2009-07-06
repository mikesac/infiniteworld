package org.infinite.web.utils;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.AreaItem;
import org.infinite.util.GenericUtil;
import org.infinite.web.PagesCst;

public class AreaItemSave extends HttpServlet {

	private static final long serialVersionUID = 8180683124275414176L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {

		int areaId = -1;
		try {

			String action = req.getParameter("act");
			
			areaId = GenericUtil.toInt(req.getParameter("areaid"),-1); 	
			
			if(areaId==-1)
				throw new Exception("Invalid AREA ID");
			
			String aiName = "NewAreaItem"; 	
			String aiIcon = "temp"; 	
			int aiCost = 0; 	
			int aiAreaX = 0; 	
			int aiAreaY = 0; 	
			int aiX = 0; 	
			int aiY = 0; 	
			String aiLock = ""; 	
			String aiQLock = ""; 	
			String aiUrl = ""; 	
			boolean aidoublestep = false; 	
			boolean aiHide = false; 	
			int aiLevel = 0; 	
			String aiNpcs = "";
			
			if(action.equals("0")){
				
				try{
					AreaItem ai = new AreaItem(aiName, aiIcon, aiCost, areaId,
							 (short)aiAreaX, (short)aiAreaY, aiX, aiY, aiLock,aiQLock, aiUrl,  
							 aidoublestep, aiHide, aiLevel, aiNpcs);
					
					Manager.create(ai);
					}
					catch (Exception e) {
						throw new Exception("Could not save Area "+aiName + " please contact admin");
					}
			}else{
				 int aiId = GenericUtil.toInt(req.getParameter("id"),-1);  	
				 aiName = req.getParameter("name"); 	
				 aiIcon = req.getParameter("icon"); 	
				 aiCost = GenericUtil.toInt(req.getParameter("cost"),-1); 	
				 aiAreaX = GenericUtil.toInt(req.getParameter("areax"),-1); 	
				 aiAreaY = GenericUtil.toInt(req.getParameter("areay"),-1); 	
				 aiX = GenericUtil.toInt(req.getParameter("x"),-999); 	
				 aiY = GenericUtil.toInt(req.getParameter("y"),-999); 	
				 aiLock = req.getParameter("arealock"); 	
				 aiQLock = req.getParameter("questlock"); 	
				 aiUrl = req.getParameter("url"); 	
				 aidoublestep = ( (""+req.getParameter("loop")).equals("true") || (""+req.getParameter("loop")).equals("on") ); 	 	
				 aiHide = ( (""+req.getParameter("hide")).equals("true") || (""+req.getParameter("hide")).equals("on") ); 	 	
				 aiLevel = GenericUtil.toInt(req.getParameter("areaItemLevel"),-1); 	
				 aiNpcs = req.getParameter("npcs");
				 
				 if(aiId==-1)
						throw new Exception("Invalid ID");
				 if(aiName==null || aiName.length()==0)
						throw new Exception("Invalid NAME");
				 if(aiIcon==null || aiIcon.length()==0)
						throw new Exception("Invalid ICON");
				 if(aiCost==-1)
						throw new Exception("Invalid COST");
				 if(aiAreaX==-1)
						throw new Exception("Invalid AreaX");
				 if(aiAreaY==-1)
						throw new Exception("Invalid aiAreaY");
				 if(aiX==-999)
						throw new Exception("Invalid X");
				 if(aiY==-999)
						throw new Exception("Invalid Y");
				 if(aiLock==null )
						throw new Exception("Invalid AREA LOCK");
				 if(aiQLock==null )
						throw new Exception("Invalid QUEST LOCK");
				 if(aiUrl==null || aiUrl.length()==0)
						throw new Exception("Invalid URL");
				 if(aiLevel==-1)
						throw new Exception("Invalid LEVEL");
				 if(aiNpcs==null )
						throw new Exception("Invalid NPCs");
				 
				 try{
					 AreaItem ai = (AreaItem) Manager.findById(AreaItem.class.getName(), aiId);
					 ai.setName(aiName);
					 ai.setIcon(aiIcon);
					 ai.setCost(aiCost);
					 //ai.setAreaid(areaId);
					 ai.setAreax((short)aiAreaX);
					 ai.setAreay((short)aiAreaY);
					 ai.setX(aiX);
					 ai.setY(aiY);
					 ai.setArealock(aiLock);
					 ai.setQuestlock(aiQLock);
					 ai.setUrl(aiUrl);
					 ai.setDoublestep(aidoublestep);
					 ai.setHidemode(aiHide);
					 ai.setAreaItemLevel(aiLevel);
					 ai.setNpcs(aiNpcs);
				 
				 Manager.update(ai);
				 }
					catch (Throwable e) {
						throw new Exception("Could not update Area "+aiName + " please contact admin");
					}
				 
			}
			

			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,"Area Item Saved");


		} catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR,e.getMessage());
			GenericUtil.err("AreaItemSave Exception", e);
		}

		resp.sendRedirect( req.getContextPath() + PagesCst.ADMIN_MAPITEMS+"?areaid="+areaId );
		

	}

}
