package org.infinite.web.map;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.infinite.db.Manager;
import org.infinite.db.dao.Item;
import org.infinite.db.dao.Npc;
import org.infinite.db.dao.PlayerOwnItem;
import org.infinite.db.dao.Spell;
import org.infinite.engines.items.ItemsEngine;
import org.infinite.engines.magic.MagicEngine;
import org.infinite.objects.Character;
import org.infinite.util.GenericUtil;
import org.infinite.util.InfiniteCst;
import org.infinite.web.PagesCst;

public class Shop extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {

		
		int action = -1;
		try{
			
			int itemId = GenericUtil.toInt( req.getParameter("it"), -1);
			action = GenericUtil.toInt( req.getParameter("act"), -1);
			
			if(itemId==-1)
				throw new Exception("Invalid item id:"+itemId);
			
			if(action==-1 || action >2)
				throw new Exception("Invalid action id:"+action);
			
			Character c = PagesCst.getCharacter(req, resp);
			if(c==null){
				//redirect already set in getCharacter
				return;
			}
			
			int NpcId = GenericUtil.toInt( c.getAreaItem().getNpcs(),-1);

			if(NpcId==-1){
				throw new Exception("Cannot find NPC id:"+c.getAreaItem().getNpcs() );
			}
			Npc npc = (Npc)Manager.findById(Npc.class.getName(), NpcId);
			
			
			float priceAdj = 1.0f;
			
			switch (action) {
			case InfiniteCst.SHOP_BUY:
				priceAdj = (1.0f * npc.getBaseCha())/c.getDao().getBaseCha();
				Item item = (Item)Manager.findById(Item.class.getName(), itemId);				
				ItemsEngine.buyItem(c,item,priceAdj);
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, item.getName()+" bought!");
				break;
			case InfiniteCst.SHOP_SELL:
				priceAdj = (1.0f * c.getCharisma())/npc.getBaseCha();
				PlayerOwnItem poi = (PlayerOwnItem)Manager.findById(PlayerOwnItem.class.getName(), itemId);
				ItemsEngine.sellItem(c, poi, priceAdj);
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, poi.getItem().getName()+" sold!");
				break;
			case InfiniteCst.SHOP_LEARN:
				priceAdj = (1.0f * npc.getBaseCha())/c.getDao().getBaseCha();
				Spell spell = (Spell)Manager.findById(Spell.class.getName(), itemId);				
				MagicEngine.buySpell(c,spell,priceAdj);
				req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, spell.getName()+" bought!");
				break;
			default:
				throw new Exception("Invalid action id:"+action);
			}
			
			
		}catch (Exception e) {
			req.getSession().setAttribute(PagesCst.CONTEXT_ERROR, e.getMessage());
			GenericUtil.err("Shop", e);
		}
		
		if(action==InfiniteCst.SHOP_LEARN)
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_SSHOP );
		else
			resp.sendRedirect( req.getContextPath() + PagesCst.PAGE_SHOP );
		
				


	}

}
