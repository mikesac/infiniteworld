<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Infinite World Administrator Console</title>
</head>
<body>
<center>
<table width="100%" align="center">
	<tr align="center">
	<td colspan="15">Welcome to administrator interface!<br/>From this panel you can create new element to expand Infinite World game plot</td>
	</tr>
	<tr align="center">
		<td valign="middle">
			<a href="/InfiniteWeb/admin/map/mapUtil.jsp">
				<img width="36" src="/InfiniteWeb/imgs/maps/icons/map.png">
				Create New Maps
			</a>
		</td>
	<td>&nbsp;</td>
		<td valign="middle">
			<a href="/InfiniteWeb/admin/map/mapItems.jsp">
				<img width="36" src="/InfiniteWeb/imgs/maps/icons/step.png">
				Create New Area Items
			</a>
		</td>
	<td>&nbsp;</td>
		<td valign="middle">
			<a href="/InfiniteWeb/admin/itemlist.jsp?cmd=resetall">
				<img width="36" src="/InfiniteWeb/imgs/item/bastard.jpg">
				Create New Items
			</a>
		</td>
	<td>&nbsp;</td>
		<td valign="middle">
			<a href="/InfiniteWeb/admin/npclist.jsp?cmd=resetall">
				<img width="36" src="/InfiniteWeb/imgs/maps/icons/fight.png">
				Create New NPCs
			</a>
		</td>
	<td>&nbsp;</td>
		<td valign="middle">
			<a href="/InfiniteWeb/admin/spelllist.jsp?cmd=resetall">
				<img width="36" src="/InfiniteWeb/imgs/spell/mmissile.jpg">
				Create New Spells
			</a>
		</td>
	</tr>


</table>

</center>

</body>
</html>