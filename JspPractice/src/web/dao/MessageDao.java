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

	public abstract int insert(Connection conn, Message message) throws SQLException; //insert 추상메서드 선언
	
	public Message select(Connection conn, int messageId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String query = "select * from guestbook_message where message_id =?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, messageId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return makeMessageFromResultSet(rs); //return 값으로 makeMessageFromResultSet 메소드 호출
			} else {
				return null;
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}

	protected Message makeMessageFromResultSet(ResultSet rs) throws SQLException { //ResultSet의 결과를 만들어 내는 곳.
		Message message = new Message();
		message.setId(rs.getInt("message_id"));
		message.setGuestName(rs.getString("guest_name"));
		message.setPassword(rs.getString("password"));
		message.setMessage(rs.getString("message"));
		return message;
	}
	
	public int selectCount(Connection conn) throws SQLException{ // 방명록의 갯수가 몇개 있는지 확인하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String query = "select count(*) from guestbook_message";
			rs = stmt.executeQuery(query);
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs); // 이 2줄은 JdbcUtil을 이용해서 자원 해제
			JdbcUtil.close(stmt);
		}
	}
	public abstract List<Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException; //메소드 리스트를  저장하는 역할을 하는 추상 메소드
	
	public int delete(Connection conn, int messageId) throws SQLException { // 메시지 삭제 시 필요한 기능
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
