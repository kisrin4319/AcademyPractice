package imageBoard.sequence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import web.jdbc.JdbcUtil;

public class Sequencer {

	

	public synchronized static int nextId(Connection conn , String tableName) throws SQLException {
		
		PreparedStatement pstmtSelect = null;
		ResultSet rsSelect  = null;
		PreparedStatement pstmtUpdate= null;
		
		try {
			String query = "select MESSAGE_ID from ID_SEQUENCES33 where TABLE_NAME =  ?";
			pstmtSelect = conn.prepareStatement(query);
			pstmtSelect.setString(1, tableName);
			
			rsSelect = pstmtSelect.executeQuery();
			
			if(rsSelect.next()) {
				int id = rsSelect.getInt(1);
				id++;
				
				query = "update ID_SEQUENCES33 set MESSAGE_ID =? where TABLE_NAME =?";
				pstmtUpdate = conn.prepareStatement(query);
				pstmtUpdate.setInt(1, id);
				pstmtUpdate.setString(2, tableName);
				pstmtUpdate.executeUpdate();
				return id;
			} else {
				query = "insert into ID_SEQUENCES33 values(?,?)";
				pstmtUpdate = conn.prepareStatement(query);
				pstmtUpdate.setString(1, tableName);
				pstmtUpdate.setInt(2, 1);
				pstmtUpdate.executeUpdate();
				
				return 1;
			}
		} finally {
			JdbcUtil.close(rsSelect);
			JdbcUtil.close(pstmtSelect);
			JdbcUtil.close(pstmtUpdate);
		}
	}
}
