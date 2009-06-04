<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="org.infinite.db.dao.AreaItem"%>
<%@page import="org.infinite.db.dao.Area"%>
<%@page import="org.infinite.util.GenericUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.infinite.engines.map.MapEngine"%>
<%@page import="org.infinite.objects.Map"%>

<%
	
	int id = GenericUtil.toInt( request.getParameter("areaid") , -1);

	Area a = (Area)Manager.findById(Area.class.getName(),id);
	
    %>




<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.db.Manager"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Map Editor</title>


</head>
<body>

<table>
	<tr>
		<td>
			<div style="width:<%= Map.MAP_WIDTH + 20 %>px;">
<%@ include file="../../decorators/b2pre.jsp"%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=Map.MAP_WIDTH%>px" height="<%=Map.MAP_HEIGHT%>">
<%
for(int y=0;y<a.getNy();y++){
	%><tr> <%
	for(int x=0;x<a.getNx();x++){
		%>
		<td style="width:<%= (Map.MAP_WIDTH / a.getNx()) %>;height:<%=(Map.MAP_HEIGHT / a.getNy())%>;background-image:url('<%=request.getContextPath()+"/imgs/maps/"+a.getName()+"/"+a.getName()+"_"+y+x%>.jpg');">
		<%
		List<AreaItem> l = (ArrayList<AreaItem>)Manager.listByQuery("from "+AreaItem.class.getName()+" i where i.areaid='"+a.getId()+"'  and i.areax='"+x+"' and i.areay='"+y+"'");
		
		for (Iterator<AreaItem> iterator = l.iterator(); iterator.hasNext();) {
			AreaItem areaItem = (AreaItem) iterator.next();			
			%>
				<div class="iconmedium"	style="width: 36px;height: 36px;position:relative;top:<%=areaItem.getY() %>px;left:<%=areaItem.getX() %>px;background-image: url(<%=request.getContextPath()%>/imgs/maps/icons/<%=areaItem.getIcon()%>.png);">
				<div class="tile"/>
				</div>
			<%			
		}
		%></td><%
	}
	 %></tr>
	 <%
}
%>
</table>

<%@ include file="../../decorators/b2post.jsp"%>
</div>
		
		</td>
		<td valign="top">
			<div style="width: 300px">
			<%@ include file="../../decorators/b2pre.jsp"%>
			Edit Area Item Data 
			<form action="" method="post">
		<table>
			<tr>
				<td>name</td>
				<td><input type="text" name="aiName"></td>
			</tr>
			<tr>
				<td>icon</td>
				<td>
					<select name="aiIcon">
						<%
							ArrayList<String> icoList = (ArrayList<String>)Manager.listByQuery("select distinct i.icon from "+AreaItem.class.getName()+" i");
						for(int i=0;i<icoList.size();i++){
							%><option value="<%=icoList.get(i)%>"><%=icoList.get(i)%></option><%
						}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>cost</td>
				<td><input type="text" name="aiCost" size=3></td>
			</tr>
			
			<tr>
				<td>areax</td>
				<td><input type="text" name="aiAX" size=3></td>
			</tr>
			<tr>
				<td>areay</td>
				<td><input type="text" name="aiAY" size=3></td>
			</tr>
			<tr>
				<td>x</td>
				<td><input type="text" name="aiX" size=3></td>
			</tr>
			<tr>
				<td>y</td>
				<td><input type="text" name="aiY" size=3></td>
			</tr>
			<tr>
				<td>arealock</td>
				<td><input type="text" name="aiALock" size=3></td>
			</tr>
			<tr>
				<td>questlock</td>
				<td><input type="text" name="aiQLock" size=3></td>
			</tr>
			<tr>
				<td>url</td>
				<td><input type="text" name="aiURL" ></td>
			</tr>
			<tr>
				<td>direct</td>
				<td><input type="checkbox" name="aiDirect"> </td>
			</tr>
			<tr>
				<td>loop</td>
				<td><input type="checkbox" name="aiLoop"></td>
			</tr>
			<tr>
				<td>hidemode</td>
				<td><input type="checkbox" name="aiHide"></td>
			</tr>
			<tr>
				<td>areaItemLevel</td>
				<td><input type="text" name="aiLevel" size=3></td>
			</tr>
			<tr>
				<td>npcs</td>
				<td><input type="text" name="aiNpcs" ></td>
			</tr>
		</table>
		<input type="hidden" name="aiAreaId" value="<%=a.getId() %>">

		</form>
			
			<%@ include file="../../decorators/b2post.jsp"%>
			</div>
		</td>
	</tr>
</table>



</body>
</html>