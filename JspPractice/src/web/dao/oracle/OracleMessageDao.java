package web.dao.oracle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import web.dao.MessageDao;
import web.jdbc.JdbcUtil;
import web.model.Message;

public class OracleMessageDao extends MessageDao {

	@Override
	public int insert(Connection conn, Message message) throws SQLException { //MessageDao 클래스를 상속 받기에 override 해야함 1.insert
		PreparedStatement pstmt = null;
		try {
			String query = "insert into guestbook_message "
						 + " (message_id,guest_name,password,message) "
						 + " values(message_id_seq.NEXTVAL,?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, message.getGuestName());
			pstmt.setString(2, message.getPassword());
			pstmt.setString(3, message.getMessage());
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}

	@Override
	public List<Message> selectList(Connection conn, int firstRow, int endRow) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String query ="select message_id, guest_name, password, message from ( "
					+ "    select rownum rnum, message_id, guest_name, password, message from ( "
					+ "        select * from guestbook_message m order by m.message_id desc "
					+ "    ) where rownum <= ? "
					+ ") where rnum >= ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				List<Message> messageList = new ArrayList<Message>();
			do {
				messageList.add(super.makeMessageFromResultSet(rs)); //messageDAO 클래스의 makeMessageFromResultSet 이용
			} while(rs.next());
			return messageList;
			} else {
				return Collections.emptyList(); // 아무것도 들어있지 않은 리스트를 반환한다.
			}
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
}
