<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page errorPage = "../login/error.jsp" %>
<%@page import="org.infinite.web.PagesCst"%>
<html>
<head>
<title>Infinite World - <decorator:title
	default="Infinite World" /></title>
<link type="text/css" rel="stylesheet"	href="<%=request.getContextPath()%>/css/stylecss.jsp">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/iconover.jsp">
</head>
<body>
<table style="height: 100%;" width="99%">
	<tr width="100%">
		<td id="north" valign="top"><%@ include file="b1pre.jsp"%>
		<%@ include file="header.jsp"%> <%@ include
			file="b1post.jsp"%></td>
	</tr>
	<tr>
		<td id="center">

		<center>
		<%
			if(session.getAttribute(PagesCst.CONTEXT_ERROR)!=null){
				%><%@ include file="../decorators/b2pre.jsp"%>
		<%
				out.print("<div align=\"center\"><div class=\"error\">"+session.getAttribute("error")+"</div></div>");
				session.removeAttribute(PagesCst.CONTEXT_ERROR);
				%><%@ include file="../decorators/b2post.jsp"%><br />
		<%
			}
		%>
		</center>

		<decorator:body /></td>
	</tr>
	<tr>
		<td id="south" valign="bottom"><%@ include file="b1pre.jsp"%>
		<%@ include file="footer.jsp"%> <%@ include
			file="b1post.jsp"%></td>
	</tr>
</table>


</body>
</html>