<%--
% This is the main decorator for all SOMECOMPANY INTRANET pages.
% It includes standard caching, style sheet, header, footer and copyright notice.
--%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title><decorator:title default="INTRANET" /></title>
<%@ include file="/css/style.jsp"%>
</head>
<body>
<table style="height:100%;" width="99%">
	<tr width="100%">
		<td id="north" valign="top">		
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
	<tr>
		<td id="center"><decorator:body /></td>
	</tr>
	<tr>
		<td id="south"  valign="bottom">
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