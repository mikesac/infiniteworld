<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.web.account.StartPlaying"%>

<%
	if (StartPlaying.redirectToCharSelect(session, request, response))
		return;

	Character c = (Character) session
			.getAttribute(PagesCst.CONTEXT_CHARACTER);
%>


<%@page import="org.infinite.engines.AI.newAIEngine"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Player Status</title>
</head>
<body>


<div style="width: 1020px;">
<%@ include	file="../decorators/b1pre.jsp"%>

<table cellpadding="5">
	
			<tr>
				<th colspan="2">Type</th>
				<th>Base</th>
				<th>Mod</th>
				<th>&nbsp;</th>
				<th colspan="2">Type</th>
				<th>Base</th>
				<th>Mod</th>
				<th>&nbsp;</th>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/life.png);">
				<div class="tile" />
				</div>
				</td>
				<td><p style="color:#B80701">Life Points (LP)</p>
				<p class="smallfont">Life points represents the amount of damage you can get from enemies before being defeated.</p>
				</td>
				<td><%=c.getPointsLifeBase()%></td>
				<td><%=c.getPointsLifeMax() - c.getPointsLifeBase()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/str.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#B80701">Strength (STR)</p>
					<p class="smallfont">Strength represent your player constitution and ability to inflict damage. Increasing your strength will give you bonus on hit and damage roll in melee fight and increase your LP</p>
				</td>
				<td><%=c.getDao().getBaseStr()%></td>
				<td><%=c.getStrenght() - c.getDao().getBaseStr()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/mana.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#1B1DDF">Magic Points (MP)</p>
				<p class="smallfont">Magic points determines the amount of magic spell you can cast. If you try to cast a spell with insufficient MP the spell will fail</p>
				</td>
				<td><%=c.getPointsMagicBase()%></td>
				<td><%=c.getPointsMagicMax() - c.getPointsMagicBase()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/int.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#1B1DDF">Intelligence (INT)</p>
					<p class="smallfont">Intelligence is your character acknowledge of the mysteries of the world and its rules and it's the door to magic. Increasing you intelligence will enhance you ability to cast spell and your MP</p>
				</td>
				<td><%=c.getDao().getBaseInt()%></td>
				<td><%=c.getIntelligence() - c.getDao().getBaseInt()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/action.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#CFA80C">Action Points (AP)</p>
				<p class="smallfont">Action point gives you mobility. Any action you perform (moving, fighting,etc) will consume AP, once terminated you will have to rest before moving again.</p>
				</td>
				<td><%=c.getPointsActionBase()%></td>
				<td><%=c.getPointsActionMax() - c.getPointsActionBase()%></td>
				<<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/dex.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#CFA80C">Dexterity (DEX)</p>
					<p class="smallfont">Dexterity is your attitude to move fast and carefully, it will influence your reflex and your efficiency in battle. Increasing dexterity will bring you more AP to performed any desired action.</p>
				</td>
				<td><%=c.getDao().getBaseDex()%></td>
				<td><%=c.getDexterity() - c.getDao().getBaseDex()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
			</tr>
			
			
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/charm.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#9800F0">Charm Points (CP)</p>
				<p class="smallfont">Charm points represents your smartness and your ability to trade.You can use them to teke advantage over shopkeepers or other players</p>
				</td>
				<td><%=c.getPointsCharmBase()%></td>
				<td><%=c.getPointsCharmMax() - c.getPointsCharmBase()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/cha.png);">
				<div class="tile" /></div>
				</td>
				<td><p style="color:#9800F0">Charisma (CHA)</p>
					<p class="smallfont">Charisma is your ability to seduce people with your tales and to think in a different way than anybody else. It won't help you in meelee fight but will let you find a shortcut to defeat your enemy without having to face him.</p>
				</td>
				<td><%=c.getDao().getBaseCha()%></td>
				<td><%=c.getCharisma() - c.getDao().getBaseCha()%></td>
				<td><img src="../imgs/web/plus.png" alt="Increment this skill" title="Increment this skill"/></td>
			</tr>
	
	
			<tr>
				<td>
				<div class="iconlarge"
					style="background-image: url(../imgs/web/stats/px.png);">
				<div class="tile" /></div>
				</td>
				<td colspan="3">
					<p style="color:#0486E6">Experience Points (XP)</p>
					<p class="smallfont">Experience Pints represent the progress of your character, once the bar is filled you will level up.</p>
					
					<div class="txp_big">
						<div class="cxp_big" style="width:<%= Math.round((200*c.getExperience())/newAIEngine.getLevelPx( c.getLevel() +1)) %>px;">
							<div style="white-space: nowrap;"><%=c.getExperience() %> / <%=newAIEngine.getLevelPx( c.getLevel() +1) %></div>
						</div>
					</div>
					
					
				</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
	
		</table>

<%@ include file="../decorators/b1post.jsp"%></div>

</body>
</html>