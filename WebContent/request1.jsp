<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Enumeration<String> headerNames=request.getHeaderNames();
while(headerNames.hasMoreElements()){
	String headName=headerNames.nextElement();
	out.println(headName+"-->"+request.getHeader(headName)+"<br/>");
}

out.println("<hr/>");

String name=request.getParameter("name");
String gender=request.getParameter("gender");

String [] color = request.getParameterValues("color");
String country = request.getParameter("country");
%>

Your Name: <%=name %> <hr/>
Your Gender: <%=gender %><hr/>

Color you liked: <%for(String s: color)
	{out.println(s+ " ");}%><hr/>

You are from: <%=country %><hr/>
<% 
Class.forName("com.mysql.jdbc.Driver");
try{
Connection conn = DriverManager.getConnection(
"jdbc:mysql://10.197.36.121:3306/tutorials","root","newman1");
Statement stmt=conn.createStatement();
Random random = new Random(1020);
StringBuffer sb = new StringBuffer("insert into users(name, gender, color, country, profit) values");

for (String c: color){
	sb.append("('"+name+"','"+gender+"','"+c+"','"+country+"',"+random.nextDouble()*1000+ "),");
}
int lastChar =sb.lastIndexOf(","); 
if (lastChar == sb.length()-1)
	sb.deleteCharAt(lastChar);

String s = sb.toString();

stmt.executeUpdate(sb.toString());

} catch (SQLException e)
{
	out.println(e);
}
%>
</body>
</html>