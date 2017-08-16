package web.article.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;

import javax.management.RuntimeErrorException;

import web.article.dao.ArticleDao;
import web.article.model.Article;
import web.article.model.WritingRequest;
import web.jdbc.ConnectionProvider;
import web.jdbc.JdbcUtil;

public class WriteArticleService {

	private static WriteArticleService instance = new WriteArticleService();
	public static WriteArticleService getInstance() {
		return instance;
	}
	private WriteArticleService() {}
	
	public Article write(WritingRequest writingRequest) throws IdGenerationFailedException {
		
		int groupid = IdGenerator.getInstance().generateNextId("article");
		Article article = writingRequest.toArticle();
		
		article.setGroupid(groupid);
		article.setPostingDate(new Date());
		DecimalFormat decimalFormat = new DecimalFormat("0000000000");
		article.setSequenceNumber(decimalFormat.format(groupid)+"999999");
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			int articleId = ArticleDao.getInstance().insert(conn, article);
			
			if(articleId == -1) {
				JdbcUtil.rollback(conn);
				throw new RuntimeException("DB »ðÀÔ ¾ÈµÊ: "+articleId);
			}
			conn.commit();
			
			article.setId(articleId);
			return article;
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException("DB ¿¡·¯: "+e.getMessage(),e);
		} finally {
			if(conn!=null) {
				try {
					conn.setAutoCommit(true);
					} catch(SQLException e){}
			}
			JdbcUtil.close(conn);
			}
		}
	}
