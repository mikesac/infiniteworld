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
	response.sendRedirect("spelllist.jsp");
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
		String strsql = "SELECT * FROM `Spell` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("spelllist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `Spell` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("spelllist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: Spell<br><br><a href="spelllist.jsp">Back to List</a></span></p>
<form action="spelldelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table class="ewTable">
	<tr class="ewTableHeader">
		<td>id&nbsp;</td>
		<td>name&nbsp;</td>
		<td>desc&nbsp;</td>
		<td>image&nbsp;</td>
		<td>cost Mp&nbsp;</td>
		<td>req str&nbsp;</td>
		<td>req int&nbsp;</td>
		<td>req dex&nbsp;</td>
		<td>req cha&nbsp;</td>
		<td>req lev&nbsp;</td>
		<td>mod str&nbsp;</td>
		<td>mod int&nbsp;</td>
		<td>mod dex&nbsp;</td>
		<td>mod cha&nbsp;</td>
		<td>price&nbsp;</td>
		<td>lev&nbsp;</td>
		<td>duration&nbsp;</td>
		<td>spelltype&nbsp;</td>
		<td>damage&nbsp;</td>
		<td>savingthrow&nbsp;</td>
		<td>initiative&nbsp;</td>
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
	String x_desc = "";
	String x_image = "";
	String x_costMp = "";
	String x_req_str = "";
	String x_req_int = "";
	String x_req_dex = "";
	String x_req_cha = "";
	String x_req_lev = "";
	String x_mod_str = "";
	String x_mod_int = "";
	String x_mod_dex = "";
	String x_mod_cha = "";
	String x_price = "";
	String x_lev = "";
	String x_duration = "";
	String x_spelltype = "";
	String x_damage = "";
	String x_savingthrow = "";
	String x_initiative = "";

	// id
	x_id = String.valueOf(rs.getLong("id"));

	// name
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}
	else{
		x_name = "";
	}

	// desc
	if (rs.getString("desc") != null){
		x_desc = rs.getString("desc");
	}
	else{
		x_desc = "";
	}

	// image
	if (rs.getString("image") != null){
		x_image = rs.getString("image");
	}
	else{
		x_image = "";
	}

	// costMp
	x_costMp = String.valueOf(rs.getLong("costMp"));

	// req_str
	x_req_str = String.valueOf(rs.getLong("req_str"));

	// req_int
	x_req_int = String.valueOf(rs.getLong("req_int"));

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

	// mod_dex
	x_mod_dex = String.valueOf(rs.getLong("mod_dex"));

	// mod_cha
	x_mod_cha = String.valueOf(rs.getLong("mod_cha"));

	// price
	x_price = String.valueOf(rs.getDouble("price"));

	// lev
	x_lev = String.valueOf(rs.getLong("lev"));

	// duration
	x_duration = String.valueOf(rs.getLong("duration"));

	// spelltype
	x_spelltype = String.valueOf(rs.getLong("spelltype"));

	// damage
	if (rs.getString("damage") != null){
		x_damage = rs.getString("damage");
	}
	else{
		x_damage = "";
	}

	// savingthrow
	x_savingthrow = String.valueOf(rs.getLong("savingthrow"));

	// initiative
	x_initiative = String.valueOf(rs.getLong("initiative"));
%>
	<tr class="<%= rowclass %>">
	<% key =  arRecKey[recCount-1]; %>
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="<%= rowclass %>"><% out.print(x_id); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_name); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_desc); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_image); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_costMp); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_str); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_int); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_dex); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_cha); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_req_lev); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_str); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_int); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_dex); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_mod_cha); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_price); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_lev); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_duration); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_spelltype); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_damage); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_savingthrow); %>&nbsp;</td>
		<td class="<%= rowclass %>"><% out.print(x_initiative); %>&nbsp;</td>
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
