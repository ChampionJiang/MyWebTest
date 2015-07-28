package minot;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.sql.*;

/**
 * Description:
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
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
	// ��Ӧ�ͻ�������ķ���
	public void service(HttpServletRequest request,
		HttpServletResponse response)
		throws ServletException,java.io.IOException
	{
		String errMsg = "";
		// Servlet�����������Ӧ���ͻ��ˣ���˱��뽫����ת������ͼҳ��
		RequestDispatcher rd;
		// ��ȡ�������
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		try
		{
			// Servlet������ִ���κε�ҵ���߼�����������JavaBean�����û�����
			DbDao dd = new DbDao("com.mysql.jdbc.Driver",
				"jdbc:mysql://10.197.36.121:3306/liuyan","root","newman1");
			// ��ѯ�����
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
		// �������ת�������µ�¼
		if (errMsg != null && !errMsg.equals(""))
		{
			rd = request.getRequestDispatcher("/login.jsp");
			request.setAttribute("err" , errMsg);
			rd.forward(request,response);
		}
	}
}
