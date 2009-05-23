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
if (key == null || key.length() == 0) { response.sendRedirect("npclist.jsp");}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}
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
String x_gold = "";
String x_nitem = "";
String x_useWpn = "";
String x_useShld = "";
String x_useArm = "";
String x_dialog = "";
String x_ismonster = "";
String x_nattack = "";
String x_attack = "";

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")) {// Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `NPC` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			out.clear();
			response.sendRedirect("npclist.jsp");
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

		// image
		if (rs.getString("image") != null){
			x_image = rs.getString("image");
		}else{
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

		// gold
		x_gold = String.valueOf(rs.getDouble("gold"));

		// nitem
		x_nitem = String.valueOf(rs.getLong("nitem"));

		// useWpn
		x_useWpn = String.valueOf(rs.getLong("useWpn"));

		// useShld
		x_useShld = String.valueOf(rs.getLong("useShld"));

		// useArm
		x_useArm = String.valueOf(rs.getLong("useArm"));

		// dialog
		if (rs.getString("dialog") != null){
			x_dialog = rs.getString("dialog");
		}else{
			x_dialog = "";
		}

		// ismonster
		x_ismonster = String.valueOf(rs.getLong("ismonster"));

		// nattack
		x_nattack = String.valueOf(rs.getLong("nattack"));

		// attack
		if (rs.getString("attack") != null){
			x_attack = rs.getString("attack");
		}else{
			x_attack = "";
		}
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">View TABLE: NPC<br><br><a href="npclist.jsp">Back to List</a></span></p>
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
		<td class="ewTableHeader">image&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_image); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">description&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_description != null) { out.print(((String)x_description).replaceAll("\r\n", "<br>"));} %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base str&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_str); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base int&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_int); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base dex&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_dex); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base cha&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_cha); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pl&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_pl); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pm&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_pm); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pa&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_pa); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pc&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_base_pc); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">level&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_level); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">px&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_px); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">status&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_status); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">gold&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_gold); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">nitem&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_nitem); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">use Wpn&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_useWpn); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">use Shld&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_useShld); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">use Arm&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_useArm); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">dialog&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_dialog); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ismonster&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_ismonster); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">nattack&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_nattack); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">attack&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_attack); %>&nbsp;</td>
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
