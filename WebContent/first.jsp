<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello World</title>
</head>
<%!
public int count;
%>
<body>

	<%for(int i = 0; i < 7; i++){
		out.println("<font size='"+i+"'>");
		%>Java Test</font>
		
		<br/>
	<%} %>

<%=count++ %>
</br>
</body>
</html>