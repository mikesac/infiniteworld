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
if (key == null || key.length() == 0) { response.sendRedirect("itemlist.jsp");}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}
String x_id = "";
String x_name = "";
String x_descr = "";
String x_image = "";
String x_costAP = "";
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
String x_spell = "";
String x_damage = "";
String x_initiative = "";
String x_durability = "";
String x_type = "";

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")) {// Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Item` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			out.clear();
			response.sendRedirect("itemlist.jsp");
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

		// descr
		if (rs.getString("descr") != null){
			x_descr = rs.getString("descr");
		}else{
			x_descr = "";
		}

		// image
		if (rs.getString("image") != null){
			x_image = rs.getString("image");
		}else{
			x_image = "";
		}

		// costAP
		x_costAP = String.valueOf(rs.getLong("costAP"));

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

		// spell
		x_spell = String.valueOf(rs.getLong("spell"));

		// damage
		if (rs.getString("damage") != null){
			x_damage = rs.getString("damage");
		}else{
			x_damage = "";
		}

		// initiative
		x_initiative = String.valueOf(rs.getLong("initiative"));

		// durability
		x_durability = String.valueOf(rs.getLong("durability"));

		// type
		x_type = String.valueOf(rs.getLong("type"));
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">View TABLE: Item<br><br><a href="itemlist.jsp">Back to List</a></span></p>
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
		<td class="ewTableHeader">descr&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_descr); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">image&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_image); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost AP&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_costAP); %>&nbsp;</td>
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
		<td class="ewTableHeader">spell&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_spell); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">damage&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_damage); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">initiative&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_initiative); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">durability&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_durability); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">type&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_type); %>&nbsp;</td>
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
