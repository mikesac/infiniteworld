<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%
	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;
%>

<%@page import="org.infinite.web.PagesCst"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fight Report</title>
</head>
<body>

<%
	if(session.getAttribute("error")!=null){
		out.print("<div class=\"char\" align=\"center\"><div class=\"error\">"+session.getAttribute("error")+"</div></div>");
		session.removeAttribute("error");
	}
%>

<div class="char" style="width:1000px; height:500px;overflow: auto;padding: 1% 1% 1% 1%;">
<div>
<%
if(session.getAttribute("mapfight")!=null){
		out.print(session.getAttribute("mapfight"));
	}
else{
	response.sendRedirect(request.getContextPath()+ PagesCst.PAGE_MAP);
}
session.removeAttribute("mapfight");
%>
</div>
</div>


</body>

<%@page import="org.infinite.web.account.StartPlaying"%></html>