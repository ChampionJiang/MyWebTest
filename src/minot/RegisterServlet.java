package minot;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.sql.*;

/**
 * Description:
 * <br/>网站: <a href="http://www.crazyit.org">疯狂Java联盟</a>
 * <br/>Copyright (C), 2001-2016, Yeeku.H.Lee
 * <br/>This program is protected by copyright laws.
 * <br/>Program Name:
 * <br/>Date:
 * @author  Yeeku.H.Lee kongyeeku@163.com
 * @version  1.0
 */
@SuppressWarnings("serial")
@WebServlet(name="register"
	, urlPatterns={"/register"})
public class RegisterServlet extends HttpServlet
{
	// 响应客户端请求的方法
	public void service(HttpServletRequest request,
		HttpServletResponse response)
		throws ServletException,java.io.IOException
	{
		String errMsg = "";
		// Servlet本身并不输出响应到客户端，因此必须将请求转发到视图页面
		RequestDispatcher rd;
		// 获取请求参数
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		try
		{
			// Servlet本身并不执行任何的业务逻辑处理，它调用JavaBean处理用户请求
			DbDao dd = new DbDao("com.mysql.jdbc.Driver",
				"jdbc:mysql://10.197.36.121:3306/liuyan","root","newman1");
			// 查询结果集
			ResultSet rs = dd.query("select pass from user_inf"
				+ " where name = ?", username);
			if (rs.next())
			{
				errMsg += "user already exists";
			}
			else
			{
				dd.modify("insert into user_inf values(null,?,?)", username, pass);
				
				HttpSession session = request.getSession(true);
				session.setAttribute("name", username);
				rd=request.getRequestDispatcher("/welcome.jsp");
				
				rd.forward(request, response);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		// 如果出错，转发到重新登录
		if (errMsg != null && !errMsg.equals(""))
		{
			rd = request.getRequestDispatcher("/login.jsp");
			request.setAttribute("err" , errMsg);
			rd.forward(request,response);
		}
	}
}
