<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.web.PagesCst"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Area Item Edit</title>
</head>
<body>
<%@page import="org.infinite.db.Manager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.Area"%>

Choose the Area to edit:

<form method="post" action="<%=request.getContextPath() + PagesCst.ADMIN_MAPITEMS%>">
<select name="areaid">
<%
	ArrayList<Area> list = (ArrayList<Area>) Manager.listByQuery("from " + Area.class.getName());
 	for(int i=0;i<list.size();i++){
 		
 		%>
 		<option value="<%=list.get(i).getId()%>"><%=list.get(i).getName()%></option>
 		<% 		
 	}
%>

</select>
<input type="submit" value="go">
</body>
</html>