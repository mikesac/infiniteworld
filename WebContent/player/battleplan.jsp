<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.objects.Character"%>
<%
	if (StartPlaying.redirectToCharSelect(session, request, response))
		return;

	Character c = (Character) session
			.getAttribute(PagesCst.CONTEXT_CHARACTER);
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.PlayerOwnItem"%>
<%@page import="org.infinite.db.dao.PlayerKnowSpell"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Battle Strategy</title>
</head>
<body>

<%
	if (session.getAttribute("error") != null) {
%><%@ include file="../decorators/b2pre.jsp"%>
<div align="center">
<div class="error"><%=session.getAttribute("error")%></div>
</div>
<%@ include file="../decorators/b2post.jsp"%><br />
<%
	session.removeAttribute("error");
	}
%>


<div style="width: 1020px;"><%@ include
	file="../decorators/b1pre.jsp"%>

<table>
	<tr>
		<td width="80px">
		<center><img src="../imgs/web/btl/sword.png" /></center>
		</td>
		<td style="width: 200px;" valign="top"><%@ include
			file="../decorators/b2pre.jsp"%>
		<center>

		<table>
			<tr>
				<td>Equipped weapon</td>
			</tr>
			<tr>
				<td>
				<div class="equipped">
				<%
					PlayerOwnItem poi = c.getHandRightPoi();
					if (poi != null) {
				%>
				<div class="iconlarge"
					style="background-image: url(<%=request.getContextPath()%>/imgs/item/<%=poi.getItem().getImage()%>.png);">
				<div class="tile" /></div>
				<%
					}
				%>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<%if (poi != null) { %>
				<button onclick="addAttack('<%= poi.getId() %>','<%= poi.getItem().getName() %>','<%= poi.getItem().getImage() %>')">Add &gt;&gt;</button>
				<%} %>
				</td>
			</tr>

			<tr>
				<td>Prepared spells</td>
			</tr>
			<tr>
				<td><select id="spellsel" onchange="changeSpellImg(this)">
					<%
						for (int i = 0; i < c.getPreparedSpells().size(); i++) {
					%><option
						value="<%=c.getPreparedSpells().get(i).getSpell().getId()%>"
						img="<%=c.getPreparedSpells().get(i).getSpell().getImage()%>">
					<%=c.getPreparedSpells().get(i).getSpell().getName()%></option>
					<%
						}
					%>
				</select></td>
			</tr>
			<tr>
				<td>
				<div class="equipped">
				<% 
							
							if(c.getPreparedSpells().size()!=0){
								%>
									<div id="spell_ico" class="iconlarge" style="background-image: url(<%= request.getContextPath() %>/imgs/spell/<%=c.getPreparedSpells().get(0).getSpell().getImage()%>.png);">
										<div class="tile"/>
									</div>
								<%
							}
							
						%>
				
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<button onclick="addSpell()">Add &gt;&gt;</button>
				</td>
			</tr>
			<tr>
				<td>Special Items</td>
			</tr>
			<tr>
				<td><select></select></td>
			</tr>
			<tr>
				<td>
				<div class="equipped"></div>
				</td>
			</tr>
			<tr>
				<td>
				<button>Add &gt;&gt;</button>
				</td>
			</tr>
		</table>

		</center>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
		<td style="width: 700px;" valign="top"><%@ include
			file="../decorators/b2pre.jsp"%>
		<center>Choose your attack strategy. ( <%=c.getAvailableAttackSlot()%> slots left)<br />
		One action will be performed on each round in the chosen order in a
		loop.<br />
		Action slots will increase leveling up.</center>
		<%@ include file="../decorators/b2post.jsp"%>
		<br />
		<%@ include file="../decorators/b2pre.jsp"%>
		<div style="width: 640px; height: 400px; overflow: auto;">
		<div id="battleplan" >		
				
			<%for(int i=0;i<c.getBattlePlan().size();i++){
				%><table width="600px" class="char"><tr><%
				if(c.getBattlePlan().get(i) instanceof PlayerOwnItem){
					PlayerOwnItem o = (PlayerOwnItem)c.getBattlePlan().get(i);
					%>
					<td align="center"  width="50px"><%=i%></td>
					<td><%=o.getItem().getName() %></td>			
					<td width="70px">
						<div class="iconlarge" style="background-image: url(../imgs/item/<%=o.getItem().getImage()%>.png);">
							<div class="tile"/>
						</div>
					</td>
					<td>(A<%=o.getId()%>)</td>
					<%					
				}
				else if(c.getBattlePlan().get(i) instanceof PlayerKnowSpell){
					PlayerKnowSpell o = (PlayerKnowSpell)c.getBattlePlan().get(i);
					%>
					<td><%=i%></td>
					<td><%=o.getSpell().getName() %></td>			
					<td>
						<div class="iconlarge" style="background-image: url(../imgs/spell/<%=o.getSpell().getImage()%>.png);">
							<div class="tile"/>
						</div>
					</td>
					<td>S<%=o.getId()%></td>
					
					<%	
				}
				else{
					//TODO item
				}
				%>
				<td class="<%=(i>0)?"up":"nobut;" %>">&nbsp;</td>
				<td class="<%=(i!=(c.getBattlePlan().size()-1))?"down":"nobut;" %>">&nbsp;</td>
				<td class="rem" >&nbsp;</td>
			</tr>
			</table>
			
			<%}%>
		</div>
		<%@ include file="../decorators/b2post.jsp"%>
		</div>

		<input type="text" id="serialized" value="<%=c.getDao().getBattle() %>"/>
		</td>
		<td width="80px">
		<center><img src="../imgs/web/btl/wand.png" /></center>
		</td>
	</tr>
</table>

<%@ include file="../decorators/b1post.jsp"%></div>
</div>

<script>

function changeSpellImg(el){
	var img = el.options[el.selectedIndex].getAttribute("img");
	document.getElementById("spell_ico").style.backgroundImage = "url(../imgs/spell/"+img+".png)";	
}

function addPlan(id,name,imag,type,path){
	var tab = document.createElement("table");
	tab.className="char";
	tab.style.width="600px";
	var tb = document.createElement("tbody");
	var tr = document.createElement("tr");
	var td1 = document.createElement("td");
	td1.style.width="50px";
	td1.style.align="center";
	td1.innerHTML = "N";
	var td2 = document.createElement("td");
	td2.innerHTML = name;
	var td3 = document.createElement("td");
	td3.style.width="70";
	td3.innerHTML = "<div style=\"background-image: url(../imgs/"+path+"/"+imag+".png);\" class=\"iconlarge\"><div class=\"tile\"></div>";
	var td = document.createElement("td");
	td.innerHTML = "("+type+id+")";
	var td4 = document.createElement("td");
	td4.className = "up";
	var td5 = document.createElement("td");
	td5.className = "down";
	var td6 = document.createElement("td");
	td6.className = "rem";
	
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	tr.appendChild(td);
	tr.appendChild(td4);
	tr.appendChild(td5);
	tr.appendChild(td6);
	tb.appendChild(tr);
	tab.appendChild(tb);
	document.getElementById("battleplan").appendChild(tab);
}

function addAttack(id,name,imag){
	addPlan(id,name,imag,"A","item");
}

function addSpell(){

	var el = document.getElementById("spellsel");
	var id = el.options[el.selectedIndex].value;
	var name = el.options[el.selectedIndex].innerHTML;
	var imag = el.options[el.selectedIndex].getAttribute("img");
	addPlan(id,name,imag,"S","spell");
}
</script>
</body>
</html>