package org.infinite.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.objects.Character;

public class PagesCst {

	public static final String STATIC_BASEPATH = "/InfiniteWeb";
	
	//PAGES
	public static final String PAGE_MAPFIGHT = "/player/mapFight.jsp";
	public static final String PAGE_MAPFIGHTREPORT = "/player/mapFightReport.jsp";
	public static final String PAGE_ROOT = "/";
	public static final String PAGE_CHARACTER = "/player/character.jsp";
	public static final String PAGE_MAP = "/player/map.jsp";
	public static final String PAGE_EQUIP = "/player/equip.jsp";
	public static final String PAGE_SPELL = "/player/spell.jsp";
	public static final String PAGE_SPELLBOOK = "/player/spellbook.jsp";
	public static final String PAGE_STATUS = "/player/status.jsp";
	public static final String PAGE_REGISTER = "/login/register.jsp";
	public static final String PAGE_BATTLEPLAN= "/player/battleplan.jsp";
	public static final String PAGE_NPCDIALOG= "/player/npcdialog.jsp";
	
	//IMAGES
	public static final String IMG_ITEM_EXT= ".jpg";
	public static final String IMG_ITEM_PATH= STATIC_BASEPATH  + "/imgs/item/";
	
	public static final String IMG_SPELL_EXT= ".jpg";
	public static final String IMG_SPELL_PATH= STATIC_BASEPATH  + "/imgs/spell/";
	
	public static final String IMG_MONST_EXT= ".jpg";
	public static final String IMG_MONST_PATH= STATIC_BASEPATH  + "/imgs/monster/";
	
	public static final String CONTEXT_CHARACTER = "character";
	public static final String CONTEXT_ERROR = "error";
	public static final String CONTEXT_MAP = "map";
	public static final String CONTEXT_MAPITEM = "map_item";
	public static final String CONTEXT_SPELLTYPE = "spell_type";
	public static final String CONTEXT_SPELLPAGE = "spell_page";
	public static final String CONTEXT_FIGHT_REPORT = "fight_report";
	
	public static final String CONTEXT_SPELLBOOK = "spell_book";
	
	public static final String CONTEXT_FIGHT_REPORT_S1 = "fight_report_s1";
	public static final String CONTEXT_FIGHT_REPORT_S2= "fight_report_s2";

	public static final String ADMIN_HOME = "/admin/adminHome.jsp";
	public static final String ADMIN_MAPPREVIEW = "/admin/map/mapUtilPreview.jsp";
	
	public static final String ADMIN_MAPUTIL = 	"/admin/map/mapUtil.jsp";
	public static final String ADMIN_MAPLIST = 	"/admin/map/listArea.jsp";
	public static final String ADMIN_MAPITEMS = "/admin/map/mapItems.jsp";
	
	public static Character getCharacter(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
		Character c = (Character) req.getSession().getAttribute(CONTEXT_CHARACTER);
		
		if(c==null){
			req.getSession().setAttribute(CONTEXT_ERROR, "Character not found! Please re-login.");
			resp.sendRedirect( req.getContextPath() );
		}
		return c;
	}
	
	
	
	
	
	
}
