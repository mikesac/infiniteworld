<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Character"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div style="width: 150px">

<%
Character c = (Character)session.getAttribute("character");
c = Character.checkForRegeneration(c);
%>

<table width="100%">
	<tr>
		<td align="center" colspan="2"><img alt="No Character" width="100" height="100" class="avatar"
			src="<%=request.getContextPath()%>/imgs/player/<% out.write( c.getPic() ); %>"></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><% out.print(c.getName()); %></td>
	</tr>
	<tr>
		<td align="center" colspan="2">Level <% out.print(c.getLevel()); %></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
		<hr />
		</td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/lp.png"
			alt="Life Points" title="Life Points"></td>
		<td>
		<div class="thp_big">
		<div class="chp_big" style="width:<%out.print( Math.round( (100.0f *c.getPointsLife()) / c.getPointsLifeMax() ) );%>px;" />
		<div class="hpt_big"><%
			out.print(c.getPointsLife());
		%> / <%
			out.print(c.getPointsLifeMax());
		%></div>
		</div>
		</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/mp.png"
			alt="Magic Points" title="Magic Points"></td>
		<td>
		<div class="tmp_big">
		<div class="cmp_big" style="width: <%out.print( Math.round( (100.0f *c.getPointsMagic()) / c.getPointsMagicMax() ) );%>px;" />
		<div class="mpt_big"><%
			out.print(c.getPointsMagic());
		%> / <%
			out.print(c.getPointsMagicMax());
		%></div>
		</div>
		</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/ap.png"
			alt="Action Points" title="Action Points"></td>
		<td>
		<div class="tap_big">
		<div class="cap_big" style="width:<%out.print( Math.round( (100.0f *c.getPointsAction()) / c.getPointsActionMax() ) );%>px;" />
		<div class="apt_big"><%
			out.print(c.getPointsAction());
		%> / <%
			out.print(c.getPointsActionMax());
		%></div>
		</div>
		</td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/cp.png"
			alt="Charm Points" title="Charm Points"></td>
		<td>
		<div class="tcp_big">
			<div class="ccp_big" style="width:<%out.print( Math.round( (100.0f *c.getPointsCharm()) / c.getPointsCharmMax() ) );%>px;" />
			<div class="cpt_big"><%
				out.print(c.getPointsCharm());
			%> / <%
				out.print(c.getPointsCharmMax());
			%></div>
		</div>
		</td>
	</tr>

<%
 if( c.getNexRegenereationTime()!=0){
	 %>
	 <tr><td colspan="2" align="center" id="reg">Regenerate in <span id="regtime2"></span><span style="display:none" id="regtime1">
	 <%out.print(c.getNexRegenereationTime()); %>
	 </span></td></tr> 
	 <% } %>

	<tr>
		<td align="center" colspan="2">
		<hr />
		</td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/str.png"
			alt="Strenght" title="Strenght"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getStrenght()); %>"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/int.png"
			alt="Intelligence" title="Intelligence"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getIntelligence()); %>"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/dex.png"
			alt="Dexterity" title="Dexterity"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getDexterity()); %>"
			style="text-align: right;" /></td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/cha.png"
			alt="Charisma" title="Charisma"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getCharisma()); %>"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
		<hr />
		</td>
	</tr>

	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/ca.png"
			alt="Armor Class" title="Armor Class"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getArmorCA()); %>"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/px.png"
			alt="Experience" title="Experience"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getExperience()); %>"
			style="text-align: right;" /></td>
	</tr>
	<tr>
		<td><img src="<%=request.getContextPath()%>/imgs/web/gp.png"
			alt="Gold" title="Gold"></td>
		<td><input type="text" size="10" readonly="readonly" value="<% out.print(c.getGold()); %>"
			style="text-align: right;" /></td>
	</tr>

</table>
</div>
<script>
el = document.getElementById("regtime1");
if(el){
	mil = el.innerHTML;
	setInterval ( "formatRegTime()", 1000 );
}


function formatRegTime(){
	
	el = document.getElementById("regtime1");
	if(el){
		var mm = Math.floor(mil / (1000*60));
		var ss = Math.floor((mil - mm* (1000*60))/1000);

		if(ss<10) ss = "0"+ss;

		document.getElementById("regtime2").innerHTML = mm + ":" + ss;
		mil -= 1000;

		if(mil <= 0){
			document.getElementById("reg").innerHTML = "<a href=\"javascript:document.location=document.location\">Reload</a>";
		}
	
	}
}

</script>
</body>
</html>