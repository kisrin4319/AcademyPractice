package web.article.service;

import java.sql.Connection;
import java.sql.SQLException;

import web.article.dao.ArticleDao;
import web.article.model.Article;

public class ArticleCheckHelper {

	public Article chekckExistsAndPassword(Connection conn , int articleId,String password) throws SQLException, ArticleNotFoundException, InvalidPasswordException {
		ArticleDao articleDao = ArticleDao.getInstance();
		Article article = articleDao.selectById(conn, articleId);
		if(article ==  null) {
			throw new ArticleNotFoundException("�Խñ��� �������� �ʽ��ϴ� : " + articleId);
		}
		if(!checkPassword(article.getPassword(),password)) {
			throw new InvalidPasswordException("�߸��� ��ȣ");
		}
		return article;
	}

	private boolean checkPassword(String realPassword, String userInputPassword) {
		if(realPassword == null) {
			return false;
		}
		if(realPassword.length() ==0){
			return false;
		}
		return realPassword.equals(userInputPassword);
	}
}
