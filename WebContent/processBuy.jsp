<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%
Map<String, Integer> itemMap=(Map<String, Integer>)session.getAttribute("itemMap");

if (itemMap==null) {
	itemMap = new HashMap<String, Integer>();
	itemMap.put("book", 0);
	itemMap.put("computer", 0);
	itemMap.put("car", 0);
}

String[] buys=request.getParameterValues("item");
for (String item: buys){
	if (item.equals("book")){
		int num1 = itemMap.get("book").intValue();
		itemMap.put("book", num1+1);
	}
	if (item.equals("computer")){
		int num1 = itemMap.get("computer").intValue();
		itemMap.put("computer", num1+1);
	}
	if (item.equals("car")){
		int num1 = itemMap.get("car").intValue();
		itemMap.put("car", num1+1);
	}
	
	session.setAttribute("itemMap", itemMap);
	
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

Your purchases:<br/>

books: <%=itemMap.get("book") %><br/>
computer: <%=itemMap.get("computer") %><br/>
car:<%=itemMap.get("car") %>
<p><a href="shop.jsp"> buy again</a></p>

</body>
</html>