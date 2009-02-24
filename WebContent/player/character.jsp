<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Choose Your Character</title>
</head>
<body>

<div class="char">

<form name="newchar" method="post" action="/newChar">
<table width="100%">
	<tr>
		<td rowspan="2"><img alt="No Character" style="margin:10px 10px 10px 10px;"
			src="<%=request.getContextPath()%>/imgs/web/pg_void.png"></td>
		<td colspan=4" align="center">Create a new character</td>
	</tr>
	<tr>
		<td>Character Name</td>
		<td><input type="text" name="new_name" /></td>
		<td>Character Picture</td>
		<td><input type="file" name="new_pic" /></td>
		<td><input type="submit" /></td>
	</tr>
</table>
</form>


</div>


</body>
</html>