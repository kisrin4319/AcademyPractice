package web.service;

import java.sql.Connection;
import java.sql.SQLException;

import web.dao.MessageDao;
import web.dao.MessageDaoProvider;
import web.jdbc.ConnectionProvider;
import web.jdbc.JdbcUtil;
import web.model.Message;

public class DeleteMessageService {

	private static DeleteMessageService instance = new DeleteMessageService();
	public static DeleteMessageService getInstance() {
		return instance;
	}
	private DeleteMessageService() {}
	
	public void deleteMessage(int messageId,String password) throws ServiceException,InvalidMessagePassowrdException,MessageNotFoundException{
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			MessageDao messageDao = MessageDaoProvider.getInstance().getMessageDao();
			Message message = messageDao.select(conn, messageId);
			if(message == null) {
				throw new MessageNotFoundException("메시지가 없습니다:" +messageId);
			}
			if(!message.hasPassword()) {
				throw new InvalidMessagePassowrdException();
			}
			if(!message.getPassword().equals(password)) {
				throw new InvalidMessagePassowrdException();
			}
			messageDao.delete(conn, messageId);
			
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new ServiceException("삭제 처리 중 에러가 발생했습니다. :"+e.getMessage(),e);
		} catch (InvalidMessagePassowrdException e) {
			JdbcUtil.rollback(conn);
			throw e;
		} catch (MessageNotFoundException e) {
			JdbcUtil.rollback(conn);
			throw e;
		} finally {
			if(conn!=null) { try { conn.setAutoCommit(false);} catch (SQLException e) { }
			JdbcUtil.close(conn);
			}
		}
	}
}
