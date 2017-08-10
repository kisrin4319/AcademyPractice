package web.dao;

import web.dao.oracle.OracleMessageDao;

public class MessageDaoProvider {
	
	private static MessageDaoProvider instance = new MessageDaoProvider();
	public static MessageDaoProvider getInstance() {
		return instance;
	}
	private MessageDaoProvider() {}
	
	private OracleMessageDao oracleDao = new OracleMessageDao();
	
	private String dbms;
	
	public void setDbms(String dbms) {
		this.dbms = dbms;
	}
	
	public MessageDao getMessageDao() {
		if("oracle".equals(dbms)) {
			return oracleDao;
		}
		return null;
	}
}
