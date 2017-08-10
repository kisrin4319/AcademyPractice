package web.dao;

import web.dao.oracle.OracleMessageDao;

public class MessageDaoProvider {
	 //�̱��� �������ν� MessageDaoProvider ��ü ����..
	private static MessageDaoProvider instance = new MessageDaoProvider();
	public static MessageDaoProvider getInstance() {
		return instance;
	}
	private MessageDaoProvider() {}
	//dbms Ÿ�Ժ� DAO ��ü => ����� Oracle�� ���
	private OracleMessageDao oracleDao = new OracleMessageDao();
	
	private String dbms;
	// DBMS Ÿ�� ����
	public void setDbms(String dbms) {
		this.dbms = dbms;
	}
	//������ DBMS ���� ���� �˸��� dao ��ü ���� => web.xml �� param-name = dbms �� �ְ� param-value �� Oracle�� �־��� ������  
	public MessageDao getMessageDao() {
		if("oracle".equals(dbms)) {
			return oracleDao;
		}
		return null;
	}
}
