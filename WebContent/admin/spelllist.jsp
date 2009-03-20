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
			b_search = b_search + "`desc` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`image` LIKE '%" + kw + "%' OR ";
			b_search = b_search + "`damage` LIKE '%" + kw + "%' OR ";
			if (b_search.substring(b_search.length()-4,b_search.length()).equals(" OR ")) { b_search = b_search.substring(0,b_search.length()-4);}
			b_search = b_search + ") " + pSearchType + " ";
		}
	}else{
		b_search = b_search + "`name` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`desc` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`image` LIKE '%" + pSearch + "%' OR ";
		b_search = b_search + "`damage` LIKE '%" + pSearch + "%' OR ";
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
	session.setAttribute("Spell_searchwhere", searchwhere);
	startRec = 1; // Reset start record counter (new search)
	session.setAttribute("Spell_REC", new Integer(startRec));
}else{
	if (session.getAttribute("Spell_searchwhere") != null)
		searchwhere = (String) session.getAttribute("Spell_searchwhere");
}
%>
<%

// Get clear search cmd
startRec = 0;
if (request.getParameter("cmd") != null && request.getParameter("cmd").length() > 0) {
	String cmd = request.getParameter("cmd");
	if (cmd.toUpperCase().equals("RESET")) {
		searchwhere = ""; // Reset search criteria
		session.setAttribute("Spell_searchwhere", searchwhere);
	}else if (cmd.toUpperCase().equals("RESETALL")) {
		searchwhere = ""; // Reset search criteria
		session.setAttribute("Spell_searchwhere", searchwhere);
	}
	startRec = 1; // Reset start record counter (reset command)
	session.setAttribute("Spell_REC", new Integer(startRec));
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
	if (session.getAttribute("Spell_OB") != null &&
		((String) session.getAttribute("Spell_OB")).equals(OrderBy)) { // Check if an ASC/DESC toggle is required
		if (((String) session.getAttribute("Spell_OT")).equals("ASC")) {
			session.setAttribute("Spell_OT", "DESC");
		}else{
			session.setAttribute("Spell_OT", "ASC");
		}
	}else{
		session.setAttribute("Spell_OT", "ASC");
	}
	session.setAttribute("Spell_OB", OrderBy);
	session.setAttribute("Spell_REC", new Integer(1));
}else{
	OrderBy = (String) session.getAttribute("Spell_OB");
	if (OrderBy == null || OrderBy.length() == 0) {
		OrderBy = DefaultOrder;
		session.setAttribute("Spell_OB", OrderBy);
		session.setAttribute("Spell_OT", DefaultOrderType);
	}
}

// Open Connection to the database
try{
Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
ResultSet rs = null;

// Build SQL
String strsql = "SELECT * FROM `Spell`";
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
	strsql = strsql + " ORDER BY `" + OrderBy + "` " + (String) session.getAttribute("Spell_OT");
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
	session.setAttribute("Spell_REC", new Integer(startRec));
}else if (request.getParameter("pageno") != null && Integer.parseInt(request.getParameter("pageno")) > 0) {
	pageno = Integer.parseInt(request.getParameter("pageno"));
	if (IsNumeric(request.getParameter("pageno"))) {
		startRec = (pageno-1)*displayRecs+1;
		if (startRec <= 0) {
			startRec = 1;
		}else if (startRec >= ((totalRecs-1)/displayRecs)*displayRecs+1) {
			startRec =  ((totalRecs-1)/displayRecs)*displayRecs+1;
		}
		session.setAttribute("Spell_REC", new Integer(startRec));
	}else {
		startRec = ((Integer) session.getAttribute("Spell_REC")).intValue();
		if (startRec <= 0) {
			startRec = 1; // Reset start record counter
			session.setAttribute("Spell_REC", new Integer(startRec));
		}
	}
}else{
	if (session.getAttribute("Spell_REC") != null)
		startRec = ((Integer) session.getAttribute("Spell_REC")).intValue();
	if (startRec==0) {
		startRec = 1; //Reset start record counter
		session.setAttribute("Spell_REC", new Integer(startRec));
	}
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">TABLE: Spell</span></p>
<form action="spelllist.jsp">
<table border="0" cellspacing="0" cellpadding="4">
	<tr>
		<td><span class="jspmaker">Quick Search (*)</span></td>
		<td><span class="jspmaker">
			<input type="text" name="psearch" size="20">
			<input type="Submit" name="Submit" value="GO">
		&nbsp;&nbsp;<a href="spelllist.jsp?cmd=reset">Show all</a>
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
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("id","UTF-8") %>">id&nbsp;<% if (OrderBy != null && OrderBy.equals("id")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("name","UTF-8") %>">name&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("name")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("desc","UTF-8") %>">desc&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("desc")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("image","UTF-8") %>">image&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("image")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("costMp","UTF-8") %>">cost Mp&nbsp;<% if (OrderBy != null && OrderBy.equals("costMp")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("req_str","UTF-8") %>">req str&nbsp;<% if (OrderBy != null && OrderBy.equals("req_str")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("req_int","UTF-8") %>">req int&nbsp;<% if (OrderBy != null && OrderBy.equals("req_int")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("req_wis","UTF-8") %>">req wis&nbsp;<% if (OrderBy != null && OrderBy.equals("req_wis")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("req_dex","UTF-8") %>">req dex&nbsp;<% if (OrderBy != null && OrderBy.equals("req_dex")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("req_cha","UTF-8") %>">req cha&nbsp;<% if (OrderBy != null && OrderBy.equals("req_cha")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("req_lev","UTF-8") %>">req lev&nbsp;<% if (OrderBy != null && OrderBy.equals("req_lev")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("mod_str","UTF-8") %>">mod str&nbsp;<% if (OrderBy != null && OrderBy.equals("mod_str")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("mod_int","UTF-8") %>">mod int&nbsp;<% if (OrderBy != null && OrderBy.equals("mod_int")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("mod_wis","UTF-8") %>">mod wis&nbsp;<% if (OrderBy != null && OrderBy.equals("mod_wis")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("mod_dex","UTF-8") %>">mod dex&nbsp;<% if (OrderBy != null && OrderBy.equals("mod_dex")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("mod_cha","UTF-8") %>">mod cha&nbsp;<% if (OrderBy != null && OrderBy.equals("mod_cha")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("price","UTF-8") %>">price&nbsp;<% if (OrderBy != null && OrderBy.equals("price")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("lev","UTF-8") %>">lev&nbsp;<% if (OrderBy != null && OrderBy.equals("lev")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("duration","UTF-8") %>">duration&nbsp;<% if (OrderBy != null && OrderBy.equals("duration")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("spelltype","UTF-8") %>">spelltype&nbsp;<% if (OrderBy != null && OrderBy.equals("spelltype")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("damage","UTF-8") %>">damage&nbsp;(*)<% if (OrderBy != null && OrderBy.equals("damage")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("savingthrow","UTF-8") %>">savingthrow&nbsp;<% if (OrderBy != null && OrderBy.equals("savingthrow")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
		</td>
		<td>
<a href="spelllist.jsp?order=<%= java.net.URLEncoder.encode("initiative","UTF-8") %>">initiative&nbsp;<% if (OrderBy != null && OrderBy.equals("initiative")) { %><span class="ewTableOrderIndicator"><% if (((String) session.getAttribute("Spell_OT")).equals("ASC")) { %>5<% }else if (((String) session.getAttribute("Spell_OT")).equals("DESC")) { %>6<% } %></span><% } %></a>
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
	String x_desc = "";
	String x_image = "";
	String x_costMp = "";
	String x_req_str = "";
	String x_req_int = "";
	String x_req_wis = "";
	String x_req_dex = "";
	String x_req_cha = "";
	String x_req_lev = "";
	String x_mod_str = "";
	String x_mod_int = "";
	String x_mod_wis = "";
	String x_mod_dex = "";
	String x_mod_cha = "";
	String x_price = "";
	String x_lev = "";
	String x_duration = "";
	String x_spelltype = "";
	String x_damage = "";
	String x_savingthrow = "";
	String x_initiative = "";

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

	// req_wis
	x_req_wis = String.valueOf(rs.getLong("req_wis"));

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

	// mod_wis
	x_mod_wis = String.valueOf(rs.getLong("mod_wis"));

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
%>
	<tr class="<%= rowclass %>">
<td><span class="jspmaker"><a href="<% key =  rs.getString("id"); 
if (key != null && key.length() > 0) { 
	out.print("spellview.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">View</a></span></td>
<td><span class="jspmaker"><a href="<% key =  rs.getString("id"); 
if (key != null && key.length() > 0) { 
	out.print("spelledit.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Edit</a></span></td>
<td><span class="jspmaker"><a href="<% key =  rs.getString("id"); 
if (key != null && key.length() > 0) { 
	out.print("spelladd.jsp?key=" + java.net.URLEncoder.encode(key,"UTF-8"));
}else{
	out.print("javascript:alert('Invalid Record! Key is null');");
} %>">Copy</a></span></td>
<td><span class="jspmaker"><input type="checkbox" name="key" value="<%=key %>" class="jspmaker">Delete</span></td>
		<td><% out.print(x_id); %>&nbsp;</td>
		<td><% out.print(x_name); %>&nbsp;</td>
		<td><% out.print(x_desc); %>&nbsp;</td>
		<td><% out.print(x_image); %>&nbsp;</td>
		<td><% out.print(x_costMp); %>&nbsp;</td>
		<td><% out.print(x_req_str); %>&nbsp;</td>
		<td><% out.print(x_req_int); %>&nbsp;</td>
		<td><% out.print(x_req_wis); %>&nbsp;</td>
		<td><% out.print(x_req_dex); %>&nbsp;</td>
		<td><% out.print(x_req_cha); %>&nbsp;</td>
		<td><% out.print(x_req_lev); %>&nbsp;</td>
		<td><% out.print(x_mod_str); %>&nbsp;</td>
		<td><% out.print(x_mod_int); %>&nbsp;</td>
		<td><% out.print(x_mod_wis); %>&nbsp;</td>
		<td><% out.print(x_mod_dex); %>&nbsp;</td>
		<td><% out.print(x_mod_cha); %>&nbsp;</td>
		<td><% out.print(x_price); %>&nbsp;</td>
		<td><% out.print(x_lev); %>&nbsp;</td>
		<td><% out.print(x_duration); %>&nbsp;</td>
		<td><% out.print(x_spelltype); %>&nbsp;</td>
		<td><% out.print(x_damage); %>&nbsp;</td>
		<td><% out.print(x_savingthrow); %>&nbsp;</td>
		<td><% out.print(x_initiative); %>&nbsp;</td>
	</tr>
<%

//	}
}
}
%>
</table>
<% if (recActual > 0) { %>
<p><input type="button" name="btndelete" value="DELETE SELECTED" onClick="this.form.action='spelldelete.jsp';this.form.submit();"></p>
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
	<td><a href="spelllist.jsp?start=1"><img src="images/first.gif" alt="First" width="20" height="15" border="0"></a></td>
	<% } %>
<!--previous page button-->
	<% if (PrevStart == startRec) { %>
	<td><img src="images/prevdisab.gif" alt="Previous" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="spelllist.jsp?start=<%=PrevStart%>"><img src="images/prev.gif" alt="Previous" width="20" height="15" border="0"></a></td>
	<% } %>
<!--current page number-->
	<td><input type="text" name="pageno" value="<%=(startRec-1)/displayRecs+1%>" size="4"></td>
<!--next page button-->
	<% if (NextStart == startRec) { %>
	<td><img src="images/nextdisab.gif" alt="Next" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="spelllist.jsp?start=<%=NextStart%>"><img src="images/next.gif" alt="Next" width="20" height="15" border="0"></a></td>
	<% } %>
<!--last page button-->
	<% if (LastStart == startRec) { %>
	<td><img src="images/lastdisab.gif" alt="Last" width="20" height="15" border="0"></td>
	<% }else{ %>
	<td><a href="spelllist.jsp?start=<%=LastStart%>"><img src="images/last.gif" alt="Last" width="20" height="15" border="0"></a></td>
	<% } %>
	<td><a href="spelladd.jsp"><img src="images/addnew.gif" alt="Add new" width="20" height="15" border="0"></a></td>
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
<a href="spelladd.jsp"><img src="images/addnew.gif" alt="Add new" width="20" height="15" border="0"></a>
</p>
<% } %>
</td></tr></table>
<%@ include file="footer.jsp" %>
