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
	response.sendRedirect("itemlist.jsp");
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
		String strsql = "SELECT * FROM `Item` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("itemlist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `Item` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("itemlist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: Item<br><br><a href="itemlist.jsp">Back to List</a></span></p>
<form action="itemdelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table class="ewTable">
	<tr class="ewTableHeader">
		<td>id&nbsp;</td>
		<td>name&nbsp;</td>
		<td>descr&nbsp;</td>
		<td>image&nbsp;</td>
		<td>cost AP&nbsp;</td>
		<td>req str&nbsp;</td>
		<td>req int&nbsp;</td>
		<td>req wis&nbsp;</td>
		<td>req dex&nbsp;</td>
		<td>req cha&nbsp;</td>
		<td>req lev&nbsp;</td>
		<td>mod str&nbsp;</td>
		<td>mod int&nbsp;</td>
		<td>mod wis&nbsp;</td>
		<td>mod dex&nbsp;</td>
		<td>mod cha&nbsp;</td>
		<td>price&nbsp;</td>
		<td>lev&nbsp;</td>
		<td>spell&nbsp;</td>
		<td>damage&nbsp;</td>
		<td>initiative&nbsp;</td>
		<td>durability&nbsp;</td>
		<td>type&nbsp;</td>
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
	String x_descr = "";
	String x_image = "";
	String x_costAP = "";
	String x_req_str = "";
	String x_req_int = "";
	String x_req_wis = "";
	String x_req_dex = "";
	String x_req_cha = "";
	String x_req_lev = "";
	String x_mod_str = "";
	String x_mod_int = "";
	String x_mod_wis = "";
	String x_mod_dex = "";
	String x_mod_cha = "";
	String x_price = "";
	String x_lev = "";
	String x_spell = "";
	String x_damage = "";
	String x_initiative = "";
	String x_durability = "";
	String x_type = "";

	// id
	x_id = String.valueOf(rs.getLong("id"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}
	else{
		x_name = "";
	}

	// descr
	if (rs.getString("descr") != null){
		x_descr = rs.getString("descr");
	}
	else{
		x_descr = "";
	}

	// image
	if (rs.getString("image") != null){
		x_image = rs.getString("image");
	}
	else{
		x_image = "";
	}

	// costAP
	x_costAP = String.valueOf(rs.getLong("costAP"));

	// req_str
	x_req_str = String.valueOf(rs.getLong("req_str"));

	// req_int
	x_req_int = String.valueOf(rs.getLong("req_int"));

	// req_wis
	x_req_wis = String.valueOf(rs.getLong("req_wis"));

	// req_dex
	x_req_dex = String.valueOf(rs.getLong("req_dex"));

	// req_cha
	x_req_cha = String.valueOf(rs.getLong("req_cha"));

	// req_lev
	x_req_lev = String.valueOf(rs.getLong("req_lev"));

	// mod_str
	x_mod_str = String.valueOf(rs.getLong("mod_str"));

	// mod_int
	x_mod_int = String.valueOf(rs.getLong("mod_int"));

	// mod_wis
	x_mod_wis = String.valueOf(rs.getLong("mod_wis"));

	// mod_dex
	x_mod_dex = String.valueOf(rs.getLong("mod_dex"));

	// mod_cha
	x_mod_cha = String.valueOf(rs.getLong("mod_cha"));

	// price
	x_price = String.valueOf(rs.getDouble("price"));

	// lev
	x_lev = String.valueOf(rs.getLong("lev"));

	// spell
	x_spell = String.valueOf(rs.getLong("spell"));

	// damage
	if (rs.getString("damage") != null){
		x_damage = rs.getString("damage");
	}
	else{
		x_damage = "";
	}

	// initiative
	x_initiative = String.valueOf(rs.getLong("initiative"));

	// durability
	x_durability = String.valueOf(rs.getLong("durability"));

	// type
	x_type = String.valueOf(rs.getLong("type"));
%>
	<tr class="<%= rowclass %>">
	<% key =  arRecKey[recCount-1]; %>
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="<%= rowclass %>"><% out.print(x_id); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_name); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_descr); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_image); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_costAP); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_str); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_int); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_wis); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_dex); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_cha); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_lev); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_str); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_int); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_wis); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_dex); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_cha); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_price); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_lev); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_spell); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_damage); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_initiative); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_durability); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_type); %>&nbsp;</td>
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
