<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.db.dao.Npc"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="org.infinite.engines.dialog.FullDialogEngine"%>
<%@page import="org.infinite.engines.dialog.FullDialog"%>
<%@page import="java.util.ArrayList"%>

<%

	Npc npc = (Npc)Manager.findById(Npc.class.getName(),0);
	FullDialog fd = FullDialogEngine.getDialogData("/data/npc/"+ npc.getDialog() + ".properties");
	int select = GenericUtil.toInt(request.getParameter("s"),0);
%>


<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.util.GenericUtil"%>
<%@page import="org.infinite.engines.dialog.FullDialogEngine"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dialog - <%= npc.getName() %></title>
</head>
<body>
<%@ include file="../decorators/b2pre.jsp"%>

<table>
	<tr>
		<td>
			<img src="<%=request.getContextPath()%>/imgs/npc/<%= npc.getImage() %>.png" />
		</td>
		<td><%= fd.getSentenceString(select)%></td>
	</tr>
	<tr>
		<td colspan="2">
			
			<table>
			<%
			for(int i=0;i<fd.getAnswersString(select).length;i++){
				%>
				<tr>
					<td>
						<a href="<%= request.getContextPath() + PagesCst.PAGE_NPCDIALOG %>?s=<%=fd.getAnswersRedirect(select,i) %>">					
						<%= fd.getAnswersString(select)[i] %>
						</a>
					</td>
				</tr>
				<%
			}
			%>
			
			</table>
			
		</td>
	</tr>
</table>



<%@ include file="../decorators/b2post.jsp"%>
</body>
</html>