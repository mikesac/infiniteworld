<%@ page import="java.sql.*"%>
<%
try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
}catch (Exception ex){
	out.println(ex.toString());
}
String xDb_Conn_Str = "jdbc:mysql://s155.eatj.com:3306/mikesac";
Connection conn = null;
try{
	conn = DriverManager.getConnection(xDb_Conn_Str,"mikesac","qemenldan");
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
