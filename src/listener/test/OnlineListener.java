package listener.test;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.*;

@WebListener
public class OnlineListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		HttpSession session = se.getSession();
		ServletContext application = session.getServletContext();
		
		String sessionID = session.getId();
		
		if (session.isNew()) {
			String user = (String) session.getAttribute("user");
			
			user = (user==null) ? "游客" : user;
			
			Map<String, String> online = (Map<String, String>) application.getAttribute("online");
			if (online == null) {
				online = new Hashtable<String, String>();
			}
			
			
			online.put(sessionID, user);
			
			application.setAttribute("online", online);
			
		}
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
		HttpSession session = se.getSession();
		ServletContext application = session.getServletContext();
		String sessionID = session.getId();
		Map<String, String> online = (Map<String, String>) application.getAttribute("online");
		if (online != null)
		{
			online.remove(sessionID);
		}
		
		application.setAttribute("online", online);
		
	}
	
}
