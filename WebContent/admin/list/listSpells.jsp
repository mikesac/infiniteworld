<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.db.dao.Spell"%>
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
		<th>ReqStr</th>
		<th>ReqInt</th>
		<th>ReqDex</th>
		<th>ReqCha</th>
		<th>ModStr</th>
		<th>ModInt</th>
		<th>ModDex</th>
		<th>ModCha</th>
		<th>Price</th>
		<th>CostMp</th>
		<th>Initiative</th>
		<th>Lev</th>
		<th>Type</th>
		<th>Savingthrow</th>
		<th>Duration</th>
		<tr>
	<%
	ArrayList<Spell> items= (ArrayList<Spell>)Manager.listByQuery("from org.infinite.db.dao.Spell");
	for(int i=0;i<items.size();i++){
		%><tr  class="<%=(i%2==0)?"ewTableAltRow":"ewTableRow" %>">
		<td><a href="../itemedit.jsp?key=<%= items.get(i).getId() %>">Edit</a></td>
		<td><a href="../itemadd.jsp?key=<%= items.get(i).getId() %>">Copy</a></td>
		<td><%= items.get(i).getName() %></td><%
		%><td><%= items.get(i).getDesc() %></td><%
		%><td><img src="<%=request.getContextPath() %>/imgs/spell/<%= items.get(i).getImage() %>.png" /></td><%
		%><td><%= items.get(i).getReqStr() %></td><%
		%><td><%= items.get(i).getReqInt() %></td><%
		%><td><%= items.get(i).getReqDex() %></td><%
		%><td><%= items.get(i).getReqCha() %></td><%
		%><td><%= items.get(i).getModStr() %></td><%
		%><td><%= items.get(i).getModInt() %></td><%
		%><td><%= items.get(i).getModDex() %></td><%
		%><td><%= items.get(i).getModCha() %></td><%
		%><td><%= items.get(i).getPrice() %></td><%
		%><td><%= items.get(i).getCostMp() %></td><%
		%><td><%= items.get(i).getInitiative() %></td><%
		%><td><%= items.get(i).getLev() %></td><%
		%><td><%= items.get(i).getSpelltype() %></td><%		
		%><td><%= items.get(i).getSavingthrow() %></td><%
		%><td><%= items.get(i).getDuration() %></td><%

		
		%><tr><%
	}
	%>
	</table>
</body>
</html>
