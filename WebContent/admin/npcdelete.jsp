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
	response.sendRedirect("npclist.jsp");
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
		String strsql = "SELECT * FROM `NPC` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("npclist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `NPC` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("npclist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: NPC<br><br><a href="npclist.jsp">Back to List</a></span></p>
<form action="npcdelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table class="ewTable">
	<tr class="ewTableHeader">
		<td>id&nbsp;</td>
		<td>name&nbsp;</td>
		<td>image&nbsp;</td>
		<td>base str&nbsp;</td>
		<td>base int&nbsp;</td>
		<td>base dex&nbsp;</td>
		<td>base cha&nbsp;</td>
		<td>base pl&nbsp;</td>
		<td>base pm&nbsp;</td>
		<td>base pa&nbsp;</td>
		<td>base pc&nbsp;</td>
		<td>level&nbsp;</td>
		<td>px&nbsp;</td>
		<td>status&nbsp;</td>
		<td>area&nbsp;</td>
		<td>gold&nbsp;</td>
		<td>xml dialog&nbsp;</td>
		<td>xml items&nbsp;</td>
		<td>xml behave&nbsp;</td>
		<td>ismonster&nbsp;</td>
		<td>nattack&nbsp;</td>
		<td>attack&nbsp;</td>
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
	String x_image = "";
	String x_description = "";
	String x_base_str = "";
	String x_base_int = "";
	String x_base_dex = "";
	String x_base_cha = "";
	String x_base_pl = "";
	String x_base_pm = "";
	String x_base_pa = "";
	String x_base_pc = "";
	String x_level = "";
	String x_px = "";
	String x_status = "";
	String x_area = "";
	String x_gold = "";
	String x_xml_dialog = "";
	String x_xml_items = "";
	String x_xml_behave = "";
	String x_ismonster = "";
	String x_nattack = "";
	String x_attack = "";

	// id
	x_id = String.valueOf(rs.getLong("id"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}
	else{
		x_name = "";
	}

	// image
	if (rs.getString("image") != null){
		x_image = rs.getString("image");
	}
	else{
		x_image = "";
	}

	// description
	if (rs.getClob("description") != null) {
		long length = rs.getClob("description").length();
		x_description = rs.getClob("description").getSubString((long) 1, (int) length);
	}else{
		x_description = "";
	}

	// base_str
	x_base_str = String.valueOf(rs.getLong("base_str"));

	// base_int
	x_base_int = String.valueOf(rs.getLong("base_int"));

	// base_dex
	x_base_dex = String.valueOf(rs.getLong("base_dex"));

	// base_cha
	x_base_cha = String.valueOf(rs.getLong("base_cha"));

	// base_pl
	x_base_pl = String.valueOf(rs.getLong("base_pl"));

	// base_pm
	x_base_pm = String.valueOf(rs.getLong("base_pm"));

	// base_pa
	x_base_pa = String.valueOf(rs.getLong("base_pa"));

	// base_pc
	x_base_pc = String.valueOf(rs.getLong("base_pc"));

	// level
	x_level = String.valueOf(rs.getLong("level"));

	// px
	x_px = String.valueOf(rs.getLong("px"));

	// status
	x_status = String.valueOf(rs.getLong("status"));

	// area
	x_area = String.valueOf(rs.getLong("area"));

	// gold
	x_gold = String.valueOf(rs.getDouble("gold"));

	// xml_dialog
	if (rs.getString("xml_dialog") != null){
		x_xml_dialog = rs.getString("xml_dialog");
	}
	else{
		x_xml_dialog = "";
	}

	// xml_items
	if (rs.getString("xml_items") != null){
		x_xml_items = rs.getString("xml_items");
	}
	else{
		x_xml_items = "";
	}

	// xml_behave
	if (rs.getString("xml_behave") != null){
		x_xml_behave = rs.getString("xml_behave");
	}
	else{
		x_xml_behave = "";
	}

	// ismonster
	x_ismonster = String.valueOf(rs.getLong("ismonster"));

	// nattack
	x_nattack = String.valueOf(rs.getLong("nattack"));

	// attack
	if (rs.getString("attack") != null){
		x_attack = rs.getString("attack");
	}
	else{
		x_attack = "";
	}
%>
	<tr class="<%= rowclass %>">
	<% key =  arRecKey[recCount-1]; %>
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="<%= rowclass %>"><% out.print(x_id); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_name); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_image); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_str); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_int); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_dex); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_cha); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_pl); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_pm); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_pa); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_base_pc); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_level); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_px); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_status); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_area); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_gold); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_xml_dialog); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_xml_items); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_xml_behave); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_ismonster); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_nattack); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_attack); %>&nbsp;</td>
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
