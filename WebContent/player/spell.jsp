<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Map"%>
<%@page import="org.infinite.web.account.StartPlaying"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.objects.Character"%>
<%
	if (StartPlaying.redirectToCharSelect(session, request, response))
		return;

	Character c = (Character) session.getAttribute(PagesCst.CONTEXT_CHARACTER);
	String type = request.getParameter(PagesCst.CONTEXT_SPELLTYPE);
	if( type==null){
		type = ""+InfiniteCst.MAGIC_ATTACK;
	}
	
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.PlayerOwnItem"%>
<%@page import="org.infinite.db.dao.PlayerKnowSpell"%>
<%@page import="org.infinite.util.GenericUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Spell Book</title>
</head>
<body>


<div style="width: 1020px;"><%@ include
	file="../decorators/b1pre.jsp"%>

<div style="padding: 1% 1% 1% 1%; margin-bottom: 30px;">





<table cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td rowspan="2" style="width: 730px" id="spellbook">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="5" id="book_n"></td>
			</tr>
			<tr>
				<td id="book_w"></td>
				<td id="book_p1" valign="top">
				<div style="height: 443px; overflow: auto;">
				<table style="background-color: transparent;">
					<%
				ArrayList<PlayerKnowSpell> pks = null;
					switch( GenericUtil.toInt(type,0)){
					case InfiniteCst.MAGIC_ATTACK:
					pks = c.getSpellBookFight();
					break;
					case InfiniteCst.MAGIC_HEAL:
					pks = c.getSpellBookHeal();
					break;
					case InfiniteCst.MAGIC_DEFEND:
					pks = c.getSpellBookProtect();
					break;
					}
				
					for (int i = 0; i < pks.size(); i++) {
						
						%>
					<tr>
						<td><img width="50" height="50"
							src="../imgs/spell/<%=pks.get(0).getSpell().getImage()%>.png" />
						</td>
						<td nowrap="nowrap"><%=pks.get(0).getSpell().getName()%></td>
						<td>
						<table>
							<tr>
								<td valign="bottom">
								<form action="<%=request.getContextPath()%>/prepare" method="GET">
									<input type="hidden" name="spellid"	value="<%=pks.get(i).getId()%>" />
									<input type="submit" value="Detail" class="buttonstyle" /></form>
								</td>
							</tr>
							<tr>
								<td valign="bottom">
								<form action="<%=request.getContextPath()%>/prepare"
									method="POST"><input type="hidden" name="spellid"
									value="<%=pks.get(i).getId()%>" /> <input type="hidden"
									name="mode" value="<%=InfiniteCst.PKS_EQUIP%>" /> <input
									type="submit" value="Prepare" class="buttonstyle" /></form>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<%
					}
					
				%>
				</table>
				</div>
				</td>
				<td id="book_c"></td>
				<td id="book_p2"></td>
				<td id="book_e"></td>
			</tr>
			<tr>
				<td colspan="5" id="book_s"></td>
			</tr>
		</table>
		</td>
		<td id="triskel"><img
			onclick="goPage(<%=InfiniteCst.MAGIC_ATTACK%>)"
			style="position: relative; top: -65px; left: 78.5px;"
			src="../imgs/web/spell/globe_r.<%= ( type.equals(""+InfiniteCst.MAGIC_ATTACK))?"gif":"png"%>"
			alt="Attack Spells" title="Attack Spells" /> <img
			onclick="goPage(<%=InfiniteCst.MAGIC_HEAL%>)"
			style="position: relative; top: 41px; left: -18px;"
			src="../imgs/web/spell/globe_b.<%= ( type.equals(""+InfiniteCst.MAGIC_HEAL))?"gif":"png"%>"
			alt="Healing Spells" title="Healing Spells" /> <img
			onclick="goPage(<%=InfiniteCst.MAGIC_DEFEND%>)"
			style="position: relative; top: 25px; left: 40px;"
			src="../imgs/web/spell/globe_g.<%= ( type.equals(""+InfiniteCst.MAGIC_DEFEND))?"gif":"png"%>"
			alt="Protection Spells" title="Protection Spells" /></td>
	</tr>
	<tr>
		<td valign="middle" align="center"><%@ include
			file="../decorators/b2pre.jsp"%>Prepared
		Spells
		<table border=1>
			<tr>
				<td width="70" height="70">&nbsp;</td>
				<td width="70" height="70">&nbsp;</td>
				<td width="70" height="70">&nbsp;</td>
			</tr>
			<tr>
				<td width="70" height="70">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="70" height="70">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
	</tr>
</table>
<%@ include file="../decorators/b1post.jsp"%></div>
</div>
<script type="text/javascript">
	function goPage(id){
		var url = "<%=request.getContextPath()%><%=PagesCst.PAGE_SPELL%>?<%=PagesCst.CONTEXT_SPELLTYPE%>="+id;
		document.location=url;
	}
</script>
</body>

</html>