<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Infinite World - <decorator:title default="Infinite World" /></title>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/stylecss.jsp">
</head>
<body>
<table width="99%">
	<tr width="100%">
		<td id="north" colspan="3">		
			<%@ include file="b1pre.jsp"%>
			<%@ include file="header.jsp"%>
			<%@ include file="b1post.jsp"%>
		</td>
	</tr>
	<tr valign="top">
		<td id="west" width="180px">
			<%@ include file="b1pre.jsp"%>
			<%@ include file="/player/wbar.jsp"%>
			<%@ include file="b1post.jsp"%>			
		</td>
		<td><center><decorator:body /></center></td>
		<td id="east" width="180px" >
			<%@ include file="b1pre.jsp"%>
			<%@ include file="/player/ebar.jsp"%>
			<%@ include file="b1post.jsp"%>			
		</td>
	</tr>
	<tr>		
		<td colspan="3" id="south">
		<%@ include file="b1pre.jsp"%>
		<%@ include file="footer.jsp"%>
		<%@ include file="b1post.jsp"%>		
		</td>
	</tr>
</table>


</body>
</html>