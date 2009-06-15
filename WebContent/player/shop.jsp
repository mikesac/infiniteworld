<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.util.GenericUtil"%>
<%@page import="org.infinite.db.dao.Npc"%>
<%@page import="org.infinite.db.Manager"%>
<%
	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;
	Character c = (Character) session.getAttribute(PagesCst.CONTEXT_CHARACTER);

	int NpcId = GenericUtil.toInt( c.getAreaItem().getNpcs(),-1);
	
	if(NpcId==-1){
		session.setAttribute(PagesCst.CONTEXT_ERROR, "Cannot find NPC id:"+c.getAreaItem().getNpcs() );
		response.sendRedirect( request.getContextPath() + PagesCst.PAGE_MAP );
		return;
	}
	
	Npc npc = (Npc)Manager.findById(Npc.class.getName(), NpcId);
	
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Shop</title>
</head>
<body>
<link rel="STYLESHEET" type="text/css" href="../js/dhtmlxGrid/dhtmlxgrid.css">
<style>
#gridbox th{background-image:"";background-color:transparent;padding:0;margin:0;}
div.gridbox .objbox{background-color:transparent;}
div.gridbox .xhdr {background-color:transparent;}
div.gridbox table.hdr td {background-color:#684331;color:white;}
</style>
<%@ include file="../decorators/b1pre.jsp"%>
<div style="width: 980px; height: 500px; overflow: auto; padding: 1% 1% 1% 1%;">

<table border=0 width="100%">
	<tr>
		<td height="80px" colspan=2>
			<table>
				<td><img width="80" src="<%=request.getContextPath()%>/imgs/npc/<%= npc.getImage() %>.png" /></td>
				<td>
					Welcome to my shop!<br />
					Remember that your charisma will influence the prices!<br />
					Player's Charisma: <span style="color:#9800F0;font-weight: bold;"><%=c.getCharisma() %></span><br/>
					Merchant's Charisma: <span style="color:red;font-weight: bold;"><%=npc.getBaseCha() %></span><br/>
					Price adjustment: <%=  Math.round((100.0f * npc.getBaseCha())/c.getCharisma()) %>%
			</td>
		</table>
		
		</td>
	</tr>
	<tr>
		<td width="50%" height="400px" valign="top">
			<div style="width:100%;height:400px;margin:0 0 0 0;padding:0 0 0 0;" id="shopgrid"></div>
		</td>
		<td valign="top">
			<div style="width:100%;height:400px;margin:0 0 0 0;padding:0 0 0 0;" id="playgrid"></div>
		</td>
	</tr>
</table>

</div>
<%@ include file="../decorators/b1post.jsp"%>


<script src="../js/dhtmlxGrid/dhtmlxcommon.js"></script>
<script src="../js/dhtmlxGrid/dhtmlxgrid.js"></script>
<script src="../js/dhtmlxGrid/dhtmlxgridcell.js"></script>
<script>

function onload(){
	
	shopgrid = new dhtmlXGridObject('shopgrid');
	shopgrid.setImagePath("../js/dhtmlxGrid/imgs/"); 
	shopgrid.setHeader("Image,Name,Require,Provide,&nbsp;");
	shopgrid.setInitWidths("58,195,70,70,60");
	shopgrid.setColAlign("center,left,left,left,center"); 
	shopgrid.setColTypes("img,ro,ro,ro,ro");
	shopgrid.setColSorting("str,str,str,str,str");
	shopgrid.init();
	shopgrid.load("./json/shopItemNPC.jsp","json");

	playgrid = new dhtmlXGridObject('playgrid');
	playgrid.setImagePath("../js/dhtmlxGrid/imgs/"); 
	playgrid.setHeader("Image,Name,Require,Provide,&nbsp;");
	playgrid.setInitWidths("58,195,70,70,60");
	playgrid.setColAlign("center,left,left,left,center"); 
	playgrid.setColTypes("img,ro,ro,ro,ro");
	playgrid.setColSorting("str,str,str,str,na");
	playgrid.init();
	playgrid.load("./json/shopItemPC.jsp","json");
}

</script>
</body>
</html>