package org.infinite.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.objects.Character;

public class PagesCst {

	
	public static final String PAGE_MAPFIGHT = "/player/mapFight.jsp";
	public static final String PAGE_ROOT = "/";
	public static final String PAGE_CHARACTER = "/player/character.jsp";
	public static final String PAGE_MAP = "/player/map.jsp";
	public static final String PAGE_EQUIP = "/player/equip.jsp";
	public static final String PAGE_SPELL = "/player/spell.jsp";
	public static final String PAGE_REGISTER = "/login/register.jsp";
	public static final String PAGE_BATTLEPLAN= "/player/battleplan.jsp";
	
	public static final String CONTEXT_CHARACTER = "character";
	public static final String CONTEXT_ERROR = "error";
	public static final String CONTEXT_MAP = "map";
	public static final String CONTEXT_SPELLTYPE = "spell_type";
	public static final String CONTEXT_SPELLPAGE = "spell_page";
	
	public static Character getCharacter(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
		Character c = (Character) req.getSession().getAttribute(CONTEXT_CHARACTER);
		
		if(c==null){
			req.getSession().setAttribute(CONTEXT_ERROR, "Character not found! Please re-login.");
			resp.sendRedirect( req.getContextPath() );
		}
		return c;
	}
	
	
	
	
	
	
}
