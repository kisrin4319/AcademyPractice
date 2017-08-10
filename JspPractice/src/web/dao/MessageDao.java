 package web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import web.jdbc.JdbcUtil;
import web.model.Message;

public abstract class MessageDao {

	public abstract int insert(Connection conn, Message message) throws SQLException; //insert �߻�޼��� ����
	
	public Message select(Connection conn, int messageId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String query = "select * from guestbook_message where message_id =?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, messageId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return makeMessageFromResultSet(rs); //return ������ makeMessageFromResultSet �޼ҵ� ȣ��
			} else {
				return null;
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}

	protected Message makeMessageFromResultSet(ResultSet rs) throws SQLException { //ResultSet�� ����� ����� ���� ��.
		Message message = new Message();
		message.setId(rs.getInt("message_id"));
		message.setGuestName(rs.getString("guest_name"));
		message.setPassword(rs.getString("password"));
		message.setMessage(rs.getString("message"));
		return message;
	}
	
	public int selectCount(Connection conn) throws SQLException{ // ������ ������ � �ִ��� Ȯ���ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String query = "select count(*) from guestbook_message";
			rs = stmt.executeQuery(query);
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs); // �� 2���� JdbcUtil�� �̿��ؼ� �ڿ� ����
			JdbcUtil.close(stmt);
		}
	}
	public abstract List<Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException; //�޼ҵ� ����Ʈ��  �����ϴ� ������ �ϴ� �߻� �޼ҵ�
	
	public int delete(Connection conn, int messageId) throws SQLException { // �޽��� ���� �� �ʿ��� ���
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String query = "delete from guestbook_message where message_id =?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, messageId);
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
}
