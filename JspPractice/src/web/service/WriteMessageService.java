package web.service;

import java.sql.Connection;

import web.dao.MessageDao;
import web.dao.MessageDaoProvider;
import web.jdbc.ConnectionProvider;
import web.jdbc.JdbcUtil;
import web.model.Message;

public class WriteMessageService {

	private static WriteMessageService instance = new WriteMessageService();
	
	public static WriteMessageService getInstance() {
		return instance;
	}
	
	private WriteMessageService() {}
	
	public void write(Message message) throws ServiceException{
		Connection conn =null;
		try {
			conn= ConnectionProvider.getConnection();
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			messageDao.insert(conn, message);
		} catch (Exception e) {
			throw new ServiceException("메시지 등록 실패 :" +e.getMessage(),e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
}
