package web.article.service;

import java.sql.Connection;
import java.sql.SQLException;

import web.article.dao.ArticleDao;
import web.article.model.Article;
import web.article.model.UpdateRequest;
import web.jdbc.ConnectionProvider;
import web.jdbc.JdbcUtil;

public class UpdateArticleService {

	private static UpdateArticleService instance = new UpdateArticleService();
	
	public static UpdateArticleService getInstance() {
		return instance;
	}
	private UpdateArticleService() {}
	
	public Article update(UpdateRequest updateRequest) throws ArticleNotFoundException, InvalidPasswordException {
		Connection conn = null;
		try {
			conn =ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			ArticleCheckHelper checkHelper = new ArticleCheckHelper();
			checkHelper.chekckExistsAndPassword(conn, updateRequest.getArticleId(), updateRequest.getPassword());
			Article updatedArticle = new Article();
			updatedArticle.setId(updateRequest.getArticleId());
			updatedArticle.setTitle(updateRequest.getTitle());
			updatedArticle.setContent(updateRequest.getContent());
			
			ArticleDao articleDao = ArticleDao.getInstance();
			int updateCount = articleDao.update(conn, updatedArticle);
			if(updateCount == 0) {
				throw new ArticleNotFoundException("게시글이 존재하지 않습니다 : " + updateRequest.getArticleId());
			}
			
			Article article = articleDao.selectById(conn, updateRequest.getArticleId());
			
			conn.commit();
			
			return article;
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(),e);
		} catch (ArticleNotFoundException e) {
			JdbcUtil.rollback(conn);
			throw e;
		} catch (InvalidPasswordException e) {
			JdbcUtil.rollback(conn);
			throw e;
		} finally {
			if(conn!=null) { try { conn.setAutoCommit(true);} catch (SQLException e) {}
			JdbcUtil.close(conn);
			}
		}
	}
}
