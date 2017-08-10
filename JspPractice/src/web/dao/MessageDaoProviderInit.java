package web.dao;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
 //서버가 실행 될 때 web.xml MessageDaoProviderInit param 설정을 읽어와서 제일 먼저 들름..
public class MessageDaoProviderInit extends HttpServlet {

	public void init(ServletConfig config) throws ServletException {
		String dbms = config.getInitParameter("dbms");
		if(dbms!=null) {
			MessageDaoProvider.getInstance().setDbms(dbms); //-> 여기서 MessageDaoProvider의 dbms 종류를 설정 한다.
		}
	}
}
