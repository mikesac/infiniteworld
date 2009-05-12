<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
response.setDateHeader("Expires", 0); // date in the past
response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1 
response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
response.addHeader("Pragma", "no-cache"); // HTTP/1.0 
%>
<% Locale locale = Locale.getDefault();
response.setLocale(locale);%>
<% session.setMaxInactiveInterval(30*60); %>
<%@ include file="db.jsp" %>
<%@ include file="jspmkrfn.jsp" %>
<%
String tmpfld = null;
String escapeString = "\\\\'";
String key = request.getParameter("key");
if (key == null || key.length() == 0) { response.sendRedirect("areaitemlist.jsp");}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}
String x_id = "";
String x_name = "";
String x_icon = "";
String x_cost = "";
String x_areaid = "";
String x_areax = "";
String x_areay = "";
String x_x = "";
String x_y = "";
String x_arealock = "";
String x_questlock = "";
String x_url = "";
String x_direct = "";
String x_loop = "";
String x_hidemode = "";
String x_areaItemLevel = "";
String x_npcs = "";

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")) {// Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `AreaItem` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			out.clear();
			response.sendRedirect("areaitemlist.jsp");
		}else{
			rs.first();
		}

		// Get field values
		// id

		x_id = String.valueOf(rs.getLong("id"));

		// name
		if (rs.getString("name") != null){
			x_name = rs.getString("name");
		}else{
			x_name = "";
		}

		// icon
		if (rs.getString("icon") != null){
			x_icon = rs.getString("icon");
		}else{
			x_icon = "";
		}

		// cost
		x_cost = String.valueOf(rs.getLong("cost"));

		// areaid
		x_areaid = String.valueOf(rs.getLong("areaid"));

		// areax
		x_areax = String.valueOf(rs.getLong("areax"));

		// areay
		x_areay = String.valueOf(rs.getLong("areay"));

		// x
		x_x = String.valueOf(rs.getLong("x"));

		// y
		x_y = String.valueOf(rs.getLong("y"));

		// arealock
		if (rs.getString("arealock") != null){
			x_arealock = rs.getString("arealock");
		}else{
			x_arealock = "";
		}

		// questlock
		if (rs.getString("questlock") != null){
			x_questlock = rs.getString("questlock");
		}else{
			x_questlock = "";
		}

		// url
		if (rs.getString("url") != null){
			x_url = rs.getString("url");
		}else{
			x_url = "";
		}

		// direct
		x_direct = String.valueOf(rs.getLong("direct"));

		// loop
		x_loop = String.valueOf(rs.getLong("loop"));

		// hidemode
		x_hidemode = String.valueOf(rs.getLong("hidemode"));

		// areaItemLevel
		x_areaItemLevel = String.valueOf(rs.getLong("areaItemLevel"));

		// npcs
		if (rs.getString("npcs") != null){
			x_npcs = rs.getString("npcs");
		}else{
			x_npcs = "";
		}
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">View TABLE: Area Item<br><br><a href="areaitemlist.jsp">Back to List</a></span></p>
<p>
<form>
<table class="ewTable">
	<tr>
		<td class="ewTableHeader">id&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_id); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">name&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_name); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">icon&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_icon); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_cost); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areaid&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_areaid); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areax&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_areax); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areay&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_areay); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">x&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_x); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">y&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_y); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">arealock&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_arealock); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">questlock&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_questlock); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">url&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_url); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">direct&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_direct); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">loop&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_loop); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">hidemode&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_hidemode); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">area Item Level&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_areaItemLevel); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">npcs&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_npcs); %>&nbsp;</td>
	</tr>
</table>
</form>
<p>
<%
	rs.close();
	rs = null;
	stmt.close();
	stmt = null;
	conn.close();
	conn = null;
}catch(SQLException ex){
	out.println(ex.toString());
}
%>
<%@ include file="footer.jsp" %>
