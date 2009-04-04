<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%
	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;
    Map m = (Map)session.getAttribute("map");
	
    %>

<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.AreaItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Map - <% out.print(m.getAreaName()); %></title>


</head>
<body>

<%
	if(session.getAttribute("error")!=null){
		%><%@ include file="../decorators/b2pre.jsp"%>
<div align="center">
<div class="error"><%=session.getAttribute("error")%></div>
</div>
<%@ include file="../decorators/b2post.jsp"%><br />
<%
	session.removeAttribute("error");
	}%>


<div style="width:<% out.print( (Map.MAP_WIDTH + 20) ); %>px;">
<%@ include file="../decorators/b2pre.jsp"%>
<table cellpadding=0 cellspacing=0 border=0 width="<% out.print(Map.MAP_WIDTH); %>px" height="<% out.print(Map.MAP_HEIGHT); %>">
<%
for(int y=0;y<m.getNy();y++){
	%><tr> <%
	for(int x=0;x<m.getNx();x++){
		out.print("<td  style=\"width:"+ (Map.MAP_WIDTH / m.getNx())+";height:"+ (Map.MAP_HEIGHT / m.getNy())+";background-image:url('"+request.getContextPath()+"/imgs/maps/"+m.getAreaName()+"/"+m.getAreaName()+"_"+y+x+".jpg');\">");
		List<AreaItem> l = m.getAreaItem(x,y);
		for (Iterator iterator = l.iterator(); iterator.hasNext();) {
			AreaItem areaItem = (AreaItem) iterator.next();
			
			//out.print("<a href=\""+request.getContextPath()+areaItem.getUrl()+"\">");
			//out.print("<img width=25 height=25 src=\""+request.getContextPath()+"/imgs/maps/icons/"+areaItem.getIcon()+".png\" alt=\""+areaItem.getName()+"\" title=\""+areaItem.getName()+"\" style=\"border:1px outset gray;position:relative;top:"+areaItem.getY()+"px;left:"+areaItem.getX()+"px;\">");
			//out.print("</a>");
			
			%>
				<div class="iconmedium"	style="position:relative;top:<%=areaItem.getY() %>px;left:<%=areaItem.getX() %>px;background-image: url(<%=request.getContextPath()%>/imgs/maps/icons/<%=areaItem.getIcon()%>.png);">
				<div class="tile"><a href="<%= request.getContextPath()%><%=areaItem.getUrl()%>" ></a></div>
				</div>
			<%
			
			
		}
		out.print("</td>");
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