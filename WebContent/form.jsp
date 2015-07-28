<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form id="form1" method="post" action="fstslt">
name:<br/>

<input type="text" name="name"><hr/>

gender:<br/>
male:<input type="radio" name="gender" value="male">
female:<input type="radio" name="gender" value="female"><hr/>

like color:<br/>

red:<input type="checkbox" name="color" value="red">
green:<input type="checkbox" name="color" value="green">
blue:<input type="checkbox" name="color" value="blue"><hr/>

from country:<br/>
<select name="country">
	<option value="China">CHINA</option>
	<option value="USA">USA</option>
	<option value="UK">UK</option>
</select><hr/>
<input type="submit" value="submit">
<input type="reset" value="reset">
</form>

</body>
</html>