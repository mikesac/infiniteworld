<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.objects.Character"%>
<%
	if (StartPlaying.redirectToCharSelect(session, request, response))
		return;

	Character c = (Character)session.getAttribute("character");
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.db.dao.Item;"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Character Equipment</title>
</head>
<body>


<div style="width:1020px;">
<%@ include file="../decorators/b2pre.jsp"%>

<div style="padding: 1% 1% 1% 1%; margin-bottom:30px;">

<table>
	<tr>
		<td class="equipbody">
		<table width="500px" height="500px" border=0>
			<tr style="height: 25%;">
				<td align="center" valign="middle">
				<div class="equipped" id="handleft"></div>
				</td>
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="handright"></div>
				</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="body"></div>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
		<td>
		<div style="width:450px;height:500px;overflow:auto;padding: 1% 1% 1% 1%;">
		<div>
		<center>
			<table>
				<tr><th></th><th>Image</th><th>Name</th><th>Description</th></tr>
				
				<%
				ArrayList<Item> items = c.getInventory();
				for (int i = 0; i < items.size(); i++) {
					%><tr>
						<td></td>
						<td><img 
							src="<%= request.getContextPath() %>/imgs/item/<%= items.get(i).getImage() %>.png" 
							alt="<%= items.get(i).getName() %>" 
							title="<%= items.get(i).getName() %>"/>
						</td>						
						<td><%= items.get(i).getName() %></td>
						<td><%= items.get(i).getDescr() %></td>
					</tr><%
				}
				for (int i = 0; i < items.size(); i++) {
					%><tr>
						<td></td>
						<td><img 
							src="<%= request.getContextPath() %>/imgs/item/<%= items.get(i).getImage() %>.png" 
							alt="<%= items.get(i).getName() %>" 
							title="<%= items.get(i).getName() %>"/>
						</td>						
						<td><%= items.get(i).getName() %></td>
						<td><%= items.get(i).getDescr() %></td>
					</tr><%
				}
				%>
					
			</table>
			
			</center>

		</div>
		</div>
		</td>
	</tr>
</table>
<%@ include file="../decorators/b2post.jsp"%>
</div></div>
</body>

</html>