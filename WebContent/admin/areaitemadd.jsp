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

// Get action
String a = request.getParameter("a");
String key = "";
if (a == null || a.length() == 0) {
	key = request.getParameter("key");
	if (key != null && key.length() > 0) {
		a = "C"; // Copy record
	} else {
		a = "I"; // Display blank record
	}
}
Object x_id = null;
Object x_name = null;
Object x_icon = null;
Object x_cost = null;
Object x_areaid = null;
Object x_areax = null;
Object x_areay = null;
Object x_x = null;
Object x_y = null;
Object x_arealock = null;
Object x_questlock = null;
Object x_url = null;
Object x_direct = null;
Object x_loop = null;
Object x_hidemode = null;
Object x_areaItemLevel = null;
Object x_npcs = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("C")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `AreaItem` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()){
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("areaitemlist.jsp");
			response.flushBuffer();
			return;
		}
		rs.first();

			// Get the field contents
	if (rs.getString("name") != null){
		x_name = rs.getString("name");
	}else{
		x_name = "";
	}
	if (rs.getString("icon") != null){
		x_icon = rs.getString("icon");
	}else{
		x_icon = "";
	}
	x_cost = String.valueOf(rs.getLong("cost"));
	x_areaid = String.valueOf(rs.getLong("areaid"));
	x_areax = String.valueOf(rs.getLong("areax"));
	x_areay = String.valueOf(rs.getLong("areay"));
	x_x = String.valueOf(rs.getLong("x"));
	x_y = String.valueOf(rs.getLong("y"));
	if (rs.getString("arealock") != null){
		x_arealock = rs.getString("arealock");
	}else{
		x_arealock = "";
	}
	if (rs.getString("questlock") != null){
		x_questlock = rs.getString("questlock");
	}else{
		x_questlock = "";
	}
	if (rs.getString("url") != null){
		x_url = rs.getString("url");
	}else{
		x_url = "";
	}
	x_direct = String.valueOf(rs.getLong("direct"));
	x_loop = String.valueOf(rs.getLong("loop"));
	x_hidemode = String.valueOf(rs.getLong("hidemode"));
	x_areaItemLevel = String.valueOf(rs.getLong("areaItemLevel"));
	if (rs.getString("npcs") != null){
		x_npcs = rs.getString("npcs");
	}else{
		x_npcs = "";
	}
		rs.close();
		rs = null;
	}else if (a.equals("A")) { // Add

		// Get fields from form
		if (request.getParameter("x_name") != null){
			x_name = (String) request.getParameter("x_name");
		}else{
			x_name = "";
		}
		if (request.getParameter("x_icon") != null){
			x_icon = (String) request.getParameter("x_icon");
		}else{
			x_icon = "";
		}
		if (request.getParameter("x_cost") != null){
			x_cost = (String) request.getParameter("x_cost");
		}else{
			x_cost = "";
		}
		if (request.getParameter("x_areaid") != null){
			x_areaid = (String) request.getParameter("x_areaid");
		}else{
			x_areaid = "";
		}
		if (request.getParameter("x_areax") != null){
			x_areax = (String) request.getParameter("x_areax");
		}else{
			x_areax = "";
		}
		if (request.getParameter("x_areay") != null){
			x_areay = (String) request.getParameter("x_areay");
		}else{
			x_areay = "";
		}
		if (request.getParameter("x_x") != null){
			x_x = (String) request.getParameter("x_x");
		}else{
			x_x = "";
		}
		if (request.getParameter("x_y") != null){
			x_y = (String) request.getParameter("x_y");
		}else{
			x_y = "";
		}
		if (request.getParameter("x_arealock") != null){
			x_arealock = (String) request.getParameter("x_arealock");
		}else{
			x_arealock = "";
		}
		if (request.getParameter("x_questlock") != null){
			x_questlock = (String) request.getParameter("x_questlock");
		}else{
			x_questlock = "";
		}
		if (request.getParameter("x_url") != null){
			x_url = (String) request.getParameter("x_url");
		}else{
			x_url = "";
		}
		if (request.getParameter("x_direct") != null){
			x_direct = (String) request.getParameter("x_direct");
		}else{
			x_direct = "";
		}
		if (request.getParameter("x_loop") != null){
			x_loop = (String) request.getParameter("x_loop");
		}else{
			x_loop = "";
		}
		if (request.getParameter("x_hidemode") != null){
			x_hidemode = (String) request.getParameter("x_hidemode");
		}else{
			x_hidemode = "";
		}
		if (request.getParameter("x_areaItemLevel") != null){
			x_areaItemLevel = (String) request.getParameter("x_areaItemLevel");
		}else{
			x_areaItemLevel = "";
		}
		if (request.getParameter("x_npcs") != null){
			x_npcs = (String) request.getParameter("x_npcs");
		}else{
			x_npcs = "";
		}

		// Open record
		String strsql = "SELECT * FROM `AreaItem` WHERE 0 = 1";
		rs = stmt.executeQuery(strsql);
		rs.moveToInsertRow();

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

		// Field icon
		tmpfld = ((String) x_icon);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("icon");
		}else{
			rs.updateString("icon", tmpfld);
		}

		// Field cost
		tmpfld = ((String) x_cost).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("cost");
		} else {
			rs.updateInt("cost",Integer.parseInt(tmpfld));
		}

		// Field areaid
		tmpfld = ((String) x_areaid).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("areaid");
		} else {
			rs.updateInt("areaid",Integer.parseInt(tmpfld));
		}

		// Field areax
		tmpfld = ((String) x_areax).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("areax");
		} else {
			rs.updateInt("areax",Integer.parseInt(tmpfld));
		}

		// Field areay
		tmpfld = ((String) x_areay).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("areay");
		} else {
			rs.updateInt("areay",Integer.parseInt(tmpfld));
		}

		// Field x
		tmpfld = ((String) x_x).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("x");
		} else {
			rs.updateInt("x",Integer.parseInt(tmpfld));
		}

		// Field y
		tmpfld = ((String) x_y).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("y");
		} else {
			rs.updateInt("y",Integer.parseInt(tmpfld));
		}

		// Field arealock
		tmpfld = ((String) x_arealock);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("arealock");
		}else{
			rs.updateString("arealock", tmpfld);
		}

		// Field questlock
		tmpfld = ((String) x_questlock);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("questlock");
		}else{
			rs.updateString("questlock", tmpfld);
		}

		// Field url
		tmpfld = ((String) x_url);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("url");
		}else{
			rs.updateString("url", tmpfld);
		}

		// Field direct
		tmpfld = ((String) x_direct).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("direct");
		} else {
			rs.updateInt("direct",Integer.parseInt(tmpfld));
		}

		// Field loop
		tmpfld = ((String) x_loop).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("loop");
		} else {
			rs.updateInt("loop",Integer.parseInt(tmpfld));
		}

		// Field hidemode
		tmpfld = ((String) x_hidemode).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("hidemode");
		} else {
			rs.updateInt("hidemode",Integer.parseInt(tmpfld));
		}

		// Field areaItemLevel
		tmpfld = ((String) x_areaItemLevel).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("areaItemLevel");
		} else {
			rs.updateInt("areaItemLevel",Integer.parseInt(tmpfld));
		}

		// Field npcs
		tmpfld = ((String) x_npcs);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("npcs");
		}else{
			rs.updateString("npcs", tmpfld);
		}
		rs.insertRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		out.clear();
		response.sendRedirect("areaitemlist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Add to TABLE: Area Item<br><br><a href="areaitemlist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_name && !EW_hasValue(EW_this.x_name, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_name, "TEXT", "Invalid Field - name"))
                return false; 
        }
if (EW_this.x_icon && !EW_hasValue(EW_this.x_icon, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_icon, "TEXT", "Invalid Field - icon"))
                return false; 
        }
if (EW_this.x_cost && !EW_hasValue(EW_this.x_cost, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_cost, "TEXT", "Incorrect integer - cost"))
                return false; 
        }
if (EW_this.x_cost && !EW_checkinteger(EW_this.x_cost.value)) {
        if (!EW_onError(EW_this, EW_this.x_cost, "TEXT", "Incorrect integer - cost"))
            return false; 
        }
if (EW_this.x_areaid && !EW_hasValue(EW_this.x_areaid, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_areaid, "TEXT", "Incorrect integer - areaid"))
                return false; 
        }
if (EW_this.x_areaid && !EW_checkinteger(EW_this.x_areaid.value)) {
        if (!EW_onError(EW_this, EW_this.x_areaid, "TEXT", "Incorrect integer - areaid"))
            return false; 
        }
if (EW_this.x_areax && !EW_hasValue(EW_this.x_areax, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_areax, "TEXT", "Incorrect integer - areax"))
                return false; 
        }
if (EW_this.x_areax && !EW_checkinteger(EW_this.x_areax.value)) {
        if (!EW_onError(EW_this, EW_this.x_areax, "TEXT", "Incorrect integer - areax"))
            return false; 
        }
if (EW_this.x_areay && !EW_hasValue(EW_this.x_areay, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_areay, "TEXT", "Incorrect integer - areay"))
                return false; 
        }
if (EW_this.x_areay && !EW_checkinteger(EW_this.x_areay.value)) {
        if (!EW_onError(EW_this, EW_this.x_areay, "TEXT", "Incorrect integer - areay"))
            return false; 
        }
if (EW_this.x_x && !EW_hasValue(EW_this.x_x, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_x, "TEXT", "Incorrect integer - x"))
                return false; 
        }
if (EW_this.x_x && !EW_checkinteger(EW_this.x_x.value)) {
        if (!EW_onError(EW_this, EW_this.x_x, "TEXT", "Incorrect integer - x"))
            return false; 
        }
if (EW_this.x_y && !EW_hasValue(EW_this.x_y, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_y, "TEXT", "Incorrect integer - y"))
                return false; 
        }
if (EW_this.x_y && !EW_checkinteger(EW_this.x_y.value)) {
        if (!EW_onError(EW_this, EW_this.x_y, "TEXT", "Incorrect integer - y"))
            return false; 
        }
if (EW_this.x_arealock && !EW_hasValue(EW_this.x_arealock, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_arealock, "TEXT", "Invalid Field - arealock"))
                return false; 
        }
if (EW_this.x_questlock && !EW_hasValue(EW_this.x_questlock, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_questlock, "TEXT", "Invalid Field - questlock"))
                return false; 
        }
if (EW_this.x_url && !EW_hasValue(EW_this.x_url, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_url, "TEXT", "Invalid Field - url"))
                return false; 
        }
if (EW_this.x_direct && !EW_hasValue(EW_this.x_direct, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_direct, "TEXT", "Incorrect integer - direct"))
                return false; 
        }
if (EW_this.x_direct && !EW_checkinteger(EW_this.x_direct.value)) {
        if (!EW_onError(EW_this, EW_this.x_direct, "TEXT", "Incorrect integer - direct"))
            return false; 
        }
if (EW_this.x_loop && !EW_hasValue(EW_this.x_loop, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_loop, "TEXT", "Incorrect integer - loop"))
                return false; 
        }
if (EW_this.x_loop && !EW_checkinteger(EW_this.x_loop.value)) {
        if (!EW_onError(EW_this, EW_this.x_loop, "TEXT", "Incorrect integer - loop"))
            return false; 
        }
if (EW_this.x_hidemode && !EW_hasValue(EW_this.x_hidemode, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_hidemode, "TEXT", "Incorrect integer - hidemode"))
                return false; 
        }
if (EW_this.x_hidemode && !EW_checkinteger(EW_this.x_hidemode.value)) {
        if (!EW_onError(EW_this, EW_this.x_hidemode, "TEXT", "Incorrect integer - hidemode"))
            return false; 
        }
if (EW_this.x_areaItemLevel && !EW_hasValue(EW_this.x_areaItemLevel, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_areaItemLevel, "TEXT", "Incorrect integer - area Item Level"))
                return false; 
        }
if (EW_this.x_areaItemLevel && !EW_checkinteger(EW_this.x_areaItemLevel.value)) {
        if (!EW_onError(EW_this, EW_this.x_areaItemLevel, "TEXT", "Incorrect integer - area Item Level"))
            return false; 
        }
if (EW_this.x_npcs && !EW_hasValue(EW_this.x_npcs, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_npcs, "TEXT", "Invalid Field - npcs"))
                return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  action="areaitemadd.jsp" method="post">
<p>
<input type="hidden" name="a" value="A">
<table class="ewTable">
	<tr>
		<td class="ewTableHeader">name&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_name== null || ((String)x_name).equals("")) {x_name = "testAreaItem"; } // set default value %><input type="text" name="x_name" size="30" maxlength="64" value="<%= HTMLEncode((String)x_name) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">icon&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_icon== null || ((String)x_icon).equals("")) {x_icon = "area"; } // set default value %><input type="text" name="x_icon" size="30" maxlength="64" value="<%= HTMLEncode((String)x_icon) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_cost== null || ((String)x_cost).equals("")) {x_cost = "1"; } // set default value %><input type="text" name="x_cost" size="30" value="<%= HTMLEncode((String)x_cost) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areaid&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_areaid== null || ((String)x_areaid).equals("")) {x_areaid = "1"; } // set default value %><input type="text" name="x_areaid" size="30" value="<%= HTMLEncode((String)x_areaid) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areax&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_areax== null || ((String)x_areax).equals("")) {x_areax = "0"; } // set default value %><input type="text" name="x_areax" size="30" value="<%= HTMLEncode((String)x_areax) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areay&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_areay== null || ((String)x_areay).equals("")) {x_areay = "0"; } // set default value %><input type="text" name="x_areay" size="30" value="<%= HTMLEncode((String)x_areay) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">x&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_x== null || ((String)x_x).equals("")) {x_x = "0"; } // set default value %><input type="text" name="x_x" size="30" value="<%= HTMLEncode((String)x_x) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">y&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_y== null || ((String)x_y).equals("")) {x_y = "0"; } // set default value %><input type="text" name="x_y" size="30" value="<%= HTMLEncode((String)x_y) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">arealock&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_arealock" size="30" maxlength="64" value="<%= HTMLEncode((String)x_arealock) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">questlock&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_questlock" size="30" maxlength="64" value="<%= HTMLEncode((String)x_questlock) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">url&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_url" size="30" maxlength="255" value="<%= HTMLEncode((String)x_url) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">direct&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_direct== null || ((String)x_direct).equals("")) {x_direct = "0"; } // set default value %><input type="text" name="x_direct" size="30" value="<%= HTMLEncode((String)x_direct) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">loop&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_loop== null || ((String)x_loop).equals("")) {x_loop = "0"; } // set default value %><input type="text" name="x_loop" size="30" value="<%= HTMLEncode((String)x_loop) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">hidemode&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_hidemode" size="30" value="<%= HTMLEncode((String)x_hidemode) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">area Item Level&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_areaItemLevel== null || ((String)x_areaItemLevel).equals("")) {x_areaItemLevel = "1"; } // set default value %><input type="text" name="x_areaItemLevel" size="30" value="<%= HTMLEncode((String)x_areaItemLevel) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">npcs&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_npcs" size="30" maxlength="64" value="<%= HTMLEncode((String)x_npcs) %>">&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="ADD">
</form>
<%@ include file="footer.jsp" %>
