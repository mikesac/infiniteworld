<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.web.PagesCst"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<center>
<div>
<table width="100%">

	<tr>
		<td>
		
		<table border="0" cellpadding="2" cellspacing="2" width="100%">
			<tr>
				<td class="icon_med">
					<a href="<%=request.getContextPath()%><%=PagesCst.PAGE_MAP%>">
						<img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_map.png" alt="Map" title="Map" >
					</a>
				</td>
				<td class="icon_med">
					<a href="<%=request.getContextPath()%><%=PagesCst.PAGE_EQUIP%>">
						<img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_equip.png" alt="Equip" title="Equip" >
					</a>
				</td>
				
			</tr>
			<tr>
				<td class="icon_med"><img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_stat.png" alt="Stats" title="Stats" 
					></td>
				<td class="icon_med"><img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_quest.png" alt="Quests" title="Quests" 
					></td>
			</tr>
			
			<tr>
				<td class="icon_med"><img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_spell.png" alt="Spells" title="Spells" ></td>
				<td class="icon_med"><img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_attack.png" alt="Attack" title="Attack" ></td>
			</tr>
			
			<tr>
				<td class="icon_med"><img border=0 src="<%=request.getContextPath()%>/imgs/web/menu_msg.png" alt="Messages" title="Messages" ></td>
				<td></td>
			</tr>
			
		</table>
		</td>
	</tr>
	
	<tr>
		<td>
		<hr />
		</td>
	</tr>
	
	<tr>
		<td align="center"><a href="<%=request.getContextPath()%><%=PagesCst.PAGE_MAP%>"><%=c.getArea().getName()%></a></td>
	</tr>
	<tr>
		<td align="center" style="border: 3px double #B69F7F; font-size:x-small;background-color: white;color:black;font-style: italic;"><%=c.getArea().getDescription()%></td>
	</tr>
</table>


</div>
</center>
</body>
</html>