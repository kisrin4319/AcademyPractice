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
	
	public static final int COUNT_PER_PAGE = 10; // 한 페이지에 보여줄 게시글 수를 10개로 설정
	
	public ArticleListModel getArticleList(int requestPageNumber) {
		if(requestPageNumber <0) {
			throw new IllegalArgumentException("page number <0 :" + requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int totalArticleCount = articleDao.selectCount(conn); // 전체 게시글 개수 구함
			
			if(totalArticleCount == 0) { //전체 게시글이 0개인 경우 기본 ArticleListModel 객체를 리턴한다.
				return new ArticleListModel();
			}
			
			int totalPageCount = calculateTotalPageCount(totalArticleCount); //calculateTotalPageCount()메서드를 호출해서 전체 페이지 개수를 구한다. 
			
			int firstRow = (requestPageNumber -1) * COUNT_PER_PAGE +1;
			int endRow = firstRow + COUNT_PER_PAGE -1;
			
			if(endRow > totalArticleCount) {
				endRow = totalArticleCount;
			}
			
			List<Article> articleList = articleDao.select(conn, firstRow, endRow); // ArticleDao.select() 메서드를 이용해서 읽어올 행의 시작 번호와 끝 번호에 속하는 Article 목록을 구한다.
			
			ArticleListModel articleListView = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow); //Article 목록, 요청 페이지 번호, 전체 페이지 개수, 시작 행, 끝 행을 이용해서  ArticleListModel 객체를 생성한 뒤 리턴한다.
			
			return articleListView;
		} catch (SQLException e) {
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(),e);
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
			int totalKeywordArticleCount = articleDao.selectKeywordCount(conn,n,keyword); // 전체 게시글 개수 구함
			
			if(totalKeywordArticleCount == 0) { //전체 게시글이 0개인 경우 기본 ArticleListModel 객체를 리턴한다.
				return new ArticleListModel();
			}
			
			int totalPageCount = calculateTotalPageCount(totalKeywordArticleCount); //calculateTotalPageCount()메서드를 호출해서 전체 페이지 개수를 구한다. 
			System.out.println(totalPageCount);
			int firstRow = (requestPageNumber -1) * COUNT_PER_PAGE +1;
			int endRow = firstRow + COUNT_PER_PAGE -1;
	
			if(endRow > totalKeywordArticleCount) {
				endRow = totalKeywordArticleCount;
			}
			
			List<Article> articleList = articleDao.selectKeyword(conn, firstRow, endRow, n, keyword); // ArticleDao.select() 메서드를 이용해서 읽어올 행의 시작 번호와 끝 번호에 속하는 Article 목록을 구한다.
			
			ArticleListModel articleKeywordListView = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow); //Article 목록, 요청 페이지 번호, 전체 페이지 개수, 시작 행, 끝 행을 이용해서  ArticleListModel 객체를 생성한 뒤 리턴한다.
			
			return articleKeywordListView;
		} catch (SQLException e) {
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(),e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

	private int calculateTotalPageCount(int totalArticleCount) { //전체 게시글 개수로부터 전체 페이지 개수를 구해 주는 메서드
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
