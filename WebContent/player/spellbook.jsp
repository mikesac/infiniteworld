<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.db.dao.Spell"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%
	Spell s = (Spell)session.getAttribute(PagesCst.CONTEXT_SPELLBOOK);
	session.removeAttribute(PagesCst.PAGE_SPELLBOOK);
	
	if(s==null){
		%>
<p>Spell not found</p>
<%
		return;
	}
%>


<table>
	<tr>
		<td colspan="4"><%= s.getName() %></td>
	</tr>
	<tr>
		<td><img src="../imgs/spell/<%= s.getImage() %>.png" /></td>
		<td colspan="3"><%= s.getDesc() %></td>
	</tr>
	<tr>
		<td colspan="4">Details</td>
	</tr>
	<tr>
		<td>Mana Cost</td>
		<td><%= s.getCostMp() %></td>
		<td><%= (s.getSpelltype()==InfiniteCst.MAGIC_HEAL)?"Heal":"Damage" %>
		</td>
		<td><%= s.getDamage() %></td>
	</tr>
	<tr>
		<td>Duration</td>
		<td><%= s.getDuration()/1000 %>s</td>
		<td>Saving Throw</td>
		<td><%= s.getSavingthrow() %></td>
	</tr>

	<tr>
		<td>Level</td>
		<td><%= s.getLev() %></td>
		<td>Initiative</td>
		<td><%= s.getInitiative() %></td>
	</tr>
	<tr>
		<td colspan="4">Required</td>
	</tr>
	<tr>
		<td>Strength</td>
		<td><%= s.getReqStr() %></td>
		<td>Intelligence</td>
		<td><%= s.getReqInt() %></td>
	</tr>
	<tr>
		<td>Dexterity</td>
		<td><%= s.getReqDex() %></td>
		<td>Charisma</td>
		<td><%= s.getReqCha() %></td>
	</tr>

	<tr>
		<td colspan="4">Modificators</td>
	</tr>
	<tr>
		<td>Strength</td>
		<td><%= s.getModStr() %></td>
		<td>Intelligence</td>
		<td><%= s.getModInt() %></td>
	</tr>
	<tr>
		<td>Dexterity</td>
		<td><%= s.getModDex() %></td>
		<td>Charisma</td>
		<td><%= s.getModCha() %></td>
	</tr>
</table>