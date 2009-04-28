<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Infinite World Test Server</title>
</head>
<body>
<center>

<table align="center">

<%
int nx = (Integer)session.getAttribute("nx");
int ny = (Integer)session.getAttribute("ny");
String path = (String)session.getAttribute("path");

for (int i = 0; i < ny; i++) {
	%><tr><%
	for (int j = 0; j < nx; j++) {
		%><td><img src="<%=request.getContextPath()+"/imgs/maps/tmp/crop_"+i+j+".png" %>"/></td><%
	}
	%></tr><%
}

%>

</table>

</center>
</body>
</html>