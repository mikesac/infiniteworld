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
	response.sendRedirect("spelllist.jsp");
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
Object x_desc = null;
Object x_image = null;
Object x_costMp = null;
Object x_req_str = null;
Object x_req_int = null;
Object x_req_wis = null;
Object x_req_dex = null;
Object x_req_cha = null;
Object x_req_lev = null;
Object x_mod_str = null;
Object x_mod_int = null;
Object x_mod_wis = null;
Object x_mod_dex = null;
Object x_mod_cha = null;
Object x_price = null;
Object x_lev = null;
Object x_duration = null;
Object x_spelltype = null;
Object x_damage = null;
Object x_savingthrow = null;
Object x_initiative = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Spell` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("spelllist.jsp");
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
			if (rs.getString("desc") != null){
				x_desc = rs.getString("desc");
			}else{
				x_desc = "";
			}
			if (rs.getString("image") != null){
				x_image = rs.getString("image");
			}else{
				x_image = "";
			}
	x_costMp = String.valueOf(rs.getLong("costMp"));
	x_req_str = String.valueOf(rs.getLong("req_str"));
	x_req_int = String.valueOf(rs.getLong("req_int"));
	x_req_wis = String.valueOf(rs.getLong("req_wis"));
	x_req_dex = String.valueOf(rs.getLong("req_dex"));
	x_req_cha = String.valueOf(rs.getLong("req_cha"));
	x_req_lev = String.valueOf(rs.getLong("req_lev"));
	x_mod_str = String.valueOf(rs.getLong("mod_str"));
	x_mod_int = String.valueOf(rs.getLong("mod_int"));
	x_mod_wis = String.valueOf(rs.getLong("mod_wis"));
	x_mod_dex = String.valueOf(rs.getLong("mod_dex"));
	x_mod_cha = String.valueOf(rs.getLong("mod_cha"));
	x_price = String.valueOf(rs.getDouble("price"));
	x_lev = String.valueOf(rs.getLong("lev"));
	x_duration = String.valueOf(rs.getLong("duration"));
	x_spelltype = String.valueOf(rs.getLong("spelltype"));
			if (rs.getString("damage") != null){
				x_damage = rs.getString("damage");
			}else{
				x_damage = "";
			}
	x_savingthrow = String.valueOf(rs.getLong("savingthrow"));
	x_initiative = String.valueOf(rs.getLong("initiative"));
		}
		rs.close();
	}else if (a.equals("U")) {// Update

		// Get fields from form
		if (request.getParameter("x_name") != null){
			x_name = (String) request.getParameter("x_name");
		}else{
			x_name = "";
		}
		if (request.getParameter("x_desc") != null){
			x_desc = (String) request.getParameter("x_desc");
		}else{
			x_desc = "";
		}
		if (request.getParameter("x_image") != null){
			x_image = (String) request.getParameter("x_image");
		}else{
			x_image = "";
		}
		if (request.getParameter("x_costMp") != null){
			x_costMp = (String) request.getParameter("x_costMp");
		}else{
			x_costMp = "";
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
		if (request.getParameter("x_req_wis") != null){
			x_req_wis = (String) request.getParameter("x_req_wis");
		}else{
			x_req_wis = "";
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
		if (request.getParameter("x_mod_wis") != null){
			x_mod_wis = (String) request.getParameter("x_mod_wis");
		}else{
			x_mod_wis = "";
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
		if (request.getParameter("x_duration") != null){
			x_duration = (String) request.getParameter("x_duration");
		}else{
			x_duration = "";
		}
		if (request.getParameter("x_spelltype") != null){
			x_spelltype = (String) request.getParameter("x_spelltype");
		}else{
			x_spelltype = "";
		}
		if (request.getParameter("x_damage") != null){
			x_damage = (String) request.getParameter("x_damage");
		}else{
			x_damage = "";
		}
		if (request.getParameter("x_savingthrow") != null){
			x_savingthrow = (String) request.getParameter("x_savingthrow");
		}else{
			x_savingthrow = "";
		}
		if (request.getParameter("x_initiative") != null){
			x_initiative = (String) request.getParameter("x_initiative");
		}else{
			x_initiative = "";
		}

		// Open record
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Spell` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("spelllist.jsp");
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

		// Field desc
		tmpfld = ((String) x_desc);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("desc");
		}else{
			rs.updateString("desc", tmpfld);
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

		// Field costMp
		tmpfld = ((String) x_costMp).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("costMp");
		} else {
			rs.updateInt("costMp",Integer.parseInt(tmpfld));
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

		// Field req_wis
		tmpfld = ((String) x_req_wis).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("req_wis");
		} else {
			rs.updateInt("req_wis",Integer.parseInt(tmpfld));
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

		// Field mod_wis
		tmpfld = ((String) x_mod_wis).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("mod_wis");
		} else {
			rs.updateInt("mod_wis",Integer.parseInt(tmpfld));
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

		// Field duration
		tmpfld = ((String) x_duration).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("duration");
		} else {
			rs.updateInt("duration",Integer.parseInt(tmpfld));
		}

		// Field spelltype
		tmpfld = ((String) x_spelltype).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("spelltype");
		} else {
			rs.updateInt("spelltype",Integer.parseInt(tmpfld));
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

		// Field savingthrow
		tmpfld = ((String) x_savingthrow).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("savingthrow");
		} else {
			rs.updateInt("savingthrow",Integer.parseInt(tmpfld));
		}

		// Field initiative
		tmpfld = ((String) x_initiative).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("initiative");
		} else {
			rs.updateInt("initiative",Integer.parseInt(tmpfld));
		}
		rs.updateRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("spelllist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
		out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Edit TABLE: Spell<br><br><a href="spelllist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_name && !EW_hasValue(EW_this.x_name, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_name, "TEXT", "Invalid Field - name"))
                return false; 
        }
if (EW_this.x_desc && !EW_hasValue(EW_this.x_desc, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_desc, "TEXT", "Invalid Field - desc"))
                return false; 
        }
if (EW_this.x_image && !EW_hasValue(EW_this.x_image, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_image, "TEXT", "Invalid Field - image"))
                return false; 
        }
if (EW_this.x_costMp && !EW_hasValue(EW_this.x_costMp, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_costMp, "TEXT", "Incorrect integer - cost Mp"))
                return false; 
        }
if (EW_this.x_costMp && !EW_checkinteger(EW_this.x_costMp.value)) {
        if (!EW_onError(EW_this, EW_this.x_costMp, "TEXT", "Incorrect integer - cost Mp"))
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
if (EW_this.x_req_wis && !EW_hasValue(EW_this.x_req_wis, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_req_wis, "TEXT", "Incorrect integer - req wis"))
                return false; 
        }
if (EW_this.x_req_wis && !EW_checkinteger(EW_this.x_req_wis.value)) {
        if (!EW_onError(EW_this, EW_this.x_req_wis, "TEXT", "Incorrect integer - req wis"))
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
if (EW_this.x_mod_wis && !EW_hasValue(EW_this.x_mod_wis, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_mod_wis, "TEXT", "Incorrect integer - mod wis"))
                return false; 
        }
if (EW_this.x_mod_wis && !EW_checkinteger(EW_this.x_mod_wis.value)) {
        if (!EW_onError(EW_this, EW_this.x_mod_wis, "TEXT", "Incorrect integer - mod wis"))
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
if (EW_this.x_duration && !EW_hasValue(EW_this.x_duration, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_duration, "TEXT", "Incorrect integer - duration"))
                return false; 
        }
if (EW_this.x_duration && !EW_checkinteger(EW_this.x_duration.value)) {
        if (!EW_onError(EW_this, EW_this.x_duration, "TEXT", "Incorrect integer - duration"))
            return false; 
        }
if (EW_this.x_spelltype && !EW_hasValue(EW_this.x_spelltype, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_spelltype, "TEXT", "Incorrect integer - spelltype"))
                return false; 
        }
if (EW_this.x_spelltype && !EW_checkinteger(EW_this.x_spelltype.value)) {
        if (!EW_onError(EW_this, EW_this.x_spelltype, "TEXT", "Incorrect integer - spelltype"))
            return false; 
        }
if (EW_this.x_damage && !EW_hasValue(EW_this.x_damage, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_damage, "TEXT", "Invalid Field - damage"))
                return false; 
        }
if (EW_this.x_savingthrow && !EW_hasValue(EW_this.x_savingthrow, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_savingthrow, "TEXT", "Incorrect integer - savingthrow"))
                return false; 
        }
if (EW_this.x_savingthrow && !EW_checkinteger(EW_this.x_savingthrow.value)) {
        if (!EW_onError(EW_this, EW_this.x_savingthrow, "TEXT", "Incorrect integer - savingthrow"))
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
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  name="Spelledit" action="spelledit.jsp" method="post">
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
		<td class="ewTableHeader">desc&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_desc" size="30" maxlength="255" value="<%= HTMLEncode((String)x_desc) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">image&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_image" size="30" maxlength="255" value="<%= HTMLEncode((String)x_image) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost Mp&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_costMp" size="30" value="<%= HTMLEncode((String)x_costMp) %>">&nbsp;</td>
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
		<td class="ewTableHeader">req wis&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_req_wis" size="30" value="<%= HTMLEncode((String)x_req_wis) %>">&nbsp;</td>
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
		<td class="ewTableHeader">mod wis&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_mod_wis" size="30" value="<%= HTMLEncode((String)x_mod_wis) %>">&nbsp;</td>
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
		<td class="ewTableHeader">duration&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_duration" size="30" value="<%= HTMLEncode((String)x_duration) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">spelltype&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_spelltype" size="30" value="<%= HTMLEncode((String)x_spelltype) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">damage&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_damage" size="30" maxlength="128" value="<%= HTMLEncode((String)x_damage) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">savingthrow&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_savingthrow" size="30" value="<%= HTMLEncode((String)x_savingthrow) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">initiative&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_initiative" size="30" value="<%= HTMLEncode((String)x_initiative) %>">&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="EDIT">
</form>
<%@ include file="footer.jsp" %>
