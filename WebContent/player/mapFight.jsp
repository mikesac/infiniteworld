<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%
	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.engines.fight.FightRound"%>
<%@page import="org.infinite.objects.Character"%>

<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.engines.fight.PlayerInterface"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fight Report</title>
</head>
<body>

<%
	Character c = (Character) session.getAttribute(PagesCst.CONTEXT_CHARACTER);
%>


<%@ include file="../decorators/b1pre.jsp"%>
<div style="width:980px; height:500px;overflow: auto;padding: 1% 1% 1% 1%;">
<div>
<%
if(session.getAttribute(PagesCst.CONTEXT_FIGHT_REPORT)!=null){
	
	ArrayList<FightRound> report = (ArrayList<FightRound>)session.getAttribute(PagesCst.CONTEXT_FIGHT_REPORT);
	ArrayList<PlayerInterface> s2 = (ArrayList<PlayerInterface>)session.getAttribute(PagesCst.CONTEXT_FIGHT_REPORT_S2);
	ArrayList<PlayerInterface> s1 = (ArrayList<PlayerInterface>)session.getAttribute(PagesCst.CONTEXT_FIGHT_REPORT_S1);
	
	session.removeAttribute(PagesCst.CONTEXT_FIGHT_REPORT);
	session.removeAttribute(PagesCst.CONTEXT_FIGHT_REPORT_S1);
	session.removeAttribute(PagesCst.CONTEXT_FIGHT_REPORT_S2);
	%>
	<center>
	<table>
		<tr>
			<td width="390" align="center">
				<%@ include file="../decorators/b2pre.jsp"%>
				<table><tr>
			<%
				for(int i=0;i<s1.size();i++){
					%><td align="center">
					<img style="border:1px outset gray;" width="100px" height="100px" src="<%= request.getContextPath()%>/imgs/player/<%= s1.get(i).getPic() %>" alt="<%= s1.get(i).getPic() %>" />					
					<br/><%= s1.get(i).getName() %>
					</td><%
				}
			 %>
			 	</tr></table>
			 	<%@ include file="../decorators/b2post.jsp"%>
			</td>
			<td width="200">
				<img src="<%= request.getContextPath()%>/imgs/web/vs.png" alt="VS"/>
			</td>
			<td width="390" align="center">
				<%@ include file="../decorators/b2pre.jsp"%>
				<table><tr>
			<%
				for(int i=0;i<s2.size();i++){
					%><td align="center">
					<img style="border:1px outset gray;" width="100px" height="100px" src="<%= request.getContextPath()%>/imgs/monster/<%= s2.get(i).getPic() %>.png" alt="<%= s2.get(i).getPic() %>" />					
					<br/><%= s2.get(i).getName() %>
					</td><%
				}
			 %>
			 	</tr></table>
			 	<%@ include file="../decorators/b2post.jsp"%>
			</td>
		</tr>
	</table>
	
	
	<table>
		<tr>
			<td style="width:100px; background-repeat:repeat-y; background-image: url(<%= request.getContextPath()%>/imgs/web/celcol2.png);"></td>
			<td>
	
	<table><%
	for(int i=0;i<report.size();i++){
		FightRound r = report.get(i);
		
		String className = "";
		if(! r.isSpellEffect())
			className =(r.isFirstSide())?"firstSide":"secondSide";
		%>
		<tr class="<%=className %>">
			
			<%
			
			String txt = "";
			String img = "item"+"/"+r.getAttackImg();
			String imgres = "ok";
			
			switch(r.getRoundType()){
			case InfiniteCst.ATTACK_TYPE_WEAPON:
				txt = r.getAttacker() + " attacks "+ r.getDefender() +" with " +r.getAttackName(); 
				txt += ",he rolls "+r.getAttackRoll()+ " against a CA of " +r.getDefenderCA();
				
				if(r.isHit()){
					txt += " causing "+r.getAttackDmg()+"Hp of damage";
					imgres = "ok";
				}
				else{
					txt += ", his attack fails!";
					imgres = "error";
				}
				
				break;
			case InfiniteCst.ATTACK_TYPE_MAGIC:
				
				if(r.isSpellEffect()){
					txt = r.getAttacker() + " persist on "+r.getDefender();
					imgres = "star";
				}
				else{
					txt = r.getAttacker() + " casts " +r.getAttackName();
				}
				
				img = "spell" +"/"+r.getAttackImg();
				if(r.getAttackType()==InfiniteCst.MAGIC_UNCAST){
					imgres = "error";
					txt += " but doesn't have enough MP to complete the spell";
				}
				else if(r.getAttackType()==InfiniteCst.MAGIC_HEAL){
					txt += " healing "+r.getAttackDmg()+"Hp";
				}
				else{
					txt += " causing "+r.getAttackDmg()+"Hp of damage";
				}
				break;
			case InfiniteCst.ATTACK_TYPE_ITEM:
				break;
			case InfiniteCst.ATTACK_TYPE_IDLE:
				img = "web/rest";
				imgres = "error";
				txt = r.getAttacker() + " needs to rest, regaining "+ r.getAttackDmg()+" AP/MP";
				break;
			}
			
			%>
			<td>
				<img width="30px" height="30px"
					src="<%= request.getContextPath()+"/imgs/"+img%>.png" 
					alt="<%=r.getAttackName() %>" />
			</td>
			<td>
				<img width="30px" height="30px"
					src="<%= request.getContextPath()+"/imgs/web/"+imgres%>.png" 
					alt="<%=imgres %>" />
			</td>
			<td>
				<%=txt %>
			</td>
		</tr>
		<%
		
		if(r.isEndRound()){
			%>
			<tr>
				<td>
					<img width="30px" height="30px"	src="<%= request.getContextPath()%>/imgs/web/die.png" alt="death" title="death" />
				</td>
				<td colspan="2">
					<%=r.getDefender() %> dies dropping <%=r.getGold() %> GP and <%=r.getItems().size() %> items!
					<%=r.getAttacker() %> gains <%=r.getPx() %> experience points.
				</td>
			</tr>
			<%
		}
		
		
	}
	%>
	</table>
	
	
	</td>
			<td style="width:100px; background-repeat:repeat-y; background-image: url(<%= request.getContextPath()%>/imgs/web/celcol2.png);"></td>
		</tr>
	</table>
	
	</center>
	<%
	}
else{
	response.sendRedirect(request.getContextPath()+ PagesCst.PAGE_MAP);
}

%>
</div>
</div>
<%@ include file="../decorators/b1post.jsp"%>



</body>

<%@page import="org.infinite.web.account.StartPlaying"%></html>