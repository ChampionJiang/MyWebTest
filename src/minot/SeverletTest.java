package minot;

import java.io.PrintStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(name="firstSlt", urlPatterns={"/fstslt"})

public class SeverletTest extends HttpServlet {
	public void service(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException, java.io.IOException
	{
		request.setCharacterEncoding("GBK");
		
		response.setContentType("text/html);charSet=GBK");
		
		String name=request.getParameter("name");
		
		String gender=request.getParameter("gender");
		
		String[] color=request.getParameterValues("color");
		
		String nation = request.getParameter("country");
		
		PrintStream out = new PrintStream(response.getOutputStream());
		
		out.println("<html>");
		out.println("<head>");
		out.println("<title>ServletTest</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("Your name:"+name+"<hr/>");
		out.println("Your name:"+name+"<hr/>");
		out.println("Your gender:"+gender+"<hr/>");
		out.println("Color:");
		for(String c: color){
			out.println(c+" ");
		}
		
		out.println("<hr/>");
		
		out.println("Your country:"+nation+"<hr/>");
		out.println("</body>");
		out.println("</html>");
	}
}
