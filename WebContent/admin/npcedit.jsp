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
	response.sendRedirect("npclist.jsp");
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
Object x_image = null;
Object x_description = null;
Object x_base_str = null;
Object x_base_int = null;
Object x_base_dex = null;
Object x_base_cha = null;
Object x_base_pl = null;
Object x_base_pm = null;
Object x_base_pa = null;
Object x_base_pc = null;
Object x_level = null;
Object x_px = null;
Object x_status = null;
Object x_area = null;
Object x_gold = null;
Object x_xml_dialog = null;
Object x_xml_items = null;
Object x_xml_behave = null;
Object x_ismonster = null;
Object x_nattack = null;
Object x_attack = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `NPC` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("npclist.jsp");
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
			if (rs.getString("image") != null){
				x_image = rs.getString("image");
			}else{
				x_image = "";
			}
			if (rs.getClob("description") != null) {
				long length = rs.getClob("description").length();
				x_description = rs.getClob("description").getSubString((long) 1, (int) length);
			}else{
				x_description = "";
			}
	x_base_str = String.valueOf(rs.getLong("base_str"));
	x_base_int = String.valueOf(rs.getLong("base_int"));
	x_base_dex = String.valueOf(rs.getLong("base_dex"));
	x_base_cha = String.valueOf(rs.getLong("base_cha"));
	x_base_pl = String.valueOf(rs.getLong("base_pl"));
	x_base_pm = String.valueOf(rs.getLong("base_pm"));
	x_base_pa = String.valueOf(rs.getLong("base_pa"));
	x_base_pc = String.valueOf(rs.getLong("base_pc"));
	x_level = String.valueOf(rs.getLong("level"));
	x_px = String.valueOf(rs.getLong("px"));
	x_status = String.valueOf(rs.getLong("status"));
	x_area = String.valueOf(rs.getLong("area"));
	x_gold = String.valueOf(rs.getDouble("gold"));
			if (rs.getString("xml_dialog") != null){
				x_xml_dialog = rs.getString("xml_dialog");
			}else{
				x_xml_dialog = "";
			}
			if (rs.getString("xml_items") != null){
				x_xml_items = rs.getString("xml_items");
			}else{
				x_xml_items = "";
			}
			if (rs.getString("xml_behave") != null){
				x_xml_behave = rs.getString("xml_behave");
			}else{
				x_xml_behave = "";
			}
	x_ismonster = String.valueOf(rs.getLong("ismonster"));
	x_nattack = String.valueOf(rs.getLong("nattack"));
			if (rs.getString("attack") != null){
				x_attack = rs.getString("attack");
			}else{
				x_attack = "";
			}
		}
		rs.close();
	}else if (a.equals("U")) {// Update

		// Get fields from form
		if (request.getParameter("x_id") != null){
			x_id = (String) request.getParameter("x_id");
		}else{
			x_id = "";
		}
		if (request.getParameter("x_name") != null){
			x_name = (String) request.getParameter("x_name");
		}else{
			x_name = "";
		}
		if (request.getParameter("x_image") != null){
			x_image = (String) request.getParameter("x_image");
		}else{
			x_image = "";
		}
		if (request.getParameter("x_description") != null){
			x_description = (String) request.getParameter("x_description");
		}else{
			x_description = "";
		}
		if (request.getParameter("x_base_str") != null){
			x_base_str = (String) request.getParameter("x_base_str");
		}else{
			x_base_str = "";
		}
		if (request.getParameter("x_base_int") != null){
			x_base_int = (String) request.getParameter("x_base_int");
		}else{
			x_base_int = "";
		}
		if (request.getParameter("x_base_dex") != null){
			x_base_dex = (String) request.getParameter("x_base_dex");
		}else{
			x_base_dex = "";
		}
		if (request.getParameter("x_base_cha") != null){
			x_base_cha = (String) request.getParameter("x_base_cha");
		}else{
			x_base_cha = "";
		}
		if (request.getParameter("x_base_pl") != null){
			x_base_pl = (String) request.getParameter("x_base_pl");
		}else{
			x_base_pl = "";
		}
		if (request.getParameter("x_base_pm") != null){
			x_base_pm = (String) request.getParameter("x_base_pm");
		}else{
			x_base_pm = "";
		}
		if (request.getParameter("x_base_pa") != null){
			x_base_pa = (String) request.getParameter("x_base_pa");
		}else{
			x_base_pa = "";
		}
		if (request.getParameter("x_base_pc") != null){
			x_base_pc = (String) request.getParameter("x_base_pc");
		}else{
			x_base_pc = "";
		}
		if (request.getParameter("x_level") != null){
			x_level = (String) request.getParameter("x_level");
		}else{
			x_level = "";
		}
		if (request.getParameter("x_px") != null){
			x_px = (String) request.getParameter("x_px");
		}else{
			x_px = "";
		}
		if (request.getParameter("x_status") != null){
			x_status = (String) request.getParameter("x_status");
		}else{
			x_status = "";
		}
		if (request.getParameter("x_area") != null){
			x_area = (String) request.getParameter("x_area");
		}else{
			x_area = "";
		}
		if (request.getParameter("x_gold") != null){
			x_gold = (String) request.getParameter("x_gold");
		}else{
			x_gold = "";
		}
		if (request.getParameter("x_xml_dialog") != null){
			x_xml_dialog = (String) request.getParameter("x_xml_dialog");
		}else{
			x_xml_dialog = "";
		}
		if (request.getParameter("x_xml_items") != null){
			x_xml_items = (String) request.getParameter("x_xml_items");
		}else{
			x_xml_items = "";
		}
		if (request.getParameter("x_xml_behave") != null){
			x_xml_behave = (String) request.getParameter("x_xml_behave");
		}else{
			x_xml_behave = "";
		}
		if (request.getParameter("x_ismonster") != null){
			x_ismonster = (String) request.getParameter("x_ismonster");
		}else{
			x_ismonster = "";
		}
		if (request.getParameter("x_nattack") != null){
			x_nattack = (String) request.getParameter("x_nattack");
		}else{
			x_nattack = "";
		}
		if (request.getParameter("x_attack") != null){
			x_attack = (String) request.getParameter("x_attack");
		}else{
			x_attack = "";
		}

		// Open record
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `NPC` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("npclist.jsp");
			response.flushBuffer();
			return;
		}

		// Field id
		tmpfld = ((String) x_id).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("id");
		} else {
			rs.updateInt("id",Integer.parseInt(tmpfld));
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

		// Field description
		tmpfld = ((String) x_description);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("description");
		}else{
			rs.updateString("description", tmpfld);
		}

		// Field base_str
		tmpfld = ((String) x_base_str).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_str");
		} else {
			rs.updateInt("base_str",Integer.parseInt(tmpfld));
		}

		// Field base_int
		tmpfld = ((String) x_base_int).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_int");
		} else {
			rs.updateInt("base_int",Integer.parseInt(tmpfld));
		}

		// Field base_dex
		tmpfld = ((String) x_base_dex).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_dex");
		} else {
			rs.updateInt("base_dex",Integer.parseInt(tmpfld));
		}

		// Field base_cha
		tmpfld = ((String) x_base_cha).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_cha");
		} else {
			rs.updateInt("base_cha",Integer.parseInt(tmpfld));
		}

		// Field base_pl
		tmpfld = ((String) x_base_pl).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_pl");
		} else {
			rs.updateInt("base_pl",Integer.parseInt(tmpfld));
		}

		// Field base_pm
		tmpfld = ((String) x_base_pm).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_pm");
		} else {
			rs.updateInt("base_pm",Integer.parseInt(tmpfld));
		}

		// Field base_pa
		tmpfld = ((String) x_base_pa).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_pa");
		} else {
			rs.updateInt("base_pa",Integer.parseInt(tmpfld));
		}

		// Field base_pc
		tmpfld = ((String) x_base_pc).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("base_pc");
		} else {
			rs.updateInt("base_pc",Integer.parseInt(tmpfld));
		}

		// Field level
		tmpfld = ((String) x_level).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("level");
		} else {
			rs.updateInt("level",Integer.parseInt(tmpfld));
		}

		// Field px
		tmpfld = ((String) x_px).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("px");
		} else {
			rs.updateInt("px",Integer.parseInt(tmpfld));
		}

		// Field status
		tmpfld = ((String) x_status).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("status");
		} else {
			rs.updateInt("status",Integer.parseInt(tmpfld));
		}

		// Field area
		tmpfld = ((String) x_area).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("area");
		} else {
			rs.updateInt("area",Integer.parseInt(tmpfld));
		}

		// Field gold
		tmpfld = ((String) x_gold).trim();
		if (!IsNumeric(tmpfld)) {tmpfld = "0";}
		if (tmpfld != null) {
			rs.updateDouble("gold", Double.parseDouble(tmpfld));
		} else {
			rs.updateNull("gold");
		}

		// Field xml_dialog
		tmpfld = ((String) x_xml_dialog);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("xml_dialog");
		}else{
			rs.updateString("xml_dialog", tmpfld);
		}

		// Field xml_items
		tmpfld = ((String) x_xml_items);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("xml_items");
		}else{
			rs.updateString("xml_items", tmpfld);
		}

		// Field xml_behave
		tmpfld = ((String) x_xml_behave);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("xml_behave");
		}else{
			rs.updateString("xml_behave", tmpfld);
		}

		// Field ismonster
		tmpfld = ((String) x_ismonster).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("ismonster");
		} else {
			rs.updateInt("ismonster",Integer.parseInt(tmpfld));
		}

		// Field nattack
		tmpfld = ((String) x_nattack).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("nattack");
		} else {
			rs.updateInt("nattack",Integer.parseInt(tmpfld));
		}

		// Field attack
		tmpfld = ((String) x_attack);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("attack");
		}else{
			rs.updateString("attack", tmpfld);
		}
		rs.updateRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("npclist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
		out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Edit TABLE: NPC<br><br><a href="npclist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_id && !EW_hasValue(EW_this.x_id, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_id, "TEXT", "Incorrect integer - id"))
                return false; 
        }
if (EW_this.x_id && !EW_checkinteger(EW_this.x_id.value)) {
        if (!EW_onError(EW_this, EW_this.x_id, "TEXT", "Incorrect integer - id"))
            return false; 
        }
if (EW_this.x_name && !EW_hasValue(EW_this.x_name, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_name, "TEXT", "Invalid Field - name"))
                return false; 
        }
if (EW_this.x_image && !EW_hasValue(EW_this.x_image, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_image, "TEXT", "Invalid Field - image"))
                return false; 
        }
if (EW_this.x_description && !EW_hasValue(EW_this.x_description, "TEXTAREA" )) {
            if (!EW_onError(EW_this, EW_this.x_description, "TEXTAREA", "Invalid Field - description"))
                return false; 
        }
if (EW_this.x_base_str && !EW_hasValue(EW_this.x_base_str, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_str, "TEXT", "Incorrect integer - base str"))
                return false; 
        }
if (EW_this.x_base_str && !EW_checkinteger(EW_this.x_base_str.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_str, "TEXT", "Incorrect integer - base str"))
            return false; 
        }
if (EW_this.x_base_int && !EW_hasValue(EW_this.x_base_int, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_int, "TEXT", "Incorrect integer - base int"))
                return false; 
        }
if (EW_this.x_base_int && !EW_checkinteger(EW_this.x_base_int.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_int, "TEXT", "Incorrect integer - base int"))
            return false; 
        }
if (EW_this.x_base_dex && !EW_hasValue(EW_this.x_base_dex, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_dex, "TEXT", "Incorrect integer - base dex"))
                return false; 
        }
if (EW_this.x_base_dex && !EW_checkinteger(EW_this.x_base_dex.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_dex, "TEXT", "Incorrect integer - base dex"))
            return false; 
        }
if (EW_this.x_base_cha && !EW_hasValue(EW_this.x_base_cha, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_cha, "TEXT", "Incorrect integer - base cha"))
                return false; 
        }
if (EW_this.x_base_cha && !EW_checkinteger(EW_this.x_base_cha.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_cha, "TEXT", "Incorrect integer - base cha"))
            return false; 
        }
if (EW_this.x_base_pl && !EW_hasValue(EW_this.x_base_pl, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_pl, "TEXT", "Incorrect integer - base pl"))
                return false; 
        }
if (EW_this.x_base_pl && !EW_checkinteger(EW_this.x_base_pl.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_pl, "TEXT", "Incorrect integer - base pl"))
            return false; 
        }
if (EW_this.x_base_pm && !EW_hasValue(EW_this.x_base_pm, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_pm, "TEXT", "Incorrect integer - base pm"))
                return false; 
        }
if (EW_this.x_base_pm && !EW_checkinteger(EW_this.x_base_pm.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_pm, "TEXT", "Incorrect integer - base pm"))
            return false; 
        }
if (EW_this.x_base_pa && !EW_hasValue(EW_this.x_base_pa, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_pa, "TEXT", "Incorrect integer - base pa"))
                return false; 
        }
if (EW_this.x_base_pa && !EW_checkinteger(EW_this.x_base_pa.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_pa, "TEXT", "Incorrect integer - base pa"))
            return false; 
        }
if (EW_this.x_base_pc && !EW_hasValue(EW_this.x_base_pc, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_base_pc, "TEXT", "Incorrect integer - base pc"))
                return false; 
        }
if (EW_this.x_base_pc && !EW_checkinteger(EW_this.x_base_pc.value)) {
        if (!EW_onError(EW_this, EW_this.x_base_pc, "TEXT", "Incorrect integer - base pc"))
            return false; 
        }
if (EW_this.x_level && !EW_hasValue(EW_this.x_level, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_level, "TEXT", "Incorrect integer - level"))
                return false; 
        }
if (EW_this.x_level && !EW_checkinteger(EW_this.x_level.value)) {
        if (!EW_onError(EW_this, EW_this.x_level, "TEXT", "Incorrect integer - level"))
            return false; 
        }
if (EW_this.x_px && !EW_hasValue(EW_this.x_px, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_px, "TEXT", "Incorrect integer - px"))
                return false; 
        }
if (EW_this.x_px && !EW_checkinteger(EW_this.x_px.value)) {
        if (!EW_onError(EW_this, EW_this.x_px, "TEXT", "Incorrect integer - px"))
            return false; 
        }
if (EW_this.x_status && !EW_hasValue(EW_this.x_status, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_status, "TEXT", "Incorrect integer - status"))
                return false; 
        }
if (EW_this.x_status && !EW_checkinteger(EW_this.x_status.value)) {
        if (!EW_onError(EW_this, EW_this.x_status, "TEXT", "Incorrect integer - status"))
            return false; 
        }
if (EW_this.x_area && !EW_hasValue(EW_this.x_area, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_area, "TEXT", "Incorrect integer - area"))
                return false; 
        }
if (EW_this.x_area && !EW_checkinteger(EW_this.x_area.value)) {
        if (!EW_onError(EW_this, EW_this.x_area, "TEXT", "Incorrect integer - area"))
            return false; 
        }
if (EW_this.x_gold && !EW_hasValue(EW_this.x_gold, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_gold, "TEXT", "Incorrect floating point number - gold"))
                return false; 
        }
if (EW_this.x_gold && !EW_checknumber(EW_this.x_gold.value)) {
        if (!EW_onError(EW_this, EW_this.x_gold, "TEXT", "Incorrect floating point number - gold"))
            return false; 
        }
if (EW_this.x_xml_dialog && !EW_hasValue(EW_this.x_xml_dialog, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_xml_dialog, "TEXT", "Invalid Field - xml dialog"))
                return false; 
        }
if (EW_this.x_xml_items && !EW_hasValue(EW_this.x_xml_items, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_xml_items, "TEXT", "Invalid Field - xml items"))
                return false; 
        }
if (EW_this.x_xml_behave && !EW_hasValue(EW_this.x_xml_behave, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_xml_behave, "TEXT", "Invalid Field - xml behave"))
                return false; 
        }
if (EW_this.x_ismonster && !EW_hasValue(EW_this.x_ismonster, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_ismonster, "TEXT", "Incorrect integer - ismonster"))
                return false; 
        }
if (EW_this.x_ismonster && !EW_checkinteger(EW_this.x_ismonster.value)) {
        if (!EW_onError(EW_this, EW_this.x_ismonster, "TEXT", "Incorrect integer - ismonster"))
            return false; 
        }
if (EW_this.x_nattack && !EW_hasValue(EW_this.x_nattack, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_nattack, "TEXT", "Incorrect integer - nattack"))
                return false; 
        }
if (EW_this.x_nattack && !EW_checkinteger(EW_this.x_nattack.value)) {
        if (!EW_onError(EW_this, EW_this.x_nattack, "TEXT", "Incorrect integer - nattack"))
            return false; 
        }
if (EW_this.x_attack && !EW_hasValue(EW_this.x_attack, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_attack, "TEXT", "Invalid Field - attack"))
                return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  name="NPCedit" action="npcedit.jsp" method="post">
<p>
<input type="hidden" name="a" value="U">
<input type="hidden" name="key" value="<%= key %>">
<table class="ewTable">
	<tr>
		<td class="ewTableHeader">id&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_id" size="30" value="<%= HTMLEncode((String)x_id) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">name&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_name" size="30" maxlength="255" value="<%= HTMLEncode((String)x_name) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">image&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_image" size="30" maxlength="255" value="<%= HTMLEncode((String)x_image) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">description&nbsp;</td>
		<td class="ewTableAltRow"><textarea name="x_description" cols="35" rows="4"><% if (x_description!=null) out.print(x_description); %></textarea>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base str&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_str" size="30" value="<%= HTMLEncode((String)x_base_str) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base int&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_int" size="30" value="<%= HTMLEncode((String)x_base_int) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base dex&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_dex" size="30" value="<%= HTMLEncode((String)x_base_dex) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base cha&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_cha" size="30" value="<%= HTMLEncode((String)x_base_cha) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pl&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_pl" size="30" value="<%= HTMLEncode((String)x_base_pl) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pm&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_pm" size="30" value="<%= HTMLEncode((String)x_base_pm) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pa&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_pa" size="30" value="<%= HTMLEncode((String)x_base_pa) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">base pc&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_base_pc" size="30" value="<%= HTMLEncode((String)x_base_pc) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">level&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_level" size="30" value="<%= HTMLEncode((String)x_level) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">px&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_px" size="30" value="<%= HTMLEncode((String)x_px) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">status&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_status" size="30" value="<%= HTMLEncode((String)x_status) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">area&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_area" size="30" value="<%= HTMLEncode((String)x_area) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">gold&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_gold" size="30" value="<%= HTMLEncode((String)x_gold) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">xml dialog&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_xml_dialog" size="30" maxlength="255" value="<%= HTMLEncode((String)x_xml_dialog) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">xml items&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_xml_items" size="30" maxlength="255" value="<%= HTMLEncode((String)x_xml_items) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">xml behave&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_xml_behave" size="30" maxlength="255" value="<%= HTMLEncode((String)x_xml_behave) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ismonster&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_ismonster" size="30" value="<%= HTMLEncode((String)x_ismonster) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">nattack&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_nattack" size="30" value="<%= HTMLEncode((String)x_nattack) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">attack&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_attack" size="30" maxlength="255" value="<%= HTMLEncode((String)x_attack) %>">&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="EDIT">
</form>
<%@ include file="footer.jsp" %>
