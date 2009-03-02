
<table width="100%" border="0">
	<tr>
		<td align="left">
		<%

if(request.getRemoteUser()!=null){
	out.write( "Welcome "+request.getRemoteUser());
}
else{
	%>You are not logged in.<%
}

%>
</td>
		<td align="right">
			<% if(request.getRemoteUser()!=null){
			 %><a href="<%=request.getContextPath()%>/logout">Logout</a><% 
			}
			%>
			
		</td>
	</tr>
</table>