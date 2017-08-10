package web.dao;

import web.dao.oracle.OracleMessageDao;

public class MessageDaoProvider {
	 //싱글톤 패턴으로써 MessageDaoProvider 객체 생성..
	private static MessageDaoProvider instance = new MessageDaoProvider();
	public static MessageDaoProvider getInstance() {
		return instance;
	}
	private MessageDaoProvider() {}
	//dbms 타입별 DAO 객체 => 현재는 Oracle만 사용
	private OracleMessageDao oracleDao = new OracleMessageDao();
	
	private String dbms;
	// DBMS 타입 설정
	public void setDbms(String dbms) {
		this.dbms = dbms;
	}
	//설정한 DBMS 값에 따라서 알맞은 dao 객체 리턴 => web.xml 에 param-name = dbms 로 주고 param-value 는 Oracle로 주었기 때문에  
	public MessageDao getMessageDao() {
		if("oracle".equals(dbms)) {
			return oracleDao;
		}
		return null;
	}
}
