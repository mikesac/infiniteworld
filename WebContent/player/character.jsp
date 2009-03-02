<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Character"%>
<%@page import="java.util.List"%>

<%@page import="org.infinite.db.dao.Player"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Choose Your Character</title>

<script type="text/javascript">
function play(name){
	var f = document.forms["play"];
	f.name.value = name;
	f.submit();
}

</script>


</head>
<body>
<center>
<div class="char">
<table width="100%">
	<tr><td colspan=5 " align="center">Choose you character</td></tr>
	<%
		String err = (String)request.getAttribute("error");
		if(err!=null && err.length()>0){
			%><tr><td colspan=5 " align="center"><div class="error"><% out.print(err);%></div></td></tr><%
		}
	%>
</table>
</div>

<div class="char" style="width:80%; height:430px;overflow: auto;padding: 1% 1% 1% 1%;">
<div>
<form name="newchar" method="POST" action="<%=request.getContextPath()%>/newChar" enctype="multipart/form-data">
<table width="100%">
	
	<%
		List<Player> l = Character.getCharacterListing( request.getUserPrincipal().getName() );
		for(int i=0;i<l.size();i++){
			%>
			
			<tr>
			<td><img class="avatar" alt="<% out.write( l.get(i).getName() ); %>" src="<%=request.getContextPath()%>/imgs/player/<% out.write( l.get(i).getImage() ); %>"></td>
			<td align="center"><% out.write( l.get(i).getName() ); %><br/> Level <% out.write( ""+l.get(i).getLevel() ); %></td>
			<td colspan="3">
			<table>
				<tr>
					<td><img src="<%=request.getContextPath()%>/imgs/web/lp.png" alt="Life Points" title="Life Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBasePl() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/mp.png" alt="Magic Points" title="Magic Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBasePm() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/ap.png" alt="Action Points" title="Action Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBasePa() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/cp.png" alt="Charm Points" title="Charm Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBasePc() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/gp.png" alt="Gold" title="Gold"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getGold() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/px.png" alt="Experience Points" title="Experience Points"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getPx() ); %>" /></td>
				</tr>
				<tr>
					<td><img src="<%=request.getContextPath()%>/imgs/web/str.png" alt="Strenght" title="Strenght"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBaseStr() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/int.png" alt="Intelligence" title="Intelligence"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBaseInt() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/dex.png" alt="Dexterity" title="Dexterity"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBaseDex() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/cha.png" alt="Charisma" title="Charisma"></td>
					<td><input readonly="readonly" type="text" size=8" value="<% out.write( ""+l.get(i).getBaseCha() ); %>" /></td>
					<td><img src="<%=request.getContextPath()%>/imgs/web/area.png" alt="Area" title="Area"></td>
					<td colspan="3"><input readonly="readonly" type="text" size="20" value="<% out.write( ""+l.get(i).getArea().getName() ); %>" /></td>
				</tr>
			</table>
			
			</td>
			<td><button onclick="play('l.get(i).getName()')">Play</button></td>
		</tr>
		<tr><td colspan=6" align="center"><hr width="90%"/></td></tr>
		<%	}  %>
		
		<tr>
		<td><img class="avatar" alt="No Character" src="<%=request.getContextPath()%>/imgs/web/pg_void.png"></td>
		<td>Character Name</td>
		<td><input type="text" name="new_name" /></td>
		<td>Character Picture</td>
		<td><input type="file" name="new_pic" /></td>
		<td><input type="submit" /></td>
	</tr>
	
</table>
</form>

</div>
</div>

</center>

<form name="play" action="/play" method="post">
<input type="hidden" value="" name="name">
</form>

</body>
</html>