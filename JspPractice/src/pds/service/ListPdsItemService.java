package pds.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import pds.dao.PdsItemDao;
import pds.model.PdsItem;
import pds.model.PdsItemListModel;
import web.jdbc.ConnectionProvider;
import web.jdbc.JdbcUtil;

public class ListPdsItemService {

	private static ListPdsItemService instance = new ListPdsItemService();
	
	public static ListPdsItemService getInstacne() {
		return instance;
	}
	private ListPdsItemService() {}
	
	public static final int COUNT_PER_PAGE = 10;
	
	public PdsItemListModel getPdsItemList(int pageNumber) {
		if (pageNumber < 0) {
			throw new IllegalArgumentException("page number < 0 : "
					+ pageNumber);
		}
		PdsItemDao pdsItemDao = PdsItemDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int totalArticleCount = pdsItemDao.selectCount(conn);

			if (totalArticleCount == 0) {
				return new PdsItemListModel();
			}

			int totalPageCount = calculateTotalPageCount(totalArticleCount);

			int firstRow = (pageNumber - 1) * COUNT_PER_PAGE + 1;
			int endRow = firstRow + COUNT_PER_PAGE - 1;

			if (endRow > totalArticleCount) {
				endRow = totalArticleCount;
			}
			List<PdsItem> PdsItemList = pdsItemDao.select(conn, firstRow,
					endRow);

			PdsItemListModel PdsItemListView = new PdsItemListModel(
					PdsItemList, pageNumber, totalPageCount, firstRow, endRow);
			return PdsItemListView;
		} catch (SQLException e) {
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public PdsItemListModel getPdsItemList(int pageNumber, String keyword) {
		if (pageNumber < 0) {
			throw new IllegalArgumentException("page number < 0 : "
					+ pageNumber);
		}
		PdsItemDao pdsItemDao = PdsItemDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			int totalArticleCount = pdsItemDao.selectCount(conn,keyword);

			if (totalArticleCount == 0) {
				return new PdsItemListModel();
			}

			int totalPageCount = calculateTotalPageCount(totalArticleCount);

			int firstRow = (pageNumber - 1) * COUNT_PER_PAGE + 1;
			int endRow = firstRow + COUNT_PER_PAGE - 1;

			if (endRow > totalArticleCount) {
				endRow = totalArticleCount;
			}
			List<PdsItem> PdsItemList = pdsItemDao.select(conn, firstRow,
					endRow,keyword);

			PdsItemListModel PdsItemListView = new PdsItemListModel(
					PdsItemList, pageNumber, totalPageCount, firstRow, endRow);
			return PdsItemListView;
		} catch (SQLException e) {
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(), e);
		} finally {
			JdbcUtil.close(conn);
		}
	}

	private int calculateTotalPageCount(int totalPdsItemCount) {
		if (totalPdsItemCount == 0) {
			return 0;
		}
		int pageCount = totalPdsItemCount / COUNT_PER_PAGE;
		if (totalPdsItemCount % COUNT_PER_PAGE > 0) {
			pageCount++;
		}
		return pageCount;
	}
}
