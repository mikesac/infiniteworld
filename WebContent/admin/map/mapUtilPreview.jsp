<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.web.PagesCst"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Infinite World Test Server</title>
</head>
<body>

<%@ include	file="../../decorators/b1pre.jsp"%>
<table width="98%">
	<tr>
		<td width="80%">
		<table align="center" id="prwTable" cellpadding="2" cellspacing="2" style="background-color: black;">

			<%
				int nx = (Integer) session.getAttribute("nx");
				int ny = (Integer) session.getAttribute("ny");
				String path = (String) session.getAttribute("path");
				
				for (int i = 0; i < ny; i++) {
			%><tr>
				<%
					for (int j = 0; j < nx; j++) {
				%><td><img
					src="<%=request.getContextPath()
							+ "/imgs/maps/tmp/crop_" + i + j + ".jpg"%>" /></td>
				<%
					}
				%>
			</tr>
			<%
				}
			%>

		</table>
		</td>
		<td  style="width: 300px;" valign="top" align="center">
			
			<%@ include	file="../../decorators/b2pre.jsp"%>
			<div style="width:250px;">
			<button onclick="togglePad()">Toggle Border</button>
			<hr/>
			<form action="<%=request.getContextPath()%>/mapSave" method="post">
				<table width="100%">
				<tr><td colspan="2">Save Area</td></tr>
				<tr><td>Name</td><td><input type="text" name="area_name" size=10/></td></tr>
				<tr><td>Description</td><td><textarea name="area_desc"></textarea></td></tr>
				<tr><td>World</td><td><input type="text" name="area_world" size=3/></td></tr>
				<tr><td>Cost</td><td><input type="text" name="area_cost" size=3/></td></tr>
				<tr><td>n.X</td><td><input type="text" name="area_x" size=3 value="<%=nx%>" readonly="readonly"/></td></tr>
				<tr><td>n.Y</td><td><input type="text" name="area_y" size=3 value="<%=ny%>" readonly="readonly"/></td></tr>
				</table>
				<input type="hidden" name="area_path" value="<%=path %>">
				<input type="submit" value="Save"/>
			</form>
			</div>
			<%@ include	file="../../decorators/b2post.jsp"%>
		</td>
	</tr>
</table>


<%@ include	file="../../decorators/b1post.jsp"%>



<script>
	var padded = true;

	function togglePad() {

		if (padded) {
			document.getElementById("prwTable").cellPadding = 0;
			document.getElementById("prwTable").cellSpacing = 0;
		} else {
			document.getElementById("prwTable").cellPadding = 2;
			document.getElementById("prwTable").cellSpacing = 2;
		}
		padded = !padded;

	}
</script>



</body>
</html>