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

	Character c = (Character)session.getAttribute(PagesCst.CONTEXT_CHARACTER);
%>

<%@page import="org.infinite.web.PagesCst"%>
<%@page import="org.infinite.db.dao.Item"%>
<%@page import="org.infinite.util.InfiniteCst"%>
<%@page import="org.infinite.db.dao.PlayerOwnItem"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Character Equipment</title>
</head>
<body>


<div style="width:1020px;">
<%@ include file="../decorators/b1pre.jsp"%>

<div style="padding: 1% 1% 1% 1%; margin-bottom:30px;">

<table>
	<tr>
		<td class="equipbody">
		<table width="500px" height="500px" border=0>
			<tr style="height: 25%;">
				<td align="center" valign="middle">
				<div class="equipped" id="handleft">				
				<% 
					Item it = c.getHandLeft();
					if(it!=null){
						%>
							<div class="iconlarge" style="background-image: url(<%= request.getContextPath() %>/imgs/item/<%= it.getImage() %>.png);">
								<div class="tile"/>
							</div>
						<%
					}
					
				%>
				</div>
				</td>
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="handright">
				<% 
					it = c.getHandRight();
					if(it!=null){
						%>
							<div class="iconlarge" style="background-image: url(<%= request.getContextPath() %>/imgs/item/<%= it.getImage() %>.png);">
								<div class="tile"/>
							</div>
						<%
					}
					
				%>
				</div>
				</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td align="center" valign="middle">
				<div class="equipped" id="body">
				<% 
					it = c.getBody();
					if(it!=null){
						%>
							<div class="iconlarge" style="background-image: url(<%= request.getContextPath() %>/imgs/item/<%= it.getImage() %>.png);">
								<div class="tile"/>
							</div>
						<%
					}
					
				%>
				</div>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr style="height: 25%;">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
		<td>
		<%@ include file="../decorators/b2pre.jsp"%>
		<div style="width:420px;height:500px;overflow:auto;padding: 1% 1% 1% 1%;">
		<div>
		<center>
			<table cellpadding="0" cellspacing="0" border="0" width="100%" >
				<tr><th></th><th>Image</th><th>Name</th><th>Description</th></tr>
				
				<%
				ArrayList<PlayerOwnItem> pois = c.getInventory();
				for (int i = 0; i < pois.size(); i++) {
					%><tr>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;" valign="middle">
						
							<form action="<%=request.getContextPath()%>/equip" method="POST">
							<input type="hidden" name="itemid" value="<%=pois.get(i).getId()%>"/>
							<input type="hidden" name="mode" value="<%=InfiniteCst.POI_EQUIP%>"/>
							<input type="submit" value="Equip" class="buttonstyle" />
							</form>
						
							<form action="<%=request.getContextPath()%>/equip" method="POST" onsubmit="return confirmDrop();">
							<input type="hidden" name="itemid" value="<%=pois.get(i).getId()%>"/>
							<input type="hidden" name="mode" value="<%=InfiniteCst.POI_DROP%>"/>
							<input type="submit" value="Drop" class="buttonstyle"/>
							</form>
						
						</td>
						<td  style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;">
							<div class="iconlarge" style="background-image: url(<%= request.getContextPath() %>/imgs/item/<%= pois.get(i).getItem().getImage() %>.png);">
								<div class="tile"/>
							</div>
							
						</td>						
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;"><%= pois.get(i).getItem().getName() %></td>
						<td style="background-color:<%=(i%2==0)?"#DDCDA5":"transparent" %>;"><%= pois.get(i).getItem().getDescr() %></td>
					</tr><%
				}
				%>
					
			</table>
			
			</center>

		</div>
		</div>
		<%@ include file="../decorators/b2post.jsp"%>
		</td>
	</tr>
</table>
<%@ include file="../decorators/b1post.jsp"%>
</div></div>
<script type="text/javascript">
function confirmDrop(){
	return confirm("Do you really want to drop this item?");
}
</script>
</body>

</html>