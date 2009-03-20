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

// Multiple delete records
String key = "";
String [] arRecKey = request.getParameterValues("key");
String sqlKey = "";
if (arRecKey == null || arRecKey.length == 0 ) {
	response.sendRedirect("arealist.jsp");
	response.flushBuffer();
	return;
}
for (int i = 0; i < arRecKey.length; i++){
	String reckey = arRecKey[i].trim();
	reckey = reckey.replaceAll("'",escapeString);

	// Build the SQL
	sqlKey +=  "(";
	sqlKey +=  "`id`=" + "" + reckey + "" + " AND ";
	if (sqlKey.substring(sqlKey.length()-5,sqlKey.length()).equals(" AND " )) { sqlKey = sqlKey.substring(0,sqlKey.length()-5);}
	sqlKey = sqlKey + ") OR ";
}
if (sqlKey.substring(sqlKey.length()-4,sqlKey.length()).equals(" OR ")) { sqlKey = sqlKey.substring(0,sqlKey.length()-4); }

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Display
		String strsql = "SELECT * FROM `Area` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("arealist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `Area` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("arealist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: Area<br><br><a href="arealist.jsp">Back to List</a></span></p>
<form action="areadelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table class="ewTable">
	<tr class="ewTableHeader">
		<td>id&nbsp;</td>
		<td>name&nbsp;</td>
		<td>world&nbsp;</td>
		<td>nx&nbsp;</td>
		<td>ny&nbsp;</td>
		<td>lockid&nbsp;</td>
		<td>cost&nbsp;</td>
	</tr>
<%
int recCount = 0;
while (rs.next()){
	recCount ++;
	String rowclass = "ewTableRow"; // Set row color
%>
<%
	if (recCount%2 != 0 ) { // Display alternate color for rows
		rowclass = "ewTableAltRow";
	}
%>
<%
	String x_id = "";
	String x_name = "";
	String x_description = "";
	String x_world = "";
	String x_nx = "";
	String x_ny = "";
	String x_lockid = "";
	String x_cost = "";

	// id
	x_id = String.valueOf(rs.getLong("id"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}
	else{
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
%>
	<tr class="<%= rowclass %>">
	<% key =  arRecKey[recCount-1]; %>
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="<%= rowclass %>"><% out.print(x_id); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_name); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_world); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_nx); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_ny); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_lockid); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_cost); %>&nbsp;</td>
  </tr>
<%
}
rs.close();
rs = null;
stmt.close();
stmt = null;
conn.close();
conn = null;
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
</table>
<p>
<input type="submit" name="Action" value="CONFIRM DELETE">
</form>
<%@ include file="footer.jsp" %>
