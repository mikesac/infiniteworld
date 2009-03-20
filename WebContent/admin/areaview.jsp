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
if (key == null || key.length() == 0) { response.sendRedirect("arealist.jsp");}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}
String x_id = "";
String x_name = "";
String x_description = "";
String x_world = "";
String x_nx = "";
String x_ny = "";
String x_lockid = "";
String x_cost = "";

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")) {// Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Area` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			out.clear();
			response.sendRedirect("arealist.jsp");
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

		// description
		if (rs.getClob("description") != null) {
			long length = rs.getClob("description").length();
			x_description = rs.getClob("description").getSubString((long) 1, (int) length);
		}else{
			x_description = "";
		}

		// world
		x_world = String.valueOf(rs.getLong("world"));

		// nx
		x_nx = String.valueOf(rs.getLong("nx"));

		// ny
		x_ny = String.valueOf(rs.getLong("ny"));

		// lockid
		x_lockid = String.valueOf(rs.getLong("lockid"));

		// cost
		x_cost = String.valueOf(rs.getLong("cost"));
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">View TABLE: Area<br><br><a href="arealist.jsp">Back to List</a></span></p>
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
		<td class="ewTableHeader">description&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_description != null) { out.print(((String)x_description).replaceAll("\r\n", "<br>"));} %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">world&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_world); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">nx&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_nx); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ny&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_ny); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">lockid&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_lockid); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_cost); %>&nbsp;</td>
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
