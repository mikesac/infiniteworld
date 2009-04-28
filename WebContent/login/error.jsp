<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error Page</title>
</head>
<body>

<%@ include file="../decorators/b1pre.jsp"%>
<div style="width:980px; height:500px;">
We are sorry, but the following error occurred in the page you requested:
<%= exception.getMessage()%>
</div>
<%@ include file="../decorators/b1post.jsp"%>

</body>
</html>
