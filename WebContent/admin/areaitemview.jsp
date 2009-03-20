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
String x_areaid = "";
String x_ax = "";
String x_ay = "";
String x_x = "";
String x_y = "";
String x_lockid = "";
String x_url = "";
String x_direct = "";

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

		// areaid
		x_areaid = String.valueOf(rs.getLong("areaid"));

		// ax
		x_ax = String.valueOf(rs.getLong("ax"));

		// ay
		x_ay = String.valueOf(rs.getLong("ay"));

		// x
		x_x = String.valueOf(rs.getLong("x"));

		// y
		x_y = String.valueOf(rs.getLong("y"));

		// lockid
		x_lockid = String.valueOf(rs.getLong("lockid"));

		// url
		if (rs.getString("url") != null){
			x_url = rs.getString("url");
		}else{
			x_url = "";
		}

		// direct
		x_direct = String.valueOf(rs.getLong("direct"));
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
		<td class="ewTableHeader">areaid&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_areaid); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ax&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_ax); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ay&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_ay); %>&nbsp;</td>
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
		<td class="ewTableHeader">lockid&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_lockid); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">url&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_url); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">direct&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_direct); %>&nbsp;</td>
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
