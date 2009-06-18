<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.infinite.util.GenericUtil"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.Npc"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="org.infinite.engines.items.ItemsEngine"%>
<%

	Character c = (Character) session.getAttribute(PagesCst.CONTEXT_CHARACTER);
	
	int NpcId = GenericUtil.toInt( c.getAreaItem().getNpcs(),-1);

	if(NpcId==-1){
		session.setAttribute(PagesCst.CONTEXT_ERROR, "Cannot find NPC id:"+c.getAreaItem().getNpcs() );
		response.sendRedirect( request.getContextPath() + PagesCst.PAGE_SHOP );
		return;
	}

	Npc npc = (Npc)Manager.findById(Npc.class.getName(), NpcId);
	
	float priceAdj = (1.0f * npc.getBaseCha())/c.getDao().getBaseCha();
	
	ArrayList<Item> list = 	(ArrayList<Item>)Manager.listByQuery("from "+Item.class.getName() + " i where i.lev > '0' and i.lev >= '"+ (npc.getLevel()-1) + "' and i.lev <= '"+ (npc.getLevel()+1)+ "'");
	
%>
{
    "rows":[
    	<% for(int i=0;i<list.size();i++){
    		
    		boolean canBuy=( (c.getGold()>=( priceAdj * list.get(i).getPrice()) ) && ItemsEngine.canUseItem(c,list.get(i))	);
    		%>
    		{
    		"id":<%= list.get(i).getId()%>,
        	"data":[
        		"<%= PagesCst.IMG_ITEM_PATH +  list.get(i).getImage() + PagesCst.IMG_ITEM_EXT%>"
        		,
        		"<b><%= list.get(i).getName()%></b><br/>\
        		<i style='font-size:xx-small;'><%=list.get(i).getDescr()%></i><br/>\
        		<%= (list.get(i).getType()==InfiniteCst.ITEM_TYPE_WEAPON)?"Damage":"Armor Class"%> : <%= list.get(i).getDamage()%><br/>\
        		<%= Math.round(priceAdj * list.get(i).getPrice())%><img width='12' title='Gold' alt='Gold' src='/InfiniteWeb/imgs/web/gp.png'/>"
        		,
        		"<div style='font-size:xx-small;'>\
        		<%=(list.get(i).getReqStr()>c.getDao().getBaseStr())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getReqStr()!=0)?("Str:"+list.get(i).getReqStr())+"<br/>":""%>\
        		</span>\
        		<%=(list.get(i).getReqInt()>c.getDao().getBaseInt())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getReqInt()!=0)?("Int:"+list.get(i).getReqInt()+"<br/>"):""%>\
        		</span>\
        		<%=(list.get(i).getReqDex()>c.getDao().getBaseDex())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getReqDex()!=0)?("Dex:"+list.get(i).getReqDex()+"<br/>"):""%>\
        		</span>\
        		<%=(list.get(i).getReqCha()>c.getDao().getBaseCha())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getReqCha()!=0)?("Cha:"+list.get(i).getReqCha()+"<br/>"):""%>\
        		</span>\
        		<%=(list.get(i).getLev()>c.getLevel())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getLev()!=0)?("Lev:"+list.get(i).getLev()):""%>\
        		</span>\
        		</div>"
        		,
        		"<div style='font-size:xx-small;'>\
        		<%=(list.get(i).getModStr()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getModStr()!=0)?("Str:"+list.get(i).getModStr())+"<br/>":""%>\
        		<%=(list.get(i).getModStr()<0)?"</span>":""%>\
        		<%=(list.get(i).getModInt()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getModInt()!=0)?("Int:"+list.get(i).getModInt()+"<br/>"):""%>\
        		<%=(list.get(i).getModInt()<0)?"</span>":""%>\
        		<%=(list.get(i).getModDex()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getModDex()!=0)?("Dex:"+list.get(i).getModDex()+"<br/>"):""%>\
        		<%=(list.get(i).getModDex()<0)?"</span>":""%>\
        		<%=(list.get(i).getModCha()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getModCha()!=0)?("Cha:"+list.get(i).getModCha()):""%>\
        		<%=(list.get(i).getModCha()<0)?"</span>":""%>\
        		</div>"
        		,
        		"<button onclick='buy(<%= list.get(i).getId()%>)' <%=(canBuy)?"":"disabled='disabled'"%>  >Buy</button>"
        		]
        	}
        	<%=(i==list.size()-1)?"":","%>
    		<%
    	}%>        
    ]
}