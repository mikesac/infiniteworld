<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.db.dao.Npc"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="java.util.ArrayList"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Items list</title>
<link  type="text/css" rel="stylesheet" href="/InfiniteWeb/css/jspmaker.css">
</head>
<body>
	<table class="ewTable">
	<tr class="ewTableHeader">
		<th></th>
		<th></th>
		<th>Name</th>
		<th>Descr</th>
		<th>image</th>
		<th>Str</th>
		<th>Int</th>
		<th>Dex</th>
		<th>Cha</th>
		<th>PL</th>
		<th>PM</th>
		<th>PA</th>
		<th>PC</th>
		<th>Gold</th>
		<th>Px</th>
		<th>n.Atk</th>
		<th>Atk</th>
		<tr>
	<%
	ArrayList<Npc> items= (ArrayList<Npc>)Manager.listByQery("from org.infinite.db.dao.Npc");
	for(int i=0;i<items.size();i++){
		%><tr  class="<%=(i%2==0)?"ewTableAltRow":"ewTableRow" %>">
		<td><a href="../itemedit.jsp?key=<%= items.get(i).getId() %>">Edit</a></td>
		<td><a href="../itemadd.jsp?key=<%= items.get(i).getId() %>">Copy</a></td>
		<td><%= items.get(i).getName() %></td><%
		%><td><%= items.get(i).getDescription() %></td><%
		%><td><img src="<%=request.getContextPath() %>/imgs/monster/<%= items.get(i).getImage() %>.png" /></td><%
		%><td><%= items.get(i).getBaseStr() %></td><%
		%><td><%= items.get(i).getBaseInt() %></td><%
		%><td><%= items.get(i).getBaseDex() %></td><%
		%><td><%= items.get(i).getBaseCha() %></td><%
		%><td><%= items.get(i).getBasePl() %></td><%
		%><td><%= items.get(i).getBasePm() %></td><%
		%><td><%= items.get(i).getBasePa() %></td><%
		%><td><%= items.get(i).getBasePc() %></td><%
		%><td><%= items.get(i).getGold() %></td><%
		%><td><%= items.get(i).getPx() %></td><%
		%><td><%= items.get(i).getNattack() %></td><%
		%><td><%= items.get(i).getAttack() %></td><%		
		%><tr><%
	}
	%>
	</table>
</body>
</html>