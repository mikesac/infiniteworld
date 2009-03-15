
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