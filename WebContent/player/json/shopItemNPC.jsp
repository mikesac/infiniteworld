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
        		<%= Math.round(priceAdj * list.get(i).getPrice())%><img width='12' title='Gold' alt='Gold' src='/InfiniteWeb/imgs/web/gp.png'/>\
        		&nbsp;&nbsp;Level:\
        		<%=(list.get(i).getLev()>c.getLevel())?"<span style='color:red'>":"<span style='color:green'>"%>\
        		<%=list.get(i).getLev()%>\
        		</span>\
        		"
        		,
        		"<table border='0'>\
        			<tr>\
        				<td style='border:0px;'><img title='Strenght' alt='Strenght' src='/InfiniteWeb/imgs/web/str.png'/></td>\
        				<td style='border:0px;' width='21px'>\
        					<%=(list.get(i).getReqStr()>c.getDao().getBaseStr())?"<span style='color:red'>":"<span style='color:green'>"%>\
        					<%=list.get(i).getReqStr()%>\
        					</span>\
        				</td>\
        				<td style='border:0px;' ><img title='Intelligence' alt='Intelligence' src='/InfiniteWeb/imgs/web/int.png'/></td>\
        				<td style='border:0px;' width='21px'>\
        					<%=(list.get(i).getReqInt()>c.getDao().getBaseInt())?"<span style='color:red'>":"<span style='color:green'>"%>\
        					<%=list.get(i).getReqInt()%>\
        					</span>\
        				</td>\
        			</tr>\
        			<tr>\
        				<td style='border:0px;'><img title='Dexterity' alt='Dexterity' src='/InfiniteWeb/imgs/web/dex.png'/></td>\
        				<td style='border:0px;'>\
        					<%=(list.get(i).getReqDex()>c.getDao().getBaseDex())?"<span style='color:red'>":"<span style='color:green'>"%>\
        					<%=list.get(i).getReqDex()%>\
        					</span>\
        				</td>\
        				<td style='border:0px;'><img title='Charisma' alt='Charisma' src='/InfiniteWeb/imgs/web/cha.png'/></td>\
        				<td style='border:0px;'>\
        					<%=(list.get(i).getReqCha()>c.getDao().getBaseCha())?"<span style='color:red'>":"<span style='color:green'>"%>\
        					<%=list.get(i).getReqCha()%>\
        					</span>\
        				</td>\
        			</tr>\
        		</table>"
        		,
        		"<table border='0'>\
        			<tr>\
        				<td style='border:0px;'><img title='Strenght' alt='Strenght' src='/InfiniteWeb/imgs/web/str.png'/></td>\
        				<td style='border:0px;' width='21px'>\
        					<%=(list.get(i).getModStr()<0)?"<span style='color:red'>":""%>\
        					<%=list.get(i).getModStr()%>\
        					<%=(list.get(i).getModStr()<0)?"</span>":""%>\
        				</td>\
        				<td style='border:0px;' ><img title='Intelligence' alt='Intelligence' src='/InfiniteWeb/imgs/web/int.png'/></td>\
        				<td style='border:0px;' width='21px'>\
        					<%=(list.get(i).getModInt()<0)?"<span style='color:red'>":""%>\
        					<%=list.get(i).getModInt()%>\
        					<%=(list.get(i).getModInt()<0)?"</span>":""%>\
        				</td>\
        			</tr>\
        			<tr>\
        				<td style='border:0px;'><img title='Dexterity' alt='Dexterity' src='/InfiniteWeb/imgs/web/dex.png'/></td>\
        				<td style='border:0px;'>\
        					<%=(list.get(i).getModDex()<0)?"<span style='color:red'>":""%>\
        					<%=list.get(i).getModDex()%>\
        					<%=(list.get(i).getModDex()<0)?"</span>":""%>\
        				</td>\
        				<td style='border:0px;'><img title='Charisma' alt='Charisma' src='/InfiniteWeb/imgs/web/cha.png'/></td>\
        				<td style='border:0px;'>\
        					<%=(list.get(i).getModCha()<0)?"<span style='color:red'>":""%>\
        					<%=list.get(i).getModCha()%>\
        					<%=(list.get(i).getModCha()<0)?"</span>":""%>\
        				</td>\
        			</tr>\
        		</table>"
        		,
        		"<button onclick='buy(<%= list.get(i).getId()%>)' <%=(canBuy)?"":"disabled='disabled'"%>  >Buy</button>"
        		]
        	}
        	<%=(i==list.size()-1)?"":","%>
    		<%
    	}%>        
    ]
}