
<table width="100%"  cellpadding="0" cellspacing="0" border="0" class="smallfont"  >
	<tr>
		<td align="left" class="smallfont">
		<%

if(request.getRemoteUser()!=null){
	out.write( "Welcome "+request.getRemoteUser());
}
else{
	%>You are not logged in.<%
}

%>
</td>
		<td align="right" class="smallfont">
			<% if(request.getRemoteUser()!=null){
			 %><a href="<%=request.getContextPath()%>/logout">Logout</a><% 
			}
			%>
			
		</td>
	</tr>
</table>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-1542956-3");
pageTracker._trackPageview();
} catch(err) {}</script>