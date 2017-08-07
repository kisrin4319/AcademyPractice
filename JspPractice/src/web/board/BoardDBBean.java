package web.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDBBean {

	private static BoardDBBean instance = new BoardDBBean();
	
	public static BoardDBBean getInstance(){
		return instance;
	}
	private BoardDBBean() {}
	
	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	public void insertArticle(BoardDataBean article) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		
		int number =0;
		System.out.println("넘어온 num값 :"+num);
		System.out.println("넘어온 ref값 :"+ref);
		System.out.println("넘어온 re_step값 :"+re_step);
		System.out.println("넘어온 re_level값 :"+re_level);
		
		
		try {
			conn = getConnection();
			String query = "select max(num) from board";
			pstmt = conn.prepareStatement(query);
			rs  = pstmt.executeQuery();
			
			if(rs.next()) {
				number = rs.getInt(1)+1;
			System.out.println("넘어온 number 값:"+number);
			}
			else {
				number=1;
			}
			if(num!=0) {
				query= "update board set re_step=re_step+1 where ref =? and re_step> ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;		
			} else {
				ref = number;
				re_step = 0;
				re_level =0;
			}
			
			query = "insert into board(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) values(board_num.nextval,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
		}  finally {
			if(rs!=null) try {rs.close();} catch(SQLException e) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException e) {}
			if(conn!=null) try {conn.close();} catch(SQLException e) {}
			}
	}
	
	//페이징을 위해서 전체 DB에 입력된 행의 수가 필요함
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String query = "select count(*) from board";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1); //페이지의 갯수 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch(SQLException e) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException e) {}
			if(conn!=null) try {conn.close();} catch(SQLException e) {}
		}
		return 0;
	}
	 public int getArticleCount(int n,String searchKeyword) throws Exception {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      System.out.println("n ="+n);
	      System.out.println(searchKeyword);
	      String[] col_name = {"writer","subject","content"};
	      try {
	         conn = getConnection();
	        
	            String query = "select count(*) from board where " +col_name[n]+" like '%"+searchKeyword+"%'";
	   
	            //pstmt.setString(1, "%"+searchKeyword+"%");
	            pstmt = conn.prepareStatement(query);
	         
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            return rs.getInt(1); //페이지의 갯수 반환
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         if(rs!=null) try {rs.close();} catch(SQLException e) {}
	         if(pstmt!=null) try {pstmt.close();} catch(SQLException e) {}
	         if(conn!=null) try {conn.close();} catch(SQLException e) {}
	      }
	      return 0;
	   }

	
	public BoardDataBean getArticle(int num) throws Exception {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 BoardDataBean article = null;
		 
		 try {
			 conn = getConnection();
			 String query = "update board set readcount=readcount+1 where num = ?";
			 pstmt = conn.prepareStatement(query);
			 pstmt.setInt(1, num);
			 pstmt.executeUpdate();
			 
			 query = "select * from board where num =?";
			 pstmt = conn.prepareStatement(query);
			 pstmt.setInt(1, num);
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 article = new BoardDataBean();
				 article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
			 }
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			if (rs != null)	try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)	try {pstmt.close();	} catch (SQLException ex) {}
			if (conn != null)	try {conn.close();	} catch (SQLException ex) {}

		}
		 return article;
	}
	
	
	public List<BoardDataBean> getArticles(int start, int end) throws Exception {
	 Connection conn = null;
	 PreparedStatement pstmt = null;
	 ResultSet rs = null;
	 List<BoardDataBean> articleList = null;
	 
	 try {
		conn = getConnection();
		
		pstmt=conn.prepareStatement("select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "+
									"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "+
									"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount "+
									"from board order by ref desc, re_step asc) order by ref desc,re_step asc) where r>= ? and r<=? ");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				articleList = new ArrayList<BoardDataBean>(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));

					articleList.add(article);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)	try {pstmt.close();	} catch (SQLException ex) {}
			if (conn != null)	try {conn.close();	} catch (SQLException ex) {}
		}
	 return articleList;
	}
	
	public List<BoardDataBean> getArticles(int start,int end,int n, String searchKeyword) throws Exception {
	       Connection conn = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       List<BoardDataBean> articleList = null;
	       System.out.println(n);
	       String[] col_name = {"writer","subject","content"};
	       try {
	         conn = getConnection();
	         String query = "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "	
						+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
						+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount "
						+ "from board order by ref desc, re_step asc) where "+col_name[n]+" like '%"+searchKeyword+"%' order by ref desc, re_step asc ) where r >= ? and r <= ?";
	       
	         pstmt = conn.prepareStatement(query);
	        
	         /* pstmt=conn.prepareStatement("select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "+
	                              "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "+
	                              "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount "+
	                              "from board order by ref desc, re_step asc) where "+col_name[n]+"like '%"+searchKeyword+"%' order by ref desc,re_step asc) where r>= ? and r<=? ");
	           */
	         
	         
	         pstmt.setInt(1, start);
	            pstmt.setInt(2, end);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	               articleList = new ArrayList<BoardDataBean>(end);
	               do {
	                  BoardDataBean article = new BoardDataBean();
	                  article.setNum(rs.getInt("num"));
	                  article.setWriter(rs.getString("writer"));
	                  article.setEmail(rs.getString("email"));
	                  article.setSubject(rs.getString("subject"));
	                  article.setPasswd(rs.getString("passwd"));
	                  article.setReg_date(rs.getTimestamp("reg_date"));
	                  article.setReadcount(rs.getInt("readcount"));
	                  article.setRef(rs.getInt("ref"));
	                  article.setRe_step(rs.getInt("re_step"));
	                  article.setRe_level(rs.getInt("re_level"));
	                  article.setContent(rs.getString("content"));
	                  article.setIp(rs.getString("ip"));

	                  articleList.add(article);
	               } while (rs.next());
	            }
	         } catch (Exception ex) {
	            ex.printStackTrace();
	         } finally {
	            if (rs != null)   try {rs.close();} catch (SQLException ex) {}
	            if (pstmt != null)   try {pstmt.close();   } catch (SQLException ex) {}
	            if (conn != null)   try {conn.close();   } catch (SQLException ex) {}
	         }
	       return articleList;
	   }

	
	
	public BoardDataBean updateGetArticle(int num) throws Exception {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 BoardDataBean article = null;
		 
		 try {
			conn = getConnection();
			String query = "select * from board where num =?";
			pstmt= conn.prepareStatement(query);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)	try {pstmt.close();	} catch (SQLException ex) {}
			if (conn != null)	try {conn.close();	} catch (SQLException ex) {}
		}
		 return article;
	}
	public int updateArticle(BoardDataBean article) throws Exception {
		 Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 
		 String dbpasswd ="";
		
		 
		 try {
			 conn = getConnection();
			 String query = "select passwd from board where num = ?";
			 pstmt = conn.prepareStatement(query);
			 pstmt.setInt(1, article.getNum());
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 dbpasswd = rs.getString("passwd");
				 if(dbpasswd.equals(article.getPasswd())) {
					 query = "update board set writer=?,email=?,subject=?,passwd=?,content=? where num=?";
					 pstmt = conn.prepareStatement(query);
					 pstmt.setString(1, article.getWriter());
					 pstmt.setString(2, article.getEmail());
					 pstmt.setString(3, article.getSubject());
					 pstmt.setString(4, article.getPasswd());
					 pstmt.setString(5, article.getContent());
					 pstmt.setInt(6, article.getNum());
					 pstmt.executeUpdate();
				return 1;
				 } else {
					 return 0;
				 }
			 }
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			if (rs != null)	try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)	try {pstmt.close();	} catch (SQLException ex) {}
			if (conn != null)	try {conn.close();	} catch (SQLException ex) {}
		}
		 return -1;
	}
	
	public int deleteArticle(int num, String passwd) throws Exception {
		Connection conn = null;
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 String dbpasswd ="";

		 try {
			conn = getConnection(); 
			String query ="select passwd from board where num =?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					query = "delete from board where num=?";
					pstmt = conn.prepareStatement(query);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					return 1;
				}
			} else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)	try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)	try {pstmt.close();	} catch (SQLException ex) {}
			if (conn != null)	try {conn.close();	} catch (SQLException ex) {}
		}
	return -1;
	}
}