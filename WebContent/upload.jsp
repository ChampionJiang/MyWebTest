<%--
网站: <a href="http://www.crazyit.org">疯狂Java联盟</a>
author  yeeku.H.lee kongyeeku@163.com
version  1.0
Copyright (C), 2001-2016, yeeku.H.Lee
This program is protected by copyright laws.
Program Name:
Date: 
--%>

<%@ page contentType="text/html; charset=GBK" language="java" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.awt.image.*, javax.imageio.*, java.io.*, java.awt.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title> upload </title>
	<meta name="website" content="http://www.crazyit.org" />
</head>
<body>
<!-- 输出出错提示 -->
<span style="color:red;font-weight:bold">
<%

%>
</span>
Please select the picture to upload
<form id="upload" method="post" action="uploadimage.jsp" method="post" enctype="multipart/form-data" name="form1">
file:<input type="file" name="file" multiple="multiple"/><br/>
name:<input type="text" name="filename"/><br/>
upload:<input type="submit" name="Submit" value="upload"/>
</form>
</body>
</html>