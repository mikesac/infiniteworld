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
<div style="width: 300px">
Fill the form with the Map image and the size of the areas you want it to be splitted in.
<%@ include	file="../../decorators/b2pre.jsp"%>

<form name="maps" method="POST" action="<%=request.getContextPath()%>/maputil" enctype="multipart/form-data">
<table align="center">
<tr><td>X</td><td><input type="text" name="x"</td></tr>
<tr><td>Y</td><td><input type="text" name="y"</td></tr>
<tr><td>Image</td><td><input type="file" name="map"/></td></tr>
</table>
<input type="submit"/>
</form>
<%@ include	file="../../decorators/b2post.jsp"%>
</div>
</center>
</body>
</html>