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
	response.sendRedirect("areaitemlist.jsp");
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
Object x_icon = null;
Object x_areaid = null;
Object x_ax = null;
Object x_ay = null;
Object x_x = null;
Object x_y = null;
Object x_lockid = null;
Object x_url = null;
Object x_direct = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `AreaItem` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
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
		}else{
			rs.first();

			// Get the field contents
	x_id = String.valueOf(rs.getLong("id"));
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
	x_areaid = String.valueOf(rs.getLong("areaid"));
	x_ax = String.valueOf(rs.getLong("ax"));
	x_ay = String.valueOf(rs.getLong("ay"));
	x_x = String.valueOf(rs.getLong("x"));
	x_y = String.valueOf(rs.getLong("y"));
	x_lockid = String.valueOf(rs.getLong("lockid"));
			if (rs.getString("url") != null){
				x_url = rs.getString("url");
			}else{
				x_url = "";
			}
	x_direct = String.valueOf(rs.getLong("direct"));
		}
		rs.close();
	}else if (a.equals("U")) {// Update

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
		if (request.getParameter("x_areaid") != null){
			x_areaid = (String) request.getParameter("x_areaid");
		}else{
			x_areaid = "";
		}
		if (request.getParameter("x_ax") != null){
			x_ax = (String) request.getParameter("x_ax");
		}else{
			x_ax = "";
		}
		if (request.getParameter("x_ay") != null){
			x_ay = (String) request.getParameter("x_ay");
		}else{
			x_ay = "";
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
		if (request.getParameter("x_lockid") != null){
			x_lockid = (String) request.getParameter("x_lockid");
		}else{
			x_lockid = "";
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

		// Open record
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `AreaItem` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
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

		// Field areaid
		tmpfld = ((String) x_areaid).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("areaid");
		} else {
			rs.updateInt("areaid",Integer.parseInt(tmpfld));
		}

		// Field ax
		tmpfld = ((String) x_ax).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("ax");
		} else {
			rs.updateInt("ax",Integer.parseInt(tmpfld));
		}

		// Field ay
		tmpfld = ((String) x_ay).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("ay");
		} else {
			rs.updateInt("ay",Integer.parseInt(tmpfld));
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

		// Field lockid
		tmpfld = ((String) x_lockid).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("lockid");
		} else {
			rs.updateInt("lockid",Integer.parseInt(tmpfld));
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
		rs.updateRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("areaitemlist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
		out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Edit TABLE: Area Item<br><br><a href="areaitemlist.jsp">Back to List</a></span></p>
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
if (EW_this.x_areaid && !EW_hasValue(EW_this.x_areaid, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_areaid, "TEXT", "Incorrect integer - areaid"))
                return false; 
        }
if (EW_this.x_areaid && !EW_checkinteger(EW_this.x_areaid.value)) {
        if (!EW_onError(EW_this, EW_this.x_areaid, "TEXT", "Incorrect integer - areaid"))
            return false; 
        }
if (EW_this.x_ax && !EW_hasValue(EW_this.x_ax, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_ax, "TEXT", "Incorrect integer - ax"))
                return false; 
        }
if (EW_this.x_ax && !EW_checkinteger(EW_this.x_ax.value)) {
        if (!EW_onError(EW_this, EW_this.x_ax, "TEXT", "Incorrect integer - ax"))
            return false; 
        }
if (EW_this.x_ay && !EW_hasValue(EW_this.x_ay, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_ay, "TEXT", "Incorrect integer - ay"))
                return false; 
        }
if (EW_this.x_ay && !EW_checkinteger(EW_this.x_ay.value)) {
        if (!EW_onError(EW_this, EW_this.x_ay, "TEXT", "Incorrect integer - ay"))
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
if (EW_this.x_lockid && !EW_hasValue(EW_this.x_lockid, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_lockid, "TEXT", "Incorrect integer - lockid"))
                return false; 
        }
if (EW_this.x_lockid && !EW_checkinteger(EW_this.x_lockid.value)) {
        if (!EW_onError(EW_this, EW_this.x_lockid, "TEXT", "Incorrect integer - lockid"))
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
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  name="AreaItemedit" action="areaitemedit.jsp" method="post">
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
		<td class="ewTableAltRow"><input type="text" name="x_name" size="30" maxlength="64" value="<%= HTMLEncode((String)x_name) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">icon&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_icon" size="30" maxlength="64" value="<%= HTMLEncode((String)x_icon) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">areaid&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_areaid" size="30" value="<%= HTMLEncode((String)x_areaid) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ax&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_ax" size="30" value="<%= HTMLEncode((String)x_ax) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ay&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_ay" size="30" value="<%= HTMLEncode((String)x_ay) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">x&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_x" size="30" value="<%= HTMLEncode((String)x_x) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">y&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_y" size="30" value="<%= HTMLEncode((String)x_y) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">lockid&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_lockid" size="30" value="<%= HTMLEncode((String)x_lockid) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">url&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_url" size="30" maxlength="255" value="<%= HTMLEncode((String)x_url) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">direct&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_direct" size="30" value="<%= HTMLEncode((String)x_direct) %>">&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="EDIT">
</form>
<%@ include file="footer.jsp" %>
