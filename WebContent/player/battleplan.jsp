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

	Character c = (Character) session
			.getAttribute(PagesCst.CONTEXT_CHARACTER);
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.PlayerOwnItem"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Battle Strategy</title>
</head>
<body>

<%
	if (session.getAttribute("error") != null) {
%><%@ include file="../decorators/b2pre.jsp"%>
<div align="center">
<div class="error"><%=session.getAttribute("error")%></div>
</div>
<%@ include file="../decorators/b2post.jsp"%><br />
<%
	session.removeAttribute("error");
	}
%>


<div style="width: 1020px;"><%@ include
	file="../decorators/b1pre.jsp"%>

<table>
	<tr>
		<td width="80px">
		<center><img src="../imgs/web/btl/sword.png" /></center>
		</td>
		<td style="width: 200px;" valign="top"><%@ include
			file="../decorators/b2pre.jsp"%>
		<center>

		<table>
			<tr>
				<td>Equipped weapon</td>
			</tr>
			<tr>
				<td>
				<div class="equipped">
				<%
					Item it = c.getHandRight();
					if (it != null) {
				%>
				<div class="iconlarge"
					style="background-image: url(<%=request.getContextPath()%>/imgs/item/<%=it.getImage()%>.png);">
				<div class="tile" /></div>
				<%
					}
				%>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<button>Add &gt;&gt;</button>
				</td>
			</tr>

			<tr>
				<td>Prepared spells</td>
			</tr>
			<tr>
				<td><select>
					<%
						for (int i = 0; i < c.getPreparedSpells().size(); i++) {
					%><option
						value="<%=c.getPreparedSpells().get(i).getSpell().getId()%>"
						img="<%=c.getPreparedSpells().get(i).getSpell().getImage()%>">
					<%=c.getPreparedSpells().get(i).getSpell().getName()%></option>
					<%
						}
					%>
				</select></td>
			</tr>
			<tr>
				<td>
				<div class="equipped">
				<% 
							
							if(c.getPreparedSpells().size()!=0){
								%>
									<div class="iconlarge" style="background-image: url(<%= request.getContextPath() %>/imgs/spell/<%=c.getPreparedSpells().get(0).getSpell().getImage()%>.png);">
										<div class="tile"/>
									</div>
								<%
							}
							
						%>
				
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<button>Add &gt;&gt;</button>
				</td>
			</tr>
			<tr>
				<td>Special Items</td>
			</tr>
			<tr>
				<td><select></select></td>
			</tr>
			<tr>
				<td>
				<div class="equipped"></div>
				</td>
			</tr>
			<tr>
				<td>
				<button>Add &gt;&gt;</button>
				</td>
			</tr>
		</table>

		</center>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
		<td style="width: 700px;" valign="top"><%@ include
			file="../decorators/b2pre.jsp"%>
		<center>Choose your attack strategy. ( <%=c.getAvailableAttackSlot()%> slots left)<br />
		One action will be performed on each round in the chosen order in a
		loop.<br />
		Action slots will increase leveling up.</center>
		<%@ include file="../decorators/b2post.jsp"%>
		<br />
		<%@ include file="../decorators/b2pre.jsp"%>
		<div style="width: 550px; height: 400px; overflow: auto">
		<div></div>
		<%@ include file="../decorators/b2post.jsp"%>
		</div>


		</td>
		<td width="80px">
		<center><img src="../imgs/web/btl/wand.png" /></center>
		</td>
	</tr>
</table>

<%@ include file="../decorators/b1post.jsp"%></div>
</div>


</body>

</html>