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
int displayRecs = 20;
int recRange = 10;
%>
<%
String tmpfld = null;
String escapeString = "\\\\'";
String dbwhere = "";
String masterdetailwhere = "";
String searchwhere = "";
String a_search = "";
String b_search = "";
String whereClause = "";
int startRec = 0, stopRec = 0, totalRecs = 0, recCount = 0;
%>
<%

// Get search criteria for basic search
String pSearch = request.getParameter("psearch");
String pSearchType = request.getParameter("psearchtype");
if (pSearch != null && pSearch.length() > 0) {
	pSearch = pSearch.replaceAll("'",escapeString);
	if (pSearchType != null && pSearchType.length() > 0) {
		while (pSearch.indexOf("  ") > 0) {
			pSearch = pSearch.replaceAll("  ", " ");
		}
		String [] arpSearch = pSearch.trim().split(" ");
		for (int i = 0; i < arpSearch.length; i++){
			String kw = arpSearch[i].trim();
			b_search = b_search + "(";
			b_search = b_search + "`name` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`image` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`description` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`xml_dialog` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`xml_items` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`xml_behave` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`attack` LIKE '%" + kw + "%' OR ";
			if (b_search.substring(b_search.length()-4,b_search.length()).equals(" OR ")) { b_search = b_search.substring(0,b_search.length()-4);}
			b_search = b_search + ") " + pSearchType + " ";
		}
	}else{
		b_search = b_search + "`name` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`image` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`description` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`xml_dialog` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`xml_items` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`xml_behave` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`attack` LIKE '%" + pSearch + "%' OR ";
	}
}
if (b_search.length() > 4 && b_search.substring(b_search.length()-4,b_search.length()).equals(" OR ")) {b_search = b_search.substring(0, b_search.length()-4);}
if (b_search.length() > 5 && b_search.substring(b_search.length()-5,b_search.length()).equals(" AND ")) {b_search = b_search.substring(0, b_search.length()-5);}
%>
<%

// Build search criteria
if (a_search != null && a_search.length() > 0) {
	searchwhere = a_search; // Advanced search
}else if (b_search != null && b_search.length() > 0) {
	searchwhere = b_search; // Basic search
}

// Save search criteria
if (searchwhere != null && searchwhere.length() > 0) {
	session.setAttribute("NPC_searchwhere", searchwhere);
	startRec = 1; // Reset start record counter (new search)
	session.setAttribute("NPC_REC", new Integer(startRec));
}else{
	if (session.getAttribute("NPC_searchwhere") != null)
		searchwhere = (String) session.getAttribute("NPC_searchwhere");
}
%>
<%

// Get clear search cmd
startRec = 0;
if (request.getParameter("cmd") != null && request.getParameter("cmd").length() > 0) {
	String cmd = request.getParameter("cmd");
	if (cmd.toUpperCase().equals("RESET")) {
		searchwhere = ""; // Reset search criteria
		session.setAttribute("NPC_searchwhere", searchwhere);
	}else if (cmd.toUpperCase().equals("RESETALL")) {
		searchwhere = ""; // Reset search criteria
		session.setAttribute("NPC_searchwhere", searchwhere);
	}
	startRec = 1; // Reset start record counter (reset command)
	session.setAttribute("NPC_REC", new Integer(startRec));
}

// Build dbwhere
if (masterdetailwhere != null && masterdetailwhere.length() > 0) {
	dbwhere = dbwhere + "(" + masterdetailwhere + ") AND ";
}
if (searchwhere != null && searchwhere.length() > 0) {
	dbwhere = dbwhere + "(" + searchwhere + ") AND ";
}
if (dbwhere != null && dbwhere.length() > 5) {
	dbwhere = dbwhere.substring(0, dbwhere.length()-5); // Trim rightmost AND
}
%>
<%

// Load Default Order
String DefaultOrder = "";
String DefaultOrderType = "";

// No Default Filter
String DefaultFilter = "";

// Check for an Order parameter
String OrderBy = request.getParameter("order");
if (OrderBy != null && OrderBy.length() > 0) {
	if (session.getAttribute("NPC_OB") != null &&
		((String) session.getAttribute("NPC_OB")).equals(OrderBy)) { // Check if an ASC/DESC toggle is required
		if (((String) session.getAttribute("NPC_OT")).equals("ASC")) {
			session.setAttribute("NPC_OT", "DESC");
		}else{
			session.setAttribute("NPC_OT", "ASC");
		}
	}else{
		session.setAttribute("NPC_OT", "ASC");
	}
	session.setAttribute("NPC_OB", OrderBy);
	session.setAttribute("NPC_REC", new Integer(1));
}else{
	OrderBy = (String) session.getAttribute("NPC_OB");
	if (OrderBy == null || OrderBy.length() == 0) {
		OrderBy = DefaultOrder;
		session.setAttribute("NPC_OB", OrderBy);
		session.setAttribute("NPC_OT", DefaultOrderType);
	}
}

// Open Connection to the database
try{
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ResultSet rs = null;

// Build SQL
String strsql = "SELECT * FROM `NPC`";
whereClause = "";
if (DefaultFilter.length() > 0) {
	whereClause = whereClause + "(" + DefaultFilter + ") AND ";
}
if (dbwhere.length() > 0) {
	whereClause = whereClause + "(" + dbwhere + ") AND ";
}
if (whereClause.length() > 5 && whereClause.substring(whereClause.length()-5, whereClause.length()).equals(" AND ")) {
	whereClause = whereClause.substring(0, whereClause.length()-5);
}
if (whereClause.length() > 0) {
	strsql = strsql + " WHERE " + whereClause;
}
if (OrderBy != null && OrderBy.length() > 0) {
	strsql = strsql + " ORDER BY `" + OrderBy + "` " + (String) session.getAttribute("NPC_OT");
}

//out.println(strsql);
rs = stmt.executeQuery(strsql);
rs.last();
totalRecs = rs.getRow();
rs.beforeFirst();
startRec = 0;
int pageno = 0;

// Check for a START parameter
if (request.getParameter("start") != null && Integer.parseInt(request.getParameter("start")) > 0) {
	startRec = Integer.parseInt(request.getParameter("start"));
	session.setAttribute("NPC_REC", new Integer(startRec));
}else if (request.getParameter("pageno") != null && Integer.parseInt(request.getParameter("pageno")) > 0) {
	pageno = Integer.parseInt(request.getParameter("pageno"));
	if (IsNumeric(request.getParameter("pageno"))) {
		startRec = (pageno-1)*displayRecs+1;
		if (startRec <= 0) {
			startRec = 1;
		}else if (startRec >= ((totalRecs-1)/displayRecs)*displayRecs+1) {
			startRec =  ((totalRecs-1)/displayRecs)*displayRecs+1;
		}
		session.setAttribute("NPC_REC", new Integer(startRec));
	}else {
		startRec = ((Integer) session.getAttribute("NPC_REC")).intValue();
		if (startRec <= 0) {
			startRec = 1; // Reset start record counter
			session.setAttribute("NPC_REC", new Integer(startRec));
		}
	}
}else{
	if (session.getAttribute("NPC_REC") != null)
		startRec = ((Integer) session.getAttribute("NPC_REC")).intValue();
	if (startRec==0) {
		startRec = 1; //Reset start record counter
		session.setAttribute("NPC_REC", new Integer(startRec));
	}
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">TABLE: NPC</span></p>
<p><span class="jspmaker"><a href="list/listNPC.jsp">Open Game View</a></span></p>
<form action="npclist.jsp">
<table border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td><span class="jspmaker">Quick Search (*)</span></td>
		<td><span class="jspmaker">
			<input type="text" name="psearch" size="20">
			<input type="Submit" name="Submit" value="GO">
		&nbsp;&nbsp;<a href="npclist.jsp?cmd=reset">Show all</a>
		</span></td>
	</tr>
	<tr><td>&nbsp;</td><td><span class="jspmaker"><input type="radio" name="psearchtype" value="" checked>Exact phrase&nbsp;&nbsp;<input type="radio" name="psearchtype" value="AND">All words&nbsp;&nbsp;<input type="radio" name="psearchtype" value="OR">Any word</span></td></tr>
</table>
</form>
<form method="post">
<table class="ewTable">
	<tr class="ewTableHeader">
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("id","UTF-8") %>">id&nbsp;<% if (OrderBy != null && OrderBy.equals("id")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("name","UTF-8") %>">name&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("name")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("image","UTF-8") %>">image&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("image")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_str","UTF-8") %>">base str&nbsp;<% if (OrderBy != null && OrderBy.equals("base_str")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_int","UTF-8") %>">base int&nbsp;<% if (OrderBy != null && OrderBy.equals("base_int")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_dex","UTF-8") %>">base dex&nbsp;<% if (OrderBy != null && OrderBy.equals("base_dex")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_cha","UTF-8") %>">base cha&nbsp;<% if (OrderBy != null && OrderBy.equals("base_cha")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_pl","UTF-8") %>">base pl&nbsp;<% if (OrderBy != null && OrderBy.equals("base_pl")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_pm","UTF-8") %>">base pm&nbsp;<% if (OrderBy != null && OrderBy.equals("base_pm")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_pa","UTF-8") %>">base pa&nbsp;<% if (OrderBy != null && OrderBy.equals("base_pa")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("base_pc","UTF-8") %>">base pc&nbsp;<% if (OrderBy != null && OrderBy.equals("base_pc")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("level","UTF-8") %>">level&nbsp;<% if (OrderBy != null && OrderBy.equals("level")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("px","UTF-8") %>">px&nbsp;<% if (OrderBy != null && OrderBy.equals("px")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("status","UTF-8") %>">status&nbsp;<% if (OrderBy != null && OrderBy.equals("status")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("area","UTF-8") %>">area&nbsp;<% if (OrderBy != null && OrderBy.equals("area")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("gold","UTF-8") %>">gold&nbsp;<% if (OrderBy != null && OrderBy.equals("gold")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("xml_dialog","UTF-8") %>">xml dialog&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("xml_dialog")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("xml_items","UTF-8") %>">xml items&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("xml_items")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("xml_behave","UTF-8") %>">xml behave&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("xml_behave")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("ismonster","UTF-8") %>">ismonster&nbsp;<% if (OrderBy != null && OrderBy.equals("ismonster")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("nattack","UTF-8") %>">nattack&nbsp;<% if (OrderBy != null && OrderBy.equals("nattack")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="npclist.jsp?order=<%= java.net.URLEncoder.encode("attack","UTF-8") %>">attack&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("attack")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("NPC_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("NPC_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
</tr>
<%

// Avoid starting record > total records
if (startRec > totalRecs) {
	startRec = totalRecs;
}

// Set the last record to display
stopRec = startRec + displayRecs - 1;

// Move to first record directly for performance reason
recCount = startRec - 1;
if (rs.next()) {
	rs.first();
	rs.relative(startRec - 1);
}
long recActual = 0;
if (startRec == 1)
   rs.beforeFirst();
else
   rs.previous();
while (rs.next() && recCount < stopRec) {
	recCount++;
	if (recCount >= startRec) {
		recActual++;
%>
<%
	String rowclass = "ewTableRow"; // Set row color
%>
<%
	if (recCount%2 != 0) { // Display alternate color for rows
		rowclass = "ewTableAltRow";
	}
%>
<%
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
	String x_area = "";
	String x_gold = "";
	String x_xml_dialog = "";
	String x_xml_items = "";
	String x_xml_behave = "";
	String x_ismonster = "";
	String x_nattack = "";
	String x_attack = "";

	// Load Key for record
	String key = "";
	key = String.valueOf(rs.getLong("id"));

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

	// area
	x_area = String.valueOf(rs.getLong("area"));

	// gold
	x_gold = String.valueOf(rs.getDouble("gold"));

	// xml_dialog
	if (rs.getString("xml_dialog") != null){
		x_xml_dialog = rs.getString("xml_dialog");
	}else{
		x_xml_dialog = "";
	}

	// xml_items
	if (rs.getString("xml_items") != null){
		x_xml_items = rs.getString("xml_items");
	}else{
		x_xml_items = "";
	}

	// xml_behave
	if (rs.getString("xml_behave") != null){
		x_xml_behave = rs.getString("xml_behave");
	}else{
		x_xml_behave = "";
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
%>
	<tr class="<%= rowclass %>">
<td><span class="jspmaker"><a href="<% key =  rs.getString("id"); 
if (key != null && key.length() > 0) { 
	out.print("npcview.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">View</a></span></td>
<td><span class="jspmaker"><a href="<% key =  rs.getString("id"); 
if (key != null && key.length() > 0) { 
	out.print("npcedit.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Edit</a></span></td>
<td><span class="jspmaker"><a href="<% key =  rs.getString("id"); 
if (key != null && key.length() > 0) { 
	out.print("npcadd.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Copy</a></span></td>
<td><span class="jspmaker"><input type="checkbox" name="key" value="<%=key %>" class="jspmaker">Delete</span></td>
		<td><% out.print(x_id); %>&nbsp;</td>
		<td><% out.print(x_name); %>&nbsp;</td>
		<td><% out.print(x_image); %>&nbsp;</td>
		<td><% out.print(x_base_str); %>&nbsp;</td>
		<td><% out.print(x_base_int); %>&nbsp;</td>
		<td><% out.print(x_base_dex); %>&nbsp;</td>
		<td><% out.print(x_base_cha); %>&nbsp;</td>
		<td><% out.print(x_base_pl); %>&nbsp;</td>
		<td><% out.print(x_base_pm); %>&nbsp;</td>
		<td><% out.print(x_base_pa); %>&nbsp;</td>
		<td><% out.print(x_base_pc); %>&nbsp;</td>
		<td><% out.print(x_level); %>&nbsp;</td>
		<td><% out.print(x_px); %>&nbsp;</td>
		<td><% out.print(x_status); %>&nbsp;</td>
		<td><% out.print(x_area); %>&nbsp;</td>
		<td><% out.print(x_gold); %>&nbsp;</td>
		<td><% out.print(x_xml_dialog); %>&nbsp;</td>
		<td><% out.print(x_xml_items); %>&nbsp;</td>
		<td><% out.print(x_xml_behave); %>&nbsp;</td>
		<td><% out.print(x_ismonster); %>&nbsp;</td>
		<td><% out.print(x_nattack); %>&nbsp;</td>
		<td><% out.print(x_attack); %>&nbsp;</td>
	</tr>
<%

//	}
}
}
%>
</table>
<% if (recActual > 0) { %>
<p><input type="button" name="btndelete" value="DELETE SELECTED" onClick="this.form.action='npcdelete.jsp';this.form.submit();"></p>
<% } %>
</form>
<%

// Close recordset and connection
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
<table border="0" cellspacing="0" cellpadding="10"><tr><td>
<%
boolean rsEof = false;
if (totalRecs > 0) {
	rsEof = (totalRecs < (startRec + displayRecs));
	int PrevStart = startRec - displayRecs;
	if (PrevStart < 1) { PrevStart = 1;}
	int NextStart = startRec + displayRecs;
	if (NextStart > totalRecs) { NextStart = startRec;}
	int LastStart = ((totalRecs-1)/displayRecs)*displayRecs+1;
	%>
<form>
	<table border="0" cellspacing="0" cellpadding="0"><tr><td><span class="jspmaker">Page</span>&nbsp;</td>
<!--first page button-->
	<% if (startRec==1) { %>
	<td><img src="images/firstdisab.gif" alt="First" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="npclist.jsp?start=1"><img src="images/first.gif" alt="First" width="20" height="15" border="0"></a></td>
	<% } %>
<!--previous page button-->
	<% if (PrevStart == startRec) { %>
	<td><img src="images/prevdisab.gif" alt="Previous" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="npclist.jsp?start=<%=PrevStart%>"><img src="images/prev.gif" alt="Previous" width="20" height="15" border="0"></a></td>
	<% } %>
<!--current page number-->
	<td><input type="text" name="pageno" value="<%=(startRec-1)/displayRecs+1%>" size="4"></td>
<!--next page button-->
	<% if (NextStart == startRec) { %>
	<td><img src="images/nextdisab.gif" alt="Next" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="npclist.jsp?start=<%=NextStart%>"><img src="images/next.gif" alt="Next" width="20" height="15" border="0"></a></td>
	<% } %>
<!--last page button-->
	<% if (LastStart == startRec) { %>
	<td><img src="images/lastdisab.gif" alt="Last" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="npclist.jsp?start=<%=LastStart%>"><img src="images/last.gif" alt="Last" width="20" height="15" border="0"></a></td>
	<% } %>
	<td><a href="npcadd.jsp"><img src="images/addnew.gif" alt="Add new" width="20" height="15" border="0"></a></td>
	<td><span class="jspmaker">&nbsp;of <%=(totalRecs-1)/displayRecs+1%></span></td>
	</td></tr></table>
</form>
	<% if (startRec > totalRecs) { startRec = totalRecs;}
	stopRec = startRec + displayRecs - 1;
	recCount = totalRecs - 1;
	if (rsEof) { recCount = totalRecs;}
	if (stopRec > recCount) { stopRec = recCount;} %>
	<span class="jspmaker">Records <%= startRec %> to <%= stopRec %> of <%= totalRecs %></span>
<% }else{ %>
	<span class="jspmaker">No records found</span>
<p>
<a href="npcadd.jsp"><img src="images/addnew.gif" alt="Add new" width="20" height="15" border="0"></a>
</p>
<% } %>
</td></tr></table>
<%@ include file="footer.jsp" %>
