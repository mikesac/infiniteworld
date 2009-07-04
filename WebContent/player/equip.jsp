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

	Character c = (Character)session.getAttribute(PagesCst.CONTEXT_CHARACTER);
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.PlayerOwnItem"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Character Equipment</title>
</head>
<body>

<div style="width:1020px;">
<%@ include file="../decorators/b1pre.jsp"%>

<div style="padding: 1% 1% 1% 1%; margin-bottom:30px;">

<table>
	<tr>
		<td class="equipbody">
		<table width="500px" height="500px" border=0>
			<tr style="height: 25%;">
				<td align="center" valign="middle">
				<div class="equipped" id="handleft">				
				<% 
					Item it = c.getHandLeft();
					if(it!=null){
						%>
							<div onclick="unequip(<%= c.getHandLeftPoi().getId() %>)" class="iconlarge" style="background-image: url(<%= PagesCst.IMG_ITEM_PATH + it.getImage()  +PagesCst.IMG_ITEM_EXT%>);">
								<div class="tile"/>
							</div>
						<%
					}
					
				%>
				</div>
				</td>
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="handright">
				<% 
					it = c.getHandRight();
					if(it!=null){
						%>
							<div onclick="unequip(<%= c.getHandRightPoi().getId() %>)" class="iconlarge" style="background-image: url(<%= PagesCst.IMG_ITEM_PATH + it.getImage()  +PagesCst.IMG_ITEM_EXT%>);">
								<div class="tile"/>
							</div>
						<%
					}
					
				%>
				</div>
				</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="body">
				<% 
					it = c.getBody();
					if(it!=null){
						%>
							<div onclick="unequip(<%= c.getBodyPoi().getId() %>)" class="iconlarge" style="background-image: url(<%= PagesCst.IMG_ITEM_PATH + it.getImage()  +PagesCst.IMG_ITEM_EXT%>);">
								<div class="tile"/>
							</div>
						<%
					}
					
				%>
				</div>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
		<td>
		<%@ include file="../decorators/b2pre.jsp"%>
		<div style="width:420px;height:500px;overflow:auto;padding: 1% 1% 1% 1%;">
		<div>
		<center>
			<table cellpadding="0" cellspacing="0" border="0" width="100%" >
				<tr><th></th><th>Image</th><th>Name</th><th>Description</th></tr>
				
				<%
				ArrayList<PlayerOwnItem> pois = c.getInventory();
				for (int i = 0; i < pois.size(); i++) {
					%><tr>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;" valign="middle">
							<button onclick="equip(<%=pois.get(i).getId()%>)">Equip</button>
							<button onclick="drop(<%=pois.get(i).getId()%>)">Drop</button>
						</td>
						<td  style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;">
							<div class="iconlarge" style="background-image: url(<%= PagesCst.IMG_ITEM_PATH +  pois.get(i).getItem().getImage() +PagesCst.IMG_ITEM_EXT%>);">
								<div class="tile"/>
							</div>
							
						</td>						
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;"><%= pois.get(i).getItem().getName() %></td>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;"><%= pois.get(i).getItem().getDescr() %></td>
					</tr><%
				}
				%>
					
			</table>
			
			</center>

		</div>
		</div>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
	</tr>
</table>
<%@ include file="../decorators/b1post.jsp"%>
</div></div>


<form name="formequip" action="<%=request.getContextPath()%>/equip" method="POST" >
<input type="hidden" name="itemid" value=""/>
<input type="hidden" name="mode" value=""/>
</form>



<script type="text/javascript">
function goEquip(mode,id){
	document.forms['formequip'].elements['itemid'].value=id;
	document.forms['formequip'].elements['mode'].value=mode;
	document.forms['formequip'].submit();
	
}

function equip(id){
	var mode = "<%=InfiniteCst.POI_EQUIP%>";
	goEquip(mode,id);
}

function unequip(id){
	if( confirm("Do you really want unequip this item?") ){
		var mode = "<%=InfiniteCst.POI_UNEQUIP%>";
		goEquip(mode,id);
	}	
}

function drop(id){	
	if( confirm("Do you really want to drop this item?") ){
		var mode = "<%=InfiniteCst.POI_DROP%>";
		goEquip(mode,id);
	}	
}
</script>
</body>

</html>