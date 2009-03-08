<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title><decorator:title default="Infinite World" /></title>
<link  type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/styleext.jsp">
</head>
<body>

<table width="99%">
	<tr width="100%">
		<td id="north" colspan="2">		
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td id="side-nw"></td>
				<td id="side-n"></td>
				<td id="side-ne"></td>
			</tr>
			<tr>
				<td id="side-w"></td>
				<td id="side"><%@ include file="header.jsp"%></td>
				<td id="side-e"></td>
			</tr>
			<tr>
				<td id="side-sw"></td>
				<td id="side-s"></td>
				<td id="side-se"></td>
			</tr>
			</table>
		
		
		</td>
	</tr>
	<tr valign="top">
		<td id="west" width="240px">
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td id="side-nw"></td>
				<td id="side-n"></td>
				<td id="side-ne"></td>
			</tr>
			<tr>
				<td id="side-w"></td>
				<td id="side"><%@ include file="/player/sidebar.jsp"%></td>
				<td id="side-e"></td>
			</tr>
			<tr>
				<td id="side-sw"></td>
				<td id="side-s"></td>
				<td id="side-se"></td>
			</tr>
			</table>
			
		</td>
		<td id="center"><decorator:body /></td>
	</tr>
	<tr>
		
		<td colspan="2" id="south">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td id="side-nw"></td>
				<td id="side-n"></td>
				<td id="side-ne"></td>
			</tr>
			<tr>
				<td id="side-w"></td>
				<td id="side"><%@ include file="footer.jsp"%></td>
				<td id="side-e"></td>
			</tr>
			<tr>
				<td id="side-sw"></td>
				<td id="side-s"></td>
				<td id="side-se"></td>
			</tr>
			</table>
		
		
		</td>
	</tr>
</table>


</body>
</html>