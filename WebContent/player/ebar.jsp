<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.objects.Character"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.engines.map.MapEngine"%><html>
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
				<td>



				<div class="iconmedium"
					style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_map.png);">
				<div class="tile"><a
					href="<%=request.getContextPath()%><%=PagesCst.PAGE_MAP%>" ></a></div>
				</div>



				</td>
				<td>
				<div class="iconmedium"
					style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_equip.png);">
				<div class="tile"><a
					href="<%=request.getContextPath()%><%=PagesCst.PAGE_EQUIP%>" ></a></div>
				</div>

				</td>

			</tr>
			<tr>
				<td>
				<div class="iconmedium"	style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_spell.png);">
				<div class="tile"><a
					href="<%=request.getContextPath()%><%=PagesCst.PAGE_SPELL%>"></a></div>
				</div>
				</td>
				<td>
				<div class="iconmedium"	style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_attack.png);">
				<div class="tile"><a
					href="<%=request.getContextPath()%><%=PagesCst.PAGE_BATTLEPLAN%>"></a></div>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div class="iconmedium"	style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_stat.png);">
				<div class="tile"><a
					href="<%=request.getContextPath()%><%=PagesCst.PAGE_STATUS%>" ></a></div>
				</div>
				</td>
				<td>
				<div class="iconmedium"	style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_quest.png);">
				<div class="tile"><a
					href="javascript:alert('TODO')" ></a></div>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div class="iconmedium"	style="background-image: url(<%=request.getContextPath()%>/imgs/web/menu_msg.png);">
				<div class="tile"><a
					href="javascript:alert('TODO')" ></a></div>
				</div>
				</td>
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
		<td align="center"><a
			href="<%=request.getContextPath()%><%=PagesCst.PAGE_MAP%>"><%= MapEngine.getAreaFromAreaItem( c.getAreaItem() ).getName()%></a></td>
	</tr>
	<tr>
		<td align="center"
			style="border: 3px double #B69F7F; font-size: x-small; background-color: white; color: black; font-style: italic;"><%=MapEngine.getAreaFromAreaItem( c.getAreaItem() ).getDescription()%></td>
	</tr>
</table>


</div>
</center>
</body>
</html>