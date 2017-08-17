package web.article.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import web.article.dao.ArticleDao;
import web.article.model.Article;
import web.article.model.ArticleListModel;
import web.jdbc.ConnectionProvider;
import web.jdbc.JdbcUtil;

public class ListArticleService {

	private static ListArticleService instance = new ListArticleService();
	public static ListArticleService getInstance() {
		return instance;
	}
	
	public static final int COUNT_PER_PAGE = 10; // �� �������� ������ �Խñ� ���� 10���� ����
	
	public ArticleListModel getArticleList(int requestPageNumber) {
		if(requestPageNumber <0) {
			throw new IllegalArgumentException("page number <0 :" + requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int totalArticleCount = articleDao.selectCount(conn); // ��ü �Խñ� ���� ����
			
			if(totalArticleCount == 0) { //��ü �Խñ��� 0���� ��� �⺻ ArticleListModel ��ü�� �����Ѵ�.
				return new ArticleListModel();
			}
			
			int totalPageCount = calculateTotalPageCount(totalArticleCount); //calculateTotalPageCount()�޼��带 ȣ���ؼ� ��ü ������ ������ ���Ѵ�. 
			
			int firstRow = (requestPageNumber -1) * COUNT_PER_PAGE +1;
			int endRow = firstRow + COUNT_PER_PAGE -1;
			
			if(endRow > totalArticleCount) {
				endRow = totalArticleCount;
			}
			
			List<Article> articleList = articleDao.select(conn, firstRow, endRow); // ArticleDao.select() �޼��带 �̿��ؼ� �о�� ���� ���� ��ȣ�� �� ��ȣ�� ���ϴ� Article ����� ���Ѵ�.
			
			ArticleListModel articleListView = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow); //Article ���, ��û ������ ��ȣ, ��ü ������ ����, ���� ��, �� ���� �̿��ؼ�  ArticleListModel ��ü�� ������ �� �����Ѵ�.
			
			return articleListView;
		} catch (SQLException e) {
			throw new RuntimeException("DB ���� �߻�:" + e.getMessage(),e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public ArticleListModel getKeywordList(int requestPageNumber,int n, String keyword) {
		if(requestPageNumber <0) {
			throw new IllegalArgumentException("page number <0 :" + requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int totalKeywordArticleCount = articleDao.selectKeywordCount(conn,n,keyword); // ��ü �Խñ� ���� ����
			
			if(totalKeywordArticleCount == 0) { //��ü �Խñ��� 0���� ��� �⺻ ArticleListModel ��ü�� �����Ѵ�.
				return new ArticleListModel();
			}
			
			int totalPageCount = calculateTotalPageCount(totalKeywordArticleCount); //calculateTotalPageCount()�޼��带 ȣ���ؼ� ��ü ������ ������ ���Ѵ�. 
			System.out.println(totalPageCount);
			int firstRow = (requestPageNumber -1) * COUNT_PER_PAGE +1;
			int endRow = firstRow + COUNT_PER_PAGE -1;
	
			if(endRow > totalKeywordArticleCount) {
				endRow = totalKeywordArticleCount;
			}
			
			List<Article> articleList = articleDao.selectKeyword(conn, firstRow, endRow, n, keyword); // ArticleDao.select() �޼��带 �̿��ؼ� �о�� ���� ���� ��ȣ�� �� ��ȣ�� ���ϴ� Article ����� ���Ѵ�.
			
			ArticleListModel articleKeywordListView = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow); //Article ���, ��û ������ ��ȣ, ��ü ������ ����, ���� ��, �� ���� �̿��ؼ�  ArticleListModel ��ü�� ������ �� �����Ѵ�.
			
			return articleKeywordListView;
		} catch (SQLException e) {
			throw new RuntimeException("DB ���� �߻�:" + e.getMessage(),e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

	private int calculateTotalPageCount(int totalArticleCount) { //��ü �Խñ� �����κ��� ��ü ������ ������ ���� �ִ� �޼���
		if(totalArticleCount == 0) {
			return 0;
		}
		int pageCount = totalArticleCount/COUNT_PER_PAGE;
		if(totalArticleCount % COUNT_PER_PAGE >0) {
			pageCount++;
		}
		return pageCount;
	}
}
