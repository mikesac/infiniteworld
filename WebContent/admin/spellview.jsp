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
if (key == null || key.length() == 0) { response.sendRedirect("spelllist.jsp");}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}
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

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")) {// Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Spell` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			out.clear();
			response.sendRedirect("spelllist.jsp");
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

		// desc
		if (rs.getString("desc") != null){
			x_desc = rs.getString("desc");
		}else{
			x_desc = "";
		}

		// image
		if (rs.getString("image") != null){
			x_image = rs.getString("image");
		}else{
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
		}else{
			x_damage = "";
		}

		// savingthrow
		x_savingthrow = String.valueOf(rs.getLong("savingthrow"));

		// initiative
		x_initiative = String.valueOf(rs.getLong("initiative"));
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">View TABLE: Spell<br><br><a href="spelllist.jsp">Back to List</a></span></p>
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
		<td class="ewTableHeader">desc&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_desc); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">image&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_image); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost Mp&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_costMp); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req str&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_req_str); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req int&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_req_int); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req dex&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_req_dex); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req cha&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_req_cha); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req lev&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_req_lev); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod str&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_mod_str); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod int&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_mod_int); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod dex&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_mod_dex); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod cha&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_mod_cha); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">price&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_price); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">lev&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_lev); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">duration&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_duration); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">spelltype&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_spelltype); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">damage&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_damage); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">savingthrow&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_savingthrow); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">initiative&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_initiative); %>&nbsp;</td>
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
