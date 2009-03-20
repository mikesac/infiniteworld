<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="width: 99%;">
<%@include	file="../decorators/b1pre.jsp"%>

<table>
	<tr valign="top">
		<td width="40%" >
		<%@ include file="../decorators/b2pre.jsp"%>
		<div style="width: 80%">
		<form>
		<table>
			<tr>
				<td>Id</td>
				<td><input type="text" name="id" value="14" /></td>
				<td>Name</td>
				<td><input type="text" name="name" value="no-item" /></td>
			</tr>
			<tr>
				<td>Desc</td>
				<td><input type="text" name="descr" value="unexisting item" /></td>
				<td>Image</td>
				<td><input type="text" name="image" value="empty" /></td>
			</tr>
			<tr>
				<td>Cost AP</td>
				<td><input type="text" name="costAP" value="1" /></td>
				<td>Req Str</td>
				<td><input type="text" name="req_str" value="0" /></td>
			</tr>
			<tr>
				<td>Req Int</td>
				<td><input type="text" name="req_int" value="5" /></td>
				<td>Req Wis</td>
				<td><input type="text" name="req_wis" value="5" /></td>
			</tr>
			<tr>
				<td>Req Dex</td>
				<td><input type="text" name="req_dex" value="5" /></td>
				<td>Req Cha</td>
				<td><input type="text" name="req_cha" value="5" /></td>
			</tr>
			<tr>
				<td>Req Lv</td>
				<td><input type="text" name="req_lev" value="1" /></td>
				<td>Mod Str</td>
				<td><input type="text" name="mod_str" value="0" /></td>
			</tr>
			<tr>
				<td>Mod Int</td>
				<td><input type="text" name="mod_int" value="0" /></td>
				<td>Mod Wis</td>
				<td><input type="text" name="mod_wis" value="0" /></td>
			</tr>
			<tr>
				<td>Mod Dex</td>
				<td><input type="text" name="mod_dex" value="0" /></td>
				<td>Mod Cha</td>
				<td><input type="text" name="mod_cha" value="0" /></td>
			</tr>
			<tr>
				<td>Price</td>
				<td><input type="text" name="price" value="0" /></td>
				<td>Level</td>
				<td><input type="text" name="lev" value="1" /></td>
			</tr>
			<tr>
				<td>Spell</td>
				<td><input type="text" name="spell" value="1" /></td>
				<td>Damage</td>
				<td><input type="text" name="damage" value="0" /></td>
			</tr>
			<tr>
				<td>Init</td>
				<td><input type="text" name="initiative" value="0" /></td>
				<td>Durab.</td>
				<td><input type="text" name="durability" value="0" /></td>
			</tr>
			<tr>
				<td>Type</td>
				<td><input type="text" name="type" value="0" /></td>
				<td colspan="2" align="center"><input type="submit" /><input
					type="reset" /></td>
			</tr>
		</table>
		</form>
		</div>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
		<td width="70%">
			<%@ include file="../decorators/b2pre.jsp"%>
			
			<div style="height:500px;overflow:auto;padding: 1% 1% 1% 1%;">
		<div>
		<center>
			<table cellpadding="0" cellspacing="0" border="0" width="100%" >
				<tr><th></th><th width="80px">Image</th><th  width="100px">Name</th><th>Description</th></tr>
				
				<%
				List<Item> items = Manager.listByQery("from org.infinite.db.dao.Item");
				for (int i = 0; i < items.size(); i++) {
					%><tr>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;" valign="middle">
						
							<form action="<%=request.getContextPath()%>/admin/item" method="POST">
							<input type="hidden" name="itemid" value="<%=items.get(i).getId()%>"/>
							<input type="submit" value="Edit" style="font-size: 7pt;width:50px;"/>
							</form>
						
							<form action="<%=request.getContextPath()%>/admin/item" method="POST" onsubmit="return confirmDrop();">
							<input type="hidden" name="itemid" value="<%=items.get(i).getId()%>"/>
							<input type="submit" value="Drop" style="font-size: 7pt;width:50px;"/>
							</form>						
						</td>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;">
							<img src="<%= request.getContextPath() %>/imgs/item/<%= items.get(i).getImage() %>.png" />
						</td>						
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;"><%= items.get(i).getName() %></td>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;"><%= items.get(i).getDescr() %></td>
					</tr><%
				}
				%>
					
			</table>
			
			</center>

		</div>
		</div>
			
			
			<%@ include file="../decorators/b2post.jsp"%>
		</td>
	</tr>
</table>
<%@ include file="../decorators/b1post.jsp"%>
</div>

</body>
</html>