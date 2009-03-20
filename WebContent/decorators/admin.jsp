<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"	prefix="decorator"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Infinite World - <decorator:title default="Infinite World" /></title>
<link  type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/stylecss.jsp">
<link  type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/jspmaker.css">
</head>
<body>
<table style="height:100%;" width="99%">
	<tr width="100%">
		<td id="north" valign="top">		
		<%@ include file="b1pre.jsp"%>
		<%@ include file="header.jsp"%>
		<%@ include file="b1post.jsp"%>		
		</td>
	</tr>
	<tr>
		<td id="center">
			
			<%@ include file="b1pre.jsp"%>
			<div style="width: 1000px;">
			<decorator:body />
			</div>
			<%@ include file="b1post.jsp"%>
			
			
		</td>
	</tr>
	<tr>
		<td id="south"  valign="bottom">
			<%@ include file="b1pre.jsp"%>
			<%@ include file="footer.jsp"%>
			<%@ include file="b1post.jsp"%>		
		</td>
	</tr>
</table>


</body>
</html>