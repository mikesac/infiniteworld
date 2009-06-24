<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%
	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;
    Map m = (Map)session.getAttribute(PagesCst.CONTEXT_MAP);
	
    %>

<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.AreaItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.engines.map.MapEngine"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Map - <%= m.getAreaName() %></title>


</head>
<body>

<div style="width:<%= Map.MAP_WIDTH + 20 %>px;">
<%@ include file="../decorators/b2pre.jsp"%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=Map.MAP_WIDTH%>px" height="<%=Map.MAP_HEIGHT%>">
<%
for(int y=0;y<m.getNy();y++){
	%><tr> <%
	for(int x=0;x<m.getNx();x++){
		%>
		<td style="width:<%= (Map.MAP_WIDTH / m.getNx()) %>;height:<%=(Map.MAP_HEIGHT / m.getNy())%>;background-image:url('<%=request.getContextPath()+"/imgs/maps/"+m.getAreaName()+"/"+m.getAreaName()+"_"+y+x%>.jpg');">
		<%
		List<AreaItem> l = m.getAreaItem(x,y);
		
		Iterator<Integer> stat_it = m.getAreaStatus(x,y).iterator();
		
		for (Iterator<AreaItem> iterator = l.iterator(); iterator.hasNext();) {
			AreaItem areaItem = (AreaItem) iterator.next();
			int status = stat_it.next();
			
			%>
				<div class="iconmedium"	style="position:relative;top:<%=areaItem.getY() %>px;left:<%=areaItem.getX() %>px;background-image: url(<%=request.getContextPath()%>/imgs/maps/icons/<%=areaItem.getIcon()%>.png);">
				<div class="tile">
				<%
				switch(status){
				case MapEngine.AREA_STATUS_HERE:
					%><img style="margin-top:5px;margin-left:5px;" src="<%=request.getContextPath()%>/imgs/maps/icons/here.gif" width="34" /><%
					break;
				case MapEngine.AREA_STATUS_ACCESSIBLE:
					%><img src="<%=request.getContextPath()%>/imgs/maps/icons/ok.gif" width="22" /><%
					break;
				case MapEngine.AREA_STATUS_BANNED:
					%><img style="margin-top:5px;margin-left:5px;" src="<%=request.getContextPath()%>/imgs/maps/icons/banned.png" width="34" /><%
					break;
				case MapEngine.AREA_STATUS_FAR:
					%><img style="margin-top:5px;margin-left:5px;" src="<%=request.getContextPath()%>/imgs/maps/icons/step.png" width="34" /><%
					break;
				case MapEngine.AREA_STATUS_HIDDEN:
					break;
				case MapEngine.AREA_STATUS_LOCKED:
					%><img style="margin-top:5px;margin-left:5px;" src="<%=request.getContextPath()%>/imgs/maps/icons/lock.png" width="34" /><%
					break;
				}
				 
				
				%>
			
			<a href="<%= request.getContextPath()%>/map?m=<%= areaItem.getId() %>" ></a>
			
				</div>
				<%
				if( areaItem.getIcon().equals("fight") && (status==MapEngine.AREA_STATUS_HERE || status==MapEngine.AREA_STATUS_ACCESSIBLE  || status==MapEngine.AREA_STATUS_BANNED ) ){
					%>
					<span style="position:relative;color:white;background-color:black;top:-18;left:30;"><%= areaItem.getAreaItemLevel() %></span>
					<%
				}
				 %>
				</div>
			<%
			
		}
		%></td><%;
	}
	 %></tr>
	 <%
}
%>
</table>

<%@ include file="../decorators/b2post.jsp"%>
</div>
</body>
</html>