<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.engines.fight.FightRound"%>
<%@page import="org.infinite.objects.Character"%>

<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.engines.fight.PlayerInterface"%>

<%
	if(StartPlaying.redirectToCharSelect(session,request,response))
		return;
%>



<html>
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
					<img style="border:1px outset gray;" width="100px" height="100px" src="<%=PagesCst.IMG_MONST_PATH + s2.get(i).getPic() + PagesCst.IMG_MONST_EXT%>" alt="<%= s2.get(i).getPic() %>" />					
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
			
			String img = r.getAttackImg();
			if(img.indexOf(",")!=-1){
				String[] imgs = img.split(",");
				img = "";
				for(int imgi=0;imgi<imgs.length;imgi++){
					img += "," + PagesCst.IMG_ITEM_PATH + imgs[imgi] + PagesCst.IMG_ITEM_EXT;
				}
				img = img.substring(1);
			}
			else{
				img = PagesCst.IMG_ITEM_PATH + img + PagesCst.IMG_ITEM_EXT;
			}
				
			String imgres = "ok";
			
			switch(r.getRoundType()){
			case InfiniteCst.ATTACK_TYPE_WEAPON:
				txt = r.getAttacker() + " attacks "+ r.getDefender() +" with " +r.getAttackName().replaceAll(","," & "); 
				txt += ",he rolls ";
				int[] rolls = r.getAttackRoll();
				for(int rs=0;rs<rolls.length;rs++){
					txt += rolls[rs];
					txt += (rs<rolls.length-1)?",":"";
				}
				txt += " against a CA of " +r.getDefenderCA();
				
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
				
				img = PagesCst.IMG_SPELL_PATH+r.getAttackImg()+PagesCst.IMG_SPELL_EXT;
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
				img = request.getContextPath()+"/imgs/web/rest.png";
				imgres = "error";
				txt = r.getAttacker() + " needs to rest, regaining "+ r.getAttackDmg()+" AP/MP";
				break;
			}
			
			%>
			<td nowrap="nowrap">
				<%
				String[] imgs = img.split(",");
				for(int ii=0;ii<imgs.length;ii++){
					%>
						<img width="30px" height="30px" src="<%=imgs[ii]%>"	alt="<%=r.getAttackName()%>" />
					<%
				}
				
				%>
			
				
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
					<%=r.getDefender() %> dies, <%=r.getAttacker() %> gains
					<%=r.getGold() %> GP,
					<%=r.getItems().size() %> items 
					<%
						if( r.getItems().size()>0){
							%>[<%
							for(int k=0;k<r.getItems().size();k++){
								%>
									<img width="20" title="<%=r.getItems().get(k).getName()%>" alt="<%=r.getItems().get(k).getName()%>" src="<%= PagesCst.IMG_ITEM_PATH + r.getItems().get(k).getImage() + PagesCst.IMG_ITEM_EXT%>"/>&nbsp;
								<%
							}
							 %>]<%
						}
					%>					
					and <%=r.getPx() %> PX.
				</td>
			</tr>
			<%
		}
		
		
	}
	%>
		<tr>
			<td>
				<div class="iconmedium"
					style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_map.png);">
				<div class="tile"><a
					href="<%=request.getContextPath()%><%=PagesCst.PAGE_MAP%>" ></a></div>
				</div>
			</td>
			<td colspan="2" align="left">Back To Map</td>
		</tr>
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

</html>