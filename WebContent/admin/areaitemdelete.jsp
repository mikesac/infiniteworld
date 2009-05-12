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
	response.sendRedirect("areaitemlist.jsp");
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
		String strsql = "SELECT * FROM `AreaItem` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("areaitemlist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `AreaItem` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("areaitemlist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: Area Item<br><br><a href="areaitemlist.jsp">Back to List</a></span></p>
<form action="areaitemdelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table class="ewTable">
	<tr class="ewTableHeader">
		<td>id&nbsp;</td>
		<td>name&nbsp;</td>
		<td>icon&nbsp;</td>
		<td>cost&nbsp;</td>
		<td>areaid&nbsp;</td>
		<td>areax&nbsp;</td>
		<td>areay&nbsp;</td>
		<td>x&nbsp;</td>
		<td>y&nbsp;</td>
		<td>arealock&nbsp;</td>
		<td>questlock&nbsp;</td>
		<td>url&nbsp;</td>
		<td>direct&nbsp;</td>
		<td>loop&nbsp;</td>
		<td>hidemode&nbsp;</td>
		<td>area Item Level&nbsp;</td>
		<td>npcs&nbsp;</td>
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

	// id
	x_id = String.valueOf(rs.getLong("id"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}
	else{
		x_name = "";
	}

	// icon
	if (rs.getString("icon") != null){
		x_icon = rs.getString("icon");
	}
	else{
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
	}
	else{
		x_arealock = "";
	}

	// questlock
	if (rs.getString("questlock") != null){
		x_questlock = rs.getString("questlock");
	}
	else{
		x_questlock = "";
	}

	// url
	if (rs.getString("url") != null){
		x_url = rs.getString("url");
	}
	else{
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
	}
	else{
		x_npcs = "";
	}
%>
	<tr class="<%= rowclass %>">
	<% key =  arRecKey[recCount-1]; %>
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="<%= rowclass %>"><% out.print(x_id); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_name); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_icon); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_cost); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_areaid); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_areax); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_areay); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_x); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_y); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_arealock); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_questlock); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_url); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_direct); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_loop); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_hidemode); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_areaItemLevel); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_npcs); %>&nbsp;</td>
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
