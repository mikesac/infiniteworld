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
				<td align="center">Equipped weapon</td>
			</tr>
			<tr>
				<td align="center">
				<div class="equipped">
				<%
					PlayerOwnItem poi = c.getHandRightPoi();
					if (poi != null) {
				%>
				<div class="iconlarge"
					style="background-image: url(<%=PagesCst.IMG_ITEM_PATH +  poi.getItem().getImage() + PagesCst.IMG_ITEM_EXT%>);">
				<div class="tile" /></div>
				<%
					}
				%>
				</div>
				</td>
			</tr>
			<tr>
				<td align="center">
				<%if (poi != null) { %>
				<button onclick="addAttack('<%= poi.getId() %>','<%= poi.getItem().getName() %>','<%= poi.getItem().getImage() %>')">Add &gt;&gt;</button>
				<%} %>
				</td>
			</tr>

			<tr>
				<td align="center">Prepared spells</td>
			</tr>
			<tr>
				<td align="center"><select id="spellsel" onchange="changeSpellImg(this)">
					<%
						for (int i = 0; i < c.getPreparedSpells().size(); i++) {
					%><option
						value="<%=c.getPreparedSpells().get(i).getId()%>"
						img="<%=c.getPreparedSpells().get(i).getSpell().getImage()%>">
					<%=c.getPreparedSpells().get(i).getSpell().getName()%></option>
					<%
						}
					%>
				</select></td>
			</tr>
			<tr>
				<td align="center">
				<div class="equipped">
				<% 
							
							if(c.getPreparedSpells().size()!=0){
								%>
									<div id="spell_ico" class="iconlarge" style="background-image: url(<%= PagesCst.IMG_SPELL_PATH + c.getPreparedSpells().get(0).getSpell().getImage() +PagesCst.IMG_SPELL_EXT%>);">
										<div class="tile"/>
									</div>
								<%
							}
							
						%>
				
				</div>
				</td>
			</tr>
			<tr>
				<td align="center">
				<button onclick="addSpell()">Add &gt;&gt;</button>
				</td>
			</tr>
			<tr>
				<td align="center">Special Items</td>
			</tr>
			<tr>
				<td align="center"><select></select></td>
			</tr>
			<tr>
				<td align="center">
				<div class="equipped"></div>
				</td>
			</tr>
			<tr>
				<td align="center">
				<button>Add &gt;&gt;</button>
				</td>
			</tr>
			<tr>
				<td align="center">
					<input id="slots" type="text" size="2" readonly="readonly" value="<%=c.getAvailableAttackSlot()%>"/> slots left
				</td>
			</tr>
			<tr>
				<td align="center">
					<form method="post" action="<%=request.getContextPath()%>/battlePlan">
					<input type="hidden" id="serialized" name="serialized" value="<%=c.getDao().getBattle() %>" />
					<input type="submit" value="Save Plan">
					</form>
				</td>
			</tr>
		</table>

		</center>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
		<td style="width: 700px;" valign="top"><%@ include
			file="../decorators/b2pre.jsp"%>
		<center>Choose your attack strategy.<br/>
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
					<td width="200px"><%=o.getItem().getName() %></td>			
					<td width="70px">
						<div class="iconlarge" style="background-image: url(<%= PagesCst.IMG_ITEM_PATH + o.getItem().getImage() + PagesCst.IMG_ITEM_EXT %>);">
							<div class="tile"/>
						</div>
					</td>
					<td><input type="hidden" value="A<%=o.getId()%>"/></td>
					<%					
				}
				else if(c.getBattlePlan().get(i) instanceof PlayerKnowSpell){
					PlayerKnowSpell o = (PlayerKnowSpell)c.getBattlePlan().get(i);
					%>
					<td><%=i%></td>
					<td width="200px"><%=o.getSpell().getName() %></td>			
					<td>
						<div class="iconlarge" style="background-image: url(<%= PagesCst.IMG_SPELL_PATH +  o.getSpell().getImage() + PagesCst.IMG_SPELL_EXT%>);">
							<div class="tile"/>
						</div>
					</td>
					<td><input type="hidden" value="S<%=o.getId()%>"/></td>
					
					<%	
				}
				else{
					//TODO item
				}
				%>
				<td onclick="moveUp(this)" class="up">&nbsp;</td>
				<td onclick="moveDwn(this)" class="down">&nbsp;</td>
				<td onclick="remPlan(this)" class="<%=(c.getBattlePlan().get(i) instanceof PlayerOwnItem )?"nobut":"rem" %>" >&nbsp;</td>
			</tr>
			
			</table>
			
			<%}%>
		</div>
		<%@ include file="../decorators/b2post.jsp"%>
		</div>

		
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
	document.getElementById("spell_ico").style.backgroundImage = "url(<%= PagesCst.IMG_SPELL_PATH%>"+img+"<%=PagesCst.IMG_SPELL_EXT%>)";	
}

function remPlan(el){
	if(confirm("Remove this attack from the plan?")){
		document.getElementById("battleplan").removeChild(el.parentNode.parentNode.parentNode);
		document.getElementById("slots").value = parseInt( document.getElementById("slots").value) + 1;
		getAllCodes();
	}
}

function moveUp(el){
	document.getElementById("battleplan").insertBefore(el.parentNode.parentNode.parentNode, el.parentNode.parentNode.parentNode.previousSibling);
	getAllCodes();
}

function moveDwn(el){
	document.getElementById("battleplan").insertBefore(el.parentNode.parentNode.parentNode.nextSibling,el.parentNode.parentNode.parentNode);
	getAllCodes();
}


function addPlan(id,name,imag,type,path){

	if( ! checkSlots() ){
		alert("No more slots available");
		return;
	}
	
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
	td2.style.width = "200px";
	td2.innerHTML = name;
	var td3 = document.createElement("td");
	td3.style.width="70";
	
	var inhtml = "<div style=\"background-image: url(";
	
	if(path=="item"){
		inhtml += "<%= PagesCst.IMG_ITEM_PATH %>"+imag+"<%= PagesCst.IMG_ITEM_EXT %>";
	}
	else {
		inhtml += "<%= PagesCst.IMG_SPELL_PATH %>"+imag+"<%= PagesCst.IMG_SPELL_EXT %>";
	}
	
	inhtml += ");\" class=\"iconlarge\"><div class=\"tile\"></div>";
	
	td3.innerHTML = inhtml;
	var td = document.createElement("td");
	var inp = document.createElement("input");
	inp.type = "hidden";
	inp.value = type+id;
	td.appendChild(inp);
	var td4 = document.createElement("td");
	td4.className = "up";
	td4.setAttribute("onclick","moveUp(this)");
	var td5 = document.createElement("td");
	if( document.getElementById("slots").value != 0 ){
		td5.className = "down";
		td5.setAttribute("onclick","moveDwn(this)");
	}
	var td6 = document.createElement("td");
	td6.className = "rem";
	td6.setAttribute("onclick","remPlan(this)");
	
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
	getAllCodes();
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

function getAllCodes(){
	var d = document.getElementById("battleplan");
	var inps = d.getElementsByTagName("input");
	var txt = "";
	for(var i=0;i<inps.length;i++){
		txt += ","+inps[i].value;
	}
	if(txt.length>0)
		txt= txt.substring(1);
	document.getElementById("serialized").value = txt;
}

function checkSlots(){
	var d = document.getElementById("battleplan");
	
	if( document.getElementById("slots").value > 0){
		document.getElementById("slots").value = <%=c.getAvailableAttackSlot()%> - d.getElementsByTagName("table").length
		return true;
	}
	else{
		return false;
	}
	
}

</script>
</body>
</html>