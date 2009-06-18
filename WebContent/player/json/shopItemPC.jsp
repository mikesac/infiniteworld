<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.PlayerOwnItem"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.Npc"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="org.infinite.util.GenericUtil"%>

<%Character c = (Character) session.getAttribute(PagesCst.CONTEXT_CHARACTER);
ArrayList<PlayerOwnItem> list =  c.getInventory();

int NpcId = GenericUtil.toInt( c.getAreaItem().getNpcs(),-1);

if(NpcId==-1){
	session.setAttribute(PagesCst.CONTEXT_ERROR, "Cannot find NPC id:"+c.getAreaItem().getNpcs() );
	response.sendRedirect( request.getContextPath() + PagesCst.PAGE_SHOP );
	return;
}

Npc npc = (Npc)Manager.findById(Npc.class.getName(), NpcId);

float priceAdj = (1.0f * c.getCharisma())/npc.getBaseCha();

%>
{
    "rows":[
    	<% for(int i=0;i<list.size();i++){
    		%>
    		{
    		"id":<%= list.get(i).getId()%>,
        	"data":[
        		"<%= PagesCst.IMG_ITEM_PATH +  list.get(i).getItem().getImage() + PagesCst.IMG_ITEM_EXT%>"
        		,
        		"<b><%= list.get(i).getItem().getName()%></b><br/>\
        		<i style='font-size:xx-small;'><%=list.get(i).getItem().getDescr()%></i><br/>\
        		<%= (list.get(i).getItem().getType()==InfiniteCst.ITEM_TYPE_WEAPON)?"Damage":"Armor Class"%> : <%= list.get(i).getItem().getDamage()%><br/>\
        		<%= Math.round(priceAdj*0.5f*list.get(i).getItem().getPrice())%><img width='12' title='Gold' alt='Gold' src='/InfiniteWeb/imgs/web/gp.png'/>"
        		,
        		"<div style='font-size:xx-small;'>\
        		<%=(list.get(i).getItem().getReqStr()>c.getDao().getBaseStr())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getItem().getReqStr()!=0)?("Str:"+list.get(i).getItem().getReqStr())+"<br/>":""%>\
        		</span>\
        		<%=(list.get(i).getItem().getReqInt()>c.getDao().getBaseInt())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getItem().getReqInt()!=0)?("Int:"+list.get(i).getItem().getReqInt()+"<br/>"):""%>\
        		</span>\
        		<%=(list.get(i).getItem().getReqDex()>c.getDao().getBaseDex())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getItem().getReqDex()!=0)?("Dex:"+list.get(i).getItem().getReqDex()+"<br/>"):""%>\
        		</span>\
        		<%=(list.get(i).getItem().getReqCha()>c.getDao().getBaseCha())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=(list.get(i).getItem().getReqCha()!=0)?("Cha:"+list.get(i).getItem().getReqCha()):""%>\
        		</span>\
        		</div>"
        		,
        		"<div style='font-size:xx-small;'>\
        		<%=(list.get(i).getItem().getModStr()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getItem().getModStr()!=0)?("Str:"+list.get(i).getItem().getModStr())+"<br/>":""%>\
        		<%=(list.get(i).getItem().getModStr()<0)?"</span>":""%>\
        		<%=(list.get(i).getItem().getModInt()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getItem().getModInt()!=0)?("Int:"+list.get(i).getItem().getModInt()+"<br/>"):""%>\
        		<%=(list.get(i).getItem().getModInt()<0)?"</span>":""%>\
        		<%=(list.get(i).getItem().getModDex()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getItem().getModDex()!=0)?("Dex:"+list.get(i).getItem().getModDex()+"<br/>"):""%>\
        		<%=(list.get(i).getItem().getModDex()<0)?"</span>":""%>\
        		<%=(list.get(i).getItem().getModCha()<0)?"<span style='color:red'>":""%>\
        		<%=(list.get(i).getItem().getModCha()!=0)?("Cha:"+list.get(i).getItem().getModCha()):""%>\
        		<%=(list.get(i).getItem().getModCha()<0)?"</span>":""%>\
        		</div>"
        		,
        		"<button onclick='sell(<%= list.get(i).getId()%>)'>Sell</button>"
        		]
        	}
        	<%=(i==list.size()-1)?"":","%>
    		<%
    	}%>        
    ]
}