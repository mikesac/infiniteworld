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
	int id = GenericUtil.toInt(request.getParameter("areaid"), 1);
	Area a = (Area) Manager.findById(Area.class.getName(), id);
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


<table width="100%">
	<tr>
		<td style="width:<%= Map.MAP_WIDTH + 40 %>px;">
			
			<div style="width:<%= Map.MAP_WIDTH + 20 %>px;">
			<%@ include file="../../decorators/b2pre.jsp"%>
			
			<table cellpadding=0 cellspacing=0 border=0 width="<%=Map.MAP_WIDTH%>px" height="<%=Map.MAP_HEIGHT%>" id="prwTable" >
			<%
			for (int y = 0; y < a.getNy(); y++) 
				{
				%><tr> <%
			 		for (int x = 0; x < a.getNx(); x++) 
			 		{
			 			%>
						<td style="width:<%=(Map.MAP_WIDTH / a.getNx())%>;height:<%=(Map.MAP_HEIGHT / a.getNy())%>;background-image:url('<%=request.getContextPath() + "/imgs/maps/"+ a.getName() + "/" + a.getName() + "_" + y + x%>.jpg');">
						<%
							List<AreaItem> l = (ArrayList<AreaItem>) Manager.listByQuery("from " + AreaItem.class.getName()+ " i where i.areaid='" + a.getId()+ "'  and i.areax='" + x+ "' and i.areay='" + y + "'");
			
							for (Iterator<AreaItem> iterator = l.iterator(); iterator.hasNext();) 
							{
								AreaItem areaItem = (AreaItem) iterator.next();
								%>
								<div onclick="getAreaData(<%=areaItem.getId()%>)" class="iconmedium" id="<%=areaItem.getName()%>" style="position:relative;top:<%=areaItem.getY()%>px;left:<%=areaItem.getX()%>px;background-image: url(<%=request.getContextPath()%>/imgs/maps/icons/<%=areaItem.getIcon()%>.png);">
								<div class="tile">&nbsp;</div>
								</div>
								<%
							}
						%></td><%
							}
					%></tr><%
				 }
			%>
			</table>
			
			<%@ include file="../../decorators/b2post.jsp"%>
			</div>
		
		</td>
		<td valign="top">
			<div style="width: 400px" align="center">
			<%@ include file="../../decorators/b2pre.jsp"%>
			<h3 style="text-align: center">Edit Area Item Data</h3> 
			
			<form action="<%=request.getContextPath()%>/saveAreaItem" name="formedit" method="post">
			
			<input type="hidden" name="areaid" value="<%=a.getId()%>" />
			<input type="hidden" name="act" value="1" />
			
		<table>
		
			<tr>
				<td>id</td>
				<td><input type="text" name="id" readonly="readonly" size="3"></td>
			</tr>
			<tr>
				<td>name</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>icon</td>
				<td>
					<select name="icon">
						<%
							ArrayList<String> icoList = (ArrayList<String>) Manager
									.listByQuery("select distinct i.icon from "
											+ AreaItem.class.getName() + " i");
							for (int i = 0; i < icoList.size(); i++) {
						%><option value="<%=icoList.get(i)%>"><%=icoList.get(i)%></option><%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>cost</td>
				<td><input type="text" name="cost" size=3></td>
			</tr>
			
			<tr>
				<td>areax</td>
				<td><input type="text" name="areax" size=3></td>
			</tr>
			<tr>
				<td>areay</td>
				<td><input type="text" name="areay" size=3></td>
			</tr>
			<tr>
				<td>x</td>
				<td><input type="text" name="x" size=3></td>
			</tr>
			<tr>
				<td>y</td>
				<td><input type="text" name="y" size=3></td>
			</tr>
			<tr>
				<td>arealock</td>
				<td><input type="text" name="arealock" size=3></td>
			</tr>
			<tr>
				<td>questlock</td>
				<td><input type="text" name="questlock" size=3></td>
			</tr>
			<tr>
				<td>url</td>
				<td><input type="text" name="url" ></td>
			</tr>
			<tr>
				<td>loop</td>
				<td><input type="checkbox" name="loop"></td>
			</tr>
			<tr>
				<td>hidemode</td>
				<td><input type="checkbox" name="hide"></td>
			</tr>
			<tr>
				<td>areaItemLevel</td>
				<td><input type="text" name="areaItemLevel" size=3></td>
			</tr>
			<tr>
				<td>npcs</td>
				<td><input type="text" name="npcs" ></td>
			</tr>
		</table>
		
		<input type="submit" value="Save" />
		</form>

		<table>
			<tr>
				<td>
					<button onclick="preview()" style="font-size:x-small">Preview (only X & Y)</button>
				</td>
				
				<td>
					<button onclick="newArea()" style="font-size:x-small">New</button>
				</td>
				
				<td>
					<button onclick="togglePad()" style="font-size:x-small">Toggle Border</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">
				<form method="post" name="formlist"
					action="<%=request.getContextPath() + PagesCst.ADMIN_MAPITEMS%>">
				<select name="areaid">
					<%
						ArrayList<Area> list = (ArrayList<Area>) Manager.listByQuery("from " + Area.class.getName());
						for (int i = 0; i < list.size(); i++) {
					%>
					<option value="<%=list.get(i).getId()%>"  <%= list.get(i).getId()==id?"selected=\"selected\"":""  %> ><%=list.get(i).getName()%></option>
					<%
						}
					%>

				</select> <input type="submit" value="go"></form>
				</td>
			</tr>
		</table>
		
			
			<%@ include file="../../decorators/b2post.jsp"%>
			</div>
			
			
			
		
		
			
			
			
		</td>
	</tr>
	
</table>

<script type="text/javascript" src="../../js/prototype.js"></script>
<script>
	var padded = false;

	function togglePad() {

		if (padded) {
			document.getElementById("prwTable").cellPadding = 0;
			document.getElementById("prwTable").cellSpacing = 0;
		} else {
			document.getElementById("prwTable").cellPadding = 2;
			document.getElementById("prwTable").cellSpacing = 2;
		}
		padded = !padded;

	}

	function preview(){
		var name = document.forms['formedit'].elements["name"].value;
		var x = document.forms['formedit'].elements["x"].value + "px";
		var y = document.forms['formedit'].elements["y"].value + "px";

		document.getElementById(name).style.left = x;
		document.getElementById(name).style.top = y;
		
	}
	
	function getAreaData(id){

		new Ajax.Request('<%=request.getContextPath()%>/admin/map/jsonAreaItem.jsp', {
			  parameters: { id: id },
			  method: 'get',
			  sanitizeJSON:true,
			  onSuccess: function(response) {
				  	jdata = response.responseJSON;

				  	

					for(var i=0;i<document.forms['formedit'].elements.length;i++){
						var name = document.forms['formedit'].elements[i].name;

						if(document.forms['formedit'].elements[name].type=="checkbox"){
							document.forms['formedit'].elements[name].checked=jdata[name];
						}
						else{						
							document.forms['formedit'].elements[name].value = jdata[name];
						}
					}
					document.forms['formedit'].elements["act"].value="1";					
				  }							  
			});		
	}

	function newArea(){

		document.forms['formedit'].elements["act"].value="0";
		document.forms['formedit'].reset();
		document.forms['formedit'].submit();
	}

	
</script>

</body>
</html>