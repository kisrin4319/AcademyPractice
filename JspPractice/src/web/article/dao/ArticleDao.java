package web.article.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import web.article.model.Article;
import web.jdbc.JdbcUtil;

public class ArticleDao { //ListArticleService가 필요로 하는 데이터를 제공한다.

	private static ArticleDao instance = new ArticleDao();
	public static ArticleDao getInstance() {
		return instance;
	}
	
	private ArticleDao() {}
	
	public int selectCount(Connection conn) throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String query = "select count(*) from article"; //article 테이블에서 전체 행의 개수를 구한다.
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	
	public int selectKeywordCount(Connection conn,int n, String keyword) throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
		String[] col_name = {"writer_name","title","content"};
		try {
			String query = "select count(*) from article where "+col_name[n]+" like '%"+keyword+"%'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			return rs.getInt(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
		}
	}
	
	public List<Article> select(Connection conn, int firstRow, int endRow) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String query = "select article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( "
					+ "select rownum rnum, article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( "
					+ "select * from article m order by m.sequence_no desc "
					+ ") where rownum <= ? "
					+ ") where rnum >= ?";
			//article 데이터를 sequence_no의 내림차순으로 정렬해서 시작 행과 끝 행에 해당 되는 행만 구한다.
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return Collections.emptyList(); // 데이터가 없을 경우 빈 List 리턴
			}
			List<Article> articleList = new ArrayList<Article>();
			do {
				Article article = makeArticleFromResultSet(rs,false);
				articleList.add(article);
			} while(rs.next());
			return articleList;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	public List<Article> selectKeyword(Connection conn, int firstRow, int endRow, int n, String keyword) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String[] col_name = {"writer_name","title","content"};
		try {
			String query = "select article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( "
					+ "select rownum rnum, article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( "
					+ "select * from article m order by m.sequence_no desc ) where "+col_name[n]+" like '%"+keyword+"%' and rownum <= ? ) where rnum >= ?";
			//article 데이터를 sequence_no의 내림차순으로 정렬해서 시작 행과 끝 행에 해당 되는 행만 구한다.
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return Collections.emptyList(); // 데이터가 없을 경우 빈 List 리턴
			}
			List<Article> articleList = new ArrayList<Article>();
			do {
				Article article = makeArticleFromResultSet(rs,false);
				articleList.add(article);
			} while(rs.next());
			return articleList;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}

	private Article makeArticleFromResultSet(ResultSet rs, boolean readContent) throws SQLException {
		Article article = new Article();
		article.setId(rs.getInt("article_id"));
		article.setGroupid(rs.getInt("group_id"));
		article.setSequenceNumber(rs.getString("sequence_no"));
		article.setPostingDate(rs.getTimestamp("posting_date"));
		article.setReadCount(rs.getInt("read_count"));
		article.setWriterName(rs.getString("writer_name"));
		article.setPassword(rs.getString("password"));
		article.setTitle(rs.getString("title"));
		if(readContent) {
			article.setContent(rs.getString("content"));
		}
		return article;
	}
	
	public int insert(Connection conn, Article article) throws SQLException{
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String query = "insert into article "
					+ "(article_id, group_id, sequence_no, posting_date, read_count, "
					+ "writer_name, password, title, content) "
					+ "values (article_id_seq.NEXTVAL, ?, ?, ?, 0, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, article.getGroupid());
				pstmt.setString(2, article.getSequenceNumber());
				pstmt.setTimestamp(3, new Timestamp(article.getPostingDate().getTime()));
				pstmt.setString(4, article.getWriterName());
				pstmt.setString(5, article.getPassword());
				pstmt.setString(6, article.getTitle());
				pstmt.setString(7, article.getContent());
			
				int insertedCount = pstmt.executeUpdate();
				
				if(insertedCount >0) {
					stmt = conn.createStatement();
					rs = stmt.executeQuery("select article_id_seq.currval from dual");
					if(rs.next()) {
						return rs.getInt(1);
					}
				}
				return -1;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
			JdbcUtil.close(pstmt);
		}
	}
	public Article selectById(Connection conn, int articleId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs =  null;
		try {
			pstmt = conn.prepareStatement("select * from article where article_id =?");
			pstmt.setInt(1, articleId);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return null;
			}
			Article article = makeArticleFromResultSet(rs, true);
			return article;
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	public void increaseReadCount(Connection conn, int articleId) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement("update article set read_count = read_count+1 where article_id =?");
			pstmt.setInt(1, articleId);
			pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	public String selectLastSequenceNumber(Connection conn, String searchMaxSeqNum, String searchMinSeqNum) throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String query = "select min(sequence_no) from article where sequence_no < ? and sequence_no >= ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, searchMaxSeqNum);
			pstmt.setString(2, searchMinSeqNum);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return null;
			}
			return rs.getString(1);
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
	}
	
	public int update(Connection conn, Article article) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String query = "update article set title = ? , content =? where article_id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getTitle());
			pstmt.setString(2, article.getContent());
			pstmt.setInt(3, article.getId());
			return pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
	
	public void delete(Connection conn, int articleId) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			String query = "delete from article where article_id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, articleId);
			pstmt.executeUpdate();
		} finally {
			JdbcUtil.close(pstmt);
		}
	}
}
