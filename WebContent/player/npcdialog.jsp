<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.db.dao.Npc"%>
<%@page import="org.infinite.db.dao.AreaItem"%>
<%@page import="org.infinite.db.Manager"%>
<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.engines.dialog.FullDialogEngine"%>
<%@page import="org.infinite.engines.dialog.FullDialog"%>
<%@page import="org.infinite.engines.map.MapEngine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.web.account.StartPlaying"%>
<%


	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;

	Character c = (Character) session.getAttribute(PagesCst.CONTEXT_CHARACTER);
	AreaItem a =  c.getAreaItem();

	int NpcId = GenericUtil.toInt( a.getNpcs(),-1);
	
	if(NpcId==-1){
		session.setAttribute(PagesCst.CONTEXT_ERROR, "Cannot find NPC id:"+a.getNpcs());
		response.sendRedirect( request.getContextPath() + PagesCst.PAGE_MAP );
		return;
	}
	
	Npc npc = (Npc)Manager.findById(Npc.class.getName(), NpcId);
		
	FullDialog fd = FullDialogEngine.getDialogData( getServletContext().getResourceAsStream("/data/npc/"+ npc.getDialog() + ".properties") ); 
	int select = GenericUtil.toInt(request.getParameter("s"),0);
	
	String sentence = fd.getSentenceString(select);
	if(fd.isUrl(sentence) ){
		response.sendRedirect( request.getContextPath() + sentence);
	}
	
%>


<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.util.GenericUtil"%>
<%@page import="org.infinite.engines.dialog.FullDialogEngine"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Talk to <%= npc.getName() %></title>
</head>
<body>
<%@ include file="../decorators/b2pre.jsp"%>

<table>
	<tr>
		<td>
			<img src="<%=request.getContextPath()%>/imgs/npc/<%= npc.getImage() %>.png" />
		</td>
		<td><%= sentence %></td>
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