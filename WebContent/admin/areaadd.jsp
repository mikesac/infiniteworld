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
Object x_description = null;
Object x_world = null;
Object x_nx = null;
Object x_ny = null;
Object x_lockid = null;
Object x_cost = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("C")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `Area` WHERE `id`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()){
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("arealist.jsp");
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
	if (rs.getClob("description") != null) {
		long length = rs.getClob("description").length();
		x_description = rs.getClob("description").getSubString((long) 1, (int) length);
	}else{
		x_description = "";
	}
	x_world = String.valueOf(rs.getLong("world"));
	x_nx = String.valueOf(rs.getLong("nx"));
	x_ny = String.valueOf(rs.getLong("ny"));
	x_lockid = String.valueOf(rs.getLong("lockid"));
	x_cost = String.valueOf(rs.getLong("cost"));
		rs.close();
		rs = null;
	}else if (a.equals("A")) { // Add

		// Get fields from form
		if (request.getParameter("x_name") != null){
			x_name = (String) request.getParameter("x_name");
		}else{
			x_name = "";
		}
		if (request.getParameter("x_description") != null){
			x_description = (String) request.getParameter("x_description");
		}else{
			x_description = "";
		}
		if (request.getParameter("x_world") != null){
			x_world = (String) request.getParameter("x_world");
		}else{
			x_world = "";
		}
		if (request.getParameter("x_nx") != null){
			x_nx = (String) request.getParameter("x_nx");
		}else{
			x_nx = "";
		}
		if (request.getParameter("x_ny") != null){
			x_ny = (String) request.getParameter("x_ny");
		}else{
			x_ny = "";
		}
		if (request.getParameter("x_lockid") != null){
			x_lockid = (String) request.getParameter("x_lockid");
		}else{
			x_lockid = "";
		}
		if (request.getParameter("x_cost") != null){
			x_cost = (String) request.getParameter("x_cost");
		}else{
			x_cost = "";
		}

		// Open record
		String strsql = "SELECT * FROM `Area` WHERE 0 = 1";
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

		// Field world
		tmpfld = ((String) x_world).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("world");
		} else {
			rs.updateInt("world",Integer.parseInt(tmpfld));
		}

		// Field nx
		tmpfld = ((String) x_nx).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("nx");
		} else {
			rs.updateInt("nx",Integer.parseInt(tmpfld));
		}

		// Field ny
		tmpfld = ((String) x_ny).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("ny");
		} else {
			rs.updateInt("ny",Integer.parseInt(tmpfld));
		}

		// Field lockid
		tmpfld = ((String) x_lockid).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("lockid");
		} else {
			rs.updateInt("lockid",Integer.parseInt(tmpfld));
		}

		// Field cost
		tmpfld = ((String) x_cost).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("cost");
		} else {
			rs.updateInt("cost",Integer.parseInt(tmpfld));
		}
		rs.insertRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		out.clear();
		response.sendRedirect("arealist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Add to TABLE: Area<br><br><a href="arealist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_name && !EW_hasValue(EW_this.x_name, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_name, "TEXT", "Invalid Field - name"))
                return false; 
        }
if (EW_this.x_description && !EW_hasValue(EW_this.x_description, "TEXTAREA" )) {
            if (!EW_onError(EW_this, EW_this.x_description, "TEXTAREA", "Invalid Field - description"))
                return false; 
        }
if (EW_this.x_world && !EW_hasValue(EW_this.x_world, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_world, "TEXT", "Incorrect integer - world"))
                return false; 
        }
if (EW_this.x_world && !EW_checkinteger(EW_this.x_world.value)) {
        if (!EW_onError(EW_this, EW_this.x_world, "TEXT", "Incorrect integer - world"))
            return false; 
        }
if (EW_this.x_nx && !EW_hasValue(EW_this.x_nx, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_nx, "TEXT", "Incorrect integer - nx"))
                return false; 
        }
if (EW_this.x_nx && !EW_checkinteger(EW_this.x_nx.value)) {
        if (!EW_onError(EW_this, EW_this.x_nx, "TEXT", "Incorrect integer - nx"))
            return false; 
        }
if (EW_this.x_ny && !EW_hasValue(EW_this.x_ny, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_ny, "TEXT", "Incorrect integer - ny"))
                return false; 
        }
if (EW_this.x_ny && !EW_checkinteger(EW_this.x_ny.value)) {
        if (!EW_onError(EW_this, EW_this.x_ny, "TEXT", "Incorrect integer - ny"))
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
if (EW_this.x_cost && !EW_hasValue(EW_this.x_cost, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_cost, "TEXT", "Incorrect integer - cost"))
                return false; 
        }
if (EW_this.x_cost && !EW_checkinteger(EW_this.x_cost.value)) {
        if (!EW_onError(EW_this, EW_this.x_cost, "TEXT", "Incorrect integer - cost"))
            return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  action="areaadd.jsp" method="post">
<p>
<input type="hidden" name="a" value="A">
<table class="ewTable">
	<tr>
		<td class="ewTableHeader">name&nbsp;</td>
		<td class="ewTableAltRow"><input type="text" name="x_name" size="30" maxlength="255" value="<%= HTMLEncode((String)x_name) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">description&nbsp;</td>
		<td class="ewTableAltRow"><textarea name="x_description" cols="35" rows="4"><% if (x_description!=null) out.print(x_description); %></textarea>&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">world&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_world== null || ((String)x_world).equals("")) {x_world = "0"; } // set default value %><input type="text" name="x_world" size="30" value="<%= HTMLEncode((String)x_world) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">nx&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_nx== null || ((String)x_nx).equals("")) {x_nx = "0"; } // set default value %><input type="text" name="x_nx" size="30" value="<%= HTMLEncode((String)x_nx) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">ny&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_ny== null || ((String)x_ny).equals("")) {x_ny = "0"; } // set default value %><input type="text" name="x_ny" size="30" value="<%= HTMLEncode((String)x_ny) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">lockid&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_lockid== null || ((String)x_lockid).equals("")) {x_lockid = "0"; } // set default value %><input type="text" name="x_lockid" size="30" value="<%= HTMLEncode((String)x_lockid) %>">&nbsp;</td>
	</tr>
	<tr>
		<td class="ewTableHeader">cost&nbsp;</td>
		<td class="ewTableAltRow"><% if (x_cost== null || ((String)x_cost).equals("")) {x_cost = "0"; } // set default value %><input type="text" name="x_cost" size="30" value="<%= HTMLEncode((String)x_cost) %>">&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="ADD">
</form>
<%@ include file="footer.jsp" %>
