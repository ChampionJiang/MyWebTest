<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test db connection</title>
</head>
<body>
<%
ResultSet rs=null;
Class.forName("com.mysql.jdbc.Driver");
int columnCount = 0;
try{
Connection conn = DriverManager.getConnection(
"jdbc:mysql://10.197.36.121:3306/tutorials","root","newman1");
Statement stmt=conn.createStatement();

rs=stmt.executeQuery("select distinct name from users");

ResultSetMetaData rsmd = rs.getMetaData();

columnCount = rsmd.getColumnCount();

//stmt.executeUpdate("delete from LU_COUNTRY");
} catch (SQLException e)
{
	out.println(e);
}
%>
<table bgcolor="#9999dd" border="1" width="300">
<%
if (rs != null) {
while(rs.next()){
	%>
	<tr>
	<%for (int i = 1; i <= columnCount; i++) { %>
	<td><%=rs.getString(i) %></td>
	<%} %>
	</tr>

<%}} %>
</table>
</body>
</html>