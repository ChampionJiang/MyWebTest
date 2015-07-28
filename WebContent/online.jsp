<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户在线信息</title>
</head>
<body>

<table width="400" border="1">
<%
Map<String, String> online = (Map<String, String>)application.getAttribute("online");
for (String sessionID: online.keySet()){%>
	<tr>
	<td><%=sessionID %>
	<td><%=online.get(sessionID) %>
	</tr>
<%}
%>

</table>

</body>
</html>