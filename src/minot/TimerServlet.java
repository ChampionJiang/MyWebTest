package minot;

import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.annotation.*;

import javax.swing.*;
import java.awt.event.*;
import java.util.Date;

@WebServlet(loadOnStartup=1, urlPatterns={"/timer"})
public class TimerServlet extends HttpServlet {
	public void init(ServletConfig config) throws ServletException{
		super.init(config);
//		Timer t=new Timer(2000, new ActionListener(){
//			public void actionPerformed(ActionEvent e){
//				System.out.println(new Date());
//			}
//
//		});
//		t.start();
	}
}
