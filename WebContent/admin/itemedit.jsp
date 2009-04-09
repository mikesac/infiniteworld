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
request.setCharacterEncoding("UTF-8");
String key = request.getParameter("key");
if (key == null || key.length() == 0 ) {
	response.sendRedirect("itemlist.jsp");
	response.flushBuffer();
	return;
}

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}

// Get fields from form
Object x_id = null;
Object x_name = null;
Object x_descr = null;
Object x_image = null;
Object x_costAP = null;
Object x_req_str = null;
Object x_req_int = null;
Object x_req_dex = null;
Object x_req_cha = null;
Object x_req_lev = null;
Object x_mod_str = null;
Object x_mod_int = null;
Object x_mod_dex = null;
Object x_mod_cha = null;
Object x_price = null;
Object x_lev = null;
Object x_spell = null;
Object x_damage = null;
Object x_initiative = null;
Object x_durability = null;
Object x_type = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Item` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("itemlist.jsp");
			response.flushBuffer();
			return;
		}else{
			rs.first();

			// Get the field contents
	x_id = String.valueOf(rs.getLong("id"));
			if (rs.getString("name") != null){
				x_name = rs.getString("name");
			}else{
				x_name = "";
			}
			if (rs.getString("descr") != null){
				x_descr = rs.getString("descr");
			}else{
				x_descr = "";
			}
			if (rs.getString("image") != null){
				x_image = rs.getString("image");
			}else{
				x_image = "";
			}
	x_costAP = String.valueOf(rs.getLong("costAP"));
	x_req_str = String.valueOf(rs.getLong("req_str"));
	x_req_int = String.valueOf(rs.getLong("req_int"));
	x_req_dex = String.valueOf(rs.getLong("req_dex"));
	x_req_cha = String.valueOf(rs.getLong("req_cha"));
	x_req_lev = String.valueOf(rs.getLong("req_lev"));
	x_mod_str = String.valueOf(rs.getLong("mod_str"));
	x_mod_int = String.valueOf(rs.getLong("mod_int"));
	x_mod_dex = String.valueOf(rs.getLong("mod_dex"));
	x_mod_cha = String.valueOf(rs.getLong("mod_cha"));
	x_price = String.valueOf(rs.getDouble("price"));
	x_lev = String.valueOf(rs.getLong("lev"));
	x_spell = String.valueOf(rs.getLong("spell"));
			if (rs.getString("damage") != null){
				x_damage = rs.getString("damage");
			}else{
				x_damage = "";
			}
	x_initiative = String.valueOf(rs.getLong("initiative"));
	x_durability = String.valueOf(rs.getLong("durability"));
	x_type = String.valueOf(rs.getLong("type"));
		}
		rs.close();
	}else if (a.equals("U")) {// Update

		// Get fields from form
		if (request.getParameter("x_name") != null){
			x_name = (String) request.getParameter("x_name");
		}else{
			x_name = "";
		}
		if (request.getParameter("x_descr") != null){
			x_descr = (String) request.getParameter("x_descr");
		}else{
			x_descr = "";
		}
		if (request.getParameter("x_image") != null){
			x_image = (String) request.getParameter("x_image");
		}else{
			x_image = "";
		}
		if (request.getParameter("x_costAP") != null){
			x_costAP = (String) request.getParameter("x_costAP");
		}else{
			x_costAP = "";
		}
		if (request.getParameter("x_req_str") != null){
			x_req_str = (String) request.getParameter("x_req_str");
		}else{
			x_req_str = "";
		}
		if (request.getParameter("x_req_int") != null){
			x_req_int = (String) request.getParameter("x_req_int");
		}else{
			x_req_int = "";
		}
		if (request.getParameter("x_req_dex") != null){
			x_req_dex = (String) request.getParameter("x_req_dex");
		}else{
			x_req_dex = "";
		}
		if (request.getParameter("x_req_cha") != null){
			x_req_cha = (String) request.getParameter("x_req_cha");
		}else{
			x_req_cha = "";
		}
		if (request.getParameter("x_req_lev") != null){
			x_req_lev = (String) request.getParameter("x_req_lev");
		}else{
			x_req_lev = "";
		}
		if (request.getParameter("x_mod_str") != null){
			x_mod_str = (String) request.getParameter("x_mod_str");
		}else{
			x_mod_str = "";
		}
		if (request.getParameter("x_mod_int") != null){
			x_mod_int = (String) request.getParameter("x_mod_int");
		}else{
			x_mod_int = "";
		}
		if (request.getParameter("x_mod_dex") != null){
			x_mod_dex = (String) request.getParameter("x_mod_dex");
		}else{
			x_mod_dex = "";
		}
		if (request.getParameter("x_mod_cha") != null){
			x_mod_cha = (String) request.getParameter("x_mod_cha");
		}else{
			x_mod_cha = "";
		}
		if (request.getParameter("x_price") != null){
			x_price = (String) request.getParameter("x_price");
		}else{
			x_price = "";
		}
		if (request.getParameter("x_lev") != null){
			x_lev = (String) request.getParameter("x_lev");
		}else{
			x_lev = "";
		}
		if (request.getParameter("x_spell") != null){
			x_spell = (String) request.getParameter("x_spell");
		}else{
			x_spell = "";
		}
		if (request.getParameter("x_damage") != null){
			x_damage = (String) request.getParameter("x_damage");
		}else{
			x_damage = "";
		}
		if (request.getParameter("x_initiative") != null){
			x_initiative = (String) request.getParameter("x_initiative");
		}else{
			x_initiative = "";
		}
		if (request.getParameter("x_durability") != null){
			x_durability = (String) request.getParameter("x_durability");
		}else{
			x_durability = "";
		}
		if (request.getParameter("x_type") != null){
			x_type = (String) request.getParameter("x_type");
		}else{
			x_type = "";
		}

		// Open record
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Item` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("itemlist.jsp");
			response.flushBuffer();
			return;
		}

		// Field name
		tmpfld = ((String) x_name);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("name");
		}else{
			rs.updateString("name", tmpfld);
		}

		// Field descr
		tmpfld = ((String) x_descr);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("descr");
		}else{
			rs.updateString("descr", tmpfld);
		}

		// Field image
		tmpfld = ((String) x_image);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("image");
		}else{
			rs.updateString("image", tmpfld);
		}

		// Field costAP
		tmpfld = ((String) x_costAP).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("costAP");
		} else {
			rs.updateInt("costAP",Integer.parseInt(tmpfld));
		}

		// Field req_str
		tmpfld = ((String) x_req_str).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("req_str");
		} else {
			rs.updateInt("req_str",Integer.parseInt(tmpfld));
		}

		// Field req_int
		tmpfld = ((String) x_req_int).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("req_int");
		} else {
			rs.updateInt("req_int",Integer.parseInt(tmpfld));
		}

		// Field req_dex
		tmpfld = ((String) x_req_dex).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("req_dex");
		} else {
			rs.updateInt("req_dex",Integer.parseInt(tmpfld));
		}

		// Field req_cha
		tmpfld = ((String) x_req_cha).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("req_cha");
		} else {
			rs.updateInt("req_cha",Integer.parseInt(tmpfld));
		}

		// Field req_lev
		tmpfld = ((String) x_req_lev).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("req_lev");
		} else {
			rs.updateInt("req_lev",Integer.parseInt(tmpfld));
		}

		// Field mod_str
		tmpfld = ((String) x_mod_str).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("mod_str");
		} else {
			rs.updateInt("mod_str",Integer.parseInt(tmpfld));
		}

		// Field mod_int
		tmpfld = ((String) x_mod_int).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("mod_int");
		} else {
			rs.updateInt("mod_int",Integer.parseInt(tmpfld));
		}

		// Field mod_dex
		tmpfld = ((String) x_mod_dex).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("mod_dex");
		} else {
			rs.updateInt("mod_dex",Integer.parseInt(tmpfld));
		}

		// Field mod_cha
		tmpfld = ((String) x_mod_cha).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("mod_cha");
		} else {
			rs.updateInt("mod_cha",Integer.parseInt(tmpfld));
		}

		// Field price
		tmpfld = ((String) x_price).trim();
		if (!IsNumeric(tmpfld)) {tmpfld = "0";}
		if (tmpfld != null) {
			rs.updateDouble("price", Double.parseDouble(tmpfld));
		} else {
			rs.updateNull("price");
		}

		// Field lev
		tmpfld = ((String) x_lev).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("lev");
		} else {
			rs.updateInt("lev",Integer.parseInt(tmpfld));
		}

		// Field spell
		tmpfld = ((String) x_spell).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("spell");
		} else {
			rs.updateInt("spell",Integer.parseInt(tmpfld));
		}

		// Field damage
		tmpfld = ((String) x_damage);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("damage");
		}else{
			rs.updateString("damage", tmpfld);
		}

		// Field initiative
		tmpfld = ((String) x_initiative).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("initiative");
		} else {
			rs.updateInt("initiative",Integer.parseInt(tmpfld));
		}

		// Field durability
		tmpfld = ((String) x_durability).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("durability");
		} else {
			rs.updateInt("durability",Integer.parseInt(tmpfld));
		}

		// Field type
		tmpfld = ((String) x_type).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("type");
		} else {
			rs.updateInt("type",Integer.parseInt(tmpfld));
		}
		rs.updateRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("itemlist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
		out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Edit TABLE: Item<br><br><a href="itemlist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_name && !EW_hasValue(EW_this.x_name, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_name, "TEXT", "Invalid Field - name"))
                return false; 
        }
if (EW_this.x_descr && !EW_hasValue(EW_this.x_descr, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_descr, "TEXT", "Invalid Field - descr"))
                return false; 
        }
if (EW_this.x_image && !EW_hasValue(EW_this.x_image, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_image, "TEXT", "Invalid Field - image"))
                return false; 
        }
if (EW_this.x_costAP && !EW_hasValue(EW_this.x_costAP, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_costAP, "TEXT", "Incorrect integer - cost AP"))
                return false; 
        }
if (EW_this.x_costAP && !EW_checkinteger(EW_this.x_costAP.value)) {
        if (!EW_onError(EW_this, EW_this.x_costAP, "TEXT", "Incorrect integer - cost AP"))
            return false; 
        }
if (EW_this.x_req_str && !EW_hasValue(EW_this.x_req_str, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_req_str, "TEXT", "Incorrect integer - req str"))
                return false; 
        }
if (EW_this.x_req_str && !EW_checkinteger(EW_this.x_req_str.value)) {
        if (!EW_onError(EW_this, EW_this.x_req_str, "TEXT", "Incorrect integer - req str"))
            return false; 
        }
if (EW_this.x_req_int && !EW_hasValue(EW_this.x_req_int, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_req_int, "TEXT", "Incorrect integer - req int"))
                return false; 
        }
if (EW_this.x_req_int && !EW_checkinteger(EW_this.x_req_int.value)) {
        if (!EW_onError(EW_this, EW_this.x_req_int, "TEXT", "Incorrect integer - req int"))
            return false; 
        }
if (EW_this.x_req_dex && !EW_hasValue(EW_this.x_req_dex, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_req_dex, "TEXT", "Incorrect integer - req dex"))
                return false; 
        }
if (EW_this.x_req_dex && !EW_checkinteger(EW_this.x_req_dex.value)) {
        if (!EW_onError(EW_this, EW_this.x_req_dex, "TEXT", "Incorrect integer - req dex"))
            return false; 
        }
if (EW_this.x_req_cha && !EW_hasValue(EW_this.x_req_cha, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_req_cha, "TEXT", "Incorrect integer - req cha"))
                return false; 
        }
if (EW_this.x_req_cha && !EW_checkinteger(EW_this.x_req_cha.value)) {
        if (!EW_onError(EW_this, EW_this.x_req_cha, "TEXT", "Incorrect integer - req cha"))
            return false; 
        }
if (EW_this.x_req_lev && !EW_hasValue(EW_this.x_req_lev, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_req_lev, "TEXT", "Incorrect integer - req lev"))
                return false; 
        }
if (EW_this.x_req_lev && !EW_checkinteger(EW_this.x_req_lev.value)) {
        if (!EW_onError(EW_this, EW_this.x_req_lev, "TEXT", "Incorrect integer - req lev"))
            return false; 
        }
if (EW_this.x_mod_str && !EW_hasValue(EW_this.x_mod_str, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_mod_str, "TEXT", "Incorrect integer - mod str"))
                return false; 
        }
if (EW_this.x_mod_str && !EW_checkinteger(EW_this.x_mod_str.value)) {
        if (!EW_onError(EW_this, EW_this.x_mod_str, "TEXT", "Incorrect integer - mod str"))
            return false; 
        }
if (EW_this.x_mod_int && !EW_hasValue(EW_this.x_mod_int, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_mod_int, "TEXT", "Incorrect integer - mod int"))
                return false; 
        }
if (EW_this.x_mod_int && !EW_checkinteger(EW_this.x_mod_int.value)) {
        if (!EW_onError(EW_this, EW_this.x_mod_int, "TEXT", "Incorrect integer - mod int"))
            return false; 
        }
if (EW_this.x_mod_dex && !EW_hasValue(EW_this.x_mod_dex, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_mod_dex, "TEXT", "Incorrect integer - mod dex"))
                return false; 
        }
if (EW_this.x_mod_dex && !EW_checkinteger(EW_this.x_mod_dex.value)) {
        if (!EW_onError(EW_this, EW_this.x_mod_dex, "TEXT", "Incorrect integer - mod dex"))
            return false; 
        }
if (EW_this.x_mod_cha && !EW_hasValue(EW_this.x_mod_cha, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_mod_cha, "TEXT", "Incorrect integer - mod cha"))
                return false; 
        }
if (EW_this.x_mod_cha && !EW_checkinteger(EW_this.x_mod_cha.value)) {
        if (!EW_onError(EW_this, EW_this.x_mod_cha, "TEXT", "Incorrect integer - mod cha"))
            return false; 
        }
if (EW_this.x_price && !EW_hasValue(EW_this.x_price, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_price, "TEXT", "Incorrect floating point number - price"))
                return false; 
        }
if (EW_this.x_price && !EW_checknumber(EW_this.x_price.value)) {
        if (!EW_onError(EW_this, EW_this.x_price, "TEXT", "Incorrect floating point number - price"))
            return false; 
        }
if (EW_this.x_lev && !EW_hasValue(EW_this.x_lev, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_lev, "TEXT", "Incorrect integer - lev"))
                return false; 
        }
if (EW_this.x_lev && !EW_checkinteger(EW_this.x_lev.value)) {
        if (!EW_onError(EW_this, EW_this.x_lev, "TEXT", "Incorrect integer - lev"))
            return false; 
        }
if (EW_this.x_spell && !EW_hasValue(EW_this.x_spell, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_spell, "TEXT", "Incorrect integer - spell"))
                return false; 
        }
if (EW_this.x_spell && !EW_checkinteger(EW_this.x_spell.value)) {
        if (!EW_onError(EW_this, EW_this.x_spell, "TEXT", "Incorrect integer - spell"))
            return false; 
        }
if (EW_this.x_damage && !EW_hasValue(EW_this.x_damage, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_damage, "TEXT", "Invalid Field - damage"))
                return false; 
        }
if (EW_this.x_initiative && !EW_hasValue(EW_this.x_initiative, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_initiative, "TEXT", "Incorrect integer - initiative"))
                return false; 
        }
if (EW_this.x_initiative && !EW_checkinteger(EW_this.x_initiative.value)) {
        if (!EW_onError(EW_this, EW_this.x_initiative, "TEXT", "Incorrect integer - initiative"))
            return false; 
        }
if (EW_this.x_durability && !EW_hasValue(EW_this.x_durability, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_durability, "TEXT", "Incorrect integer - durability"))
                return false; 
        }
if (EW_this.x_durability && !EW_checkinteger(EW_this.x_durability.value)) {
        if (!EW_onError(EW_this, EW_this.x_durability, "TEXT", "Incorrect integer - durability"))
            return false; 
        }
if (EW_this.x_type && !EW_hasValue(EW_this.x_type, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_type, "TEXT", "Incorrect integer - type"))
                return false; 
        }
if (EW_this.x_type && !EW_checkinteger(EW_this.x_type.value)) {
        if (!EW_onError(EW_this, EW_this.x_type, "TEXT", "Incorrect integer - type"))
            return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  name="Itemedit" action="itemedit.jsp" method="post">
<p>
<input type="hidden" name="a" value="U">
<input type="hidden" name="key" value="<%= key %>">
<table class="ewTable">
	<tr>
		<td class="ewTableHeader">id&nbsp;</td>
		<td class="ewTableAltRow"><% out.print(x_id); %>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">name&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_name" size="30" maxlength="255" value="<%= HTMLEncode((String)x_name) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">descr&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_descr" size="30" maxlength="255" value="<%= HTMLEncode((String)x_descr) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">image&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_image" size="30" maxlength="255" value="<%= HTMLEncode((String)x_image) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost AP&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_costAP" size="30" value="<%= HTMLEncode((String)x_costAP) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req str&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_req_str" size="30" value="<%= HTMLEncode((String)x_req_str) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req int&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_req_int" size="30" value="<%= HTMLEncode((String)x_req_int) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req dex&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_req_dex" size="30" value="<%= HTMLEncode((String)x_req_dex) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req cha&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_req_cha" size="30" value="<%= HTMLEncode((String)x_req_cha) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">req lev&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_req_lev" size="30" value="<%= HTMLEncode((String)x_req_lev) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod str&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_mod_str" size="30" value="<%= HTMLEncode((String)x_mod_str) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod int&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_mod_int" size="30" value="<%= HTMLEncode((String)x_mod_int) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod dex&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_mod_dex" size="30" value="<%= HTMLEncode((String)x_mod_dex) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">mod cha&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_mod_cha" size="30" value="<%= HTMLEncode((String)x_mod_cha) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">price&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_price" size="30" value="<%= HTMLEncode((String)x_price) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">lev&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_lev" size="30" value="<%= HTMLEncode((String)x_lev) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">spell&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_spell" size="30" value="<%= HTMLEncode((String)x_spell) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">damage&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_damage" size="30" maxlength="128" value="<%= HTMLEncode((String)x_damage) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">initiative&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_initiative" size="30" value="<%= HTMLEncode((String)x_initiative) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">durability&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_durability" size="30" value="<%= HTMLEncode((String)x_durability) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">type&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_type" size="30" value="<%= HTMLEncode((String)x_type) %>">&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="EDIT">
</form>
<%@ include file="footer.jsp" %>
