package web.logon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class LogonDBBean {

	//SingleTon Pattern
	private static LogonDBBean instance = new LogonDBBean();
	
	public static LogonDBBean getInstance() {
		return instance;
	}
	
	private LogonDBBean() {}
	
	private Connection getConnection() throws Exception{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	
	//inputPro.jsp ���� ȸ�������� �� �� ���
	public void insertMember(LogonDataBean member) throws Exception{
		Connection conn= null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("insert into members(id,passwd,name,jumin1,jumin2,email,blog,reg_date,zipcode,address) values (?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getJumin1());
			pstmt.setString(5, member.getJumin2());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
			pstmt.setString(9, member.getZipcode());
			pstmt.setString(10, member.getAddress());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn!=null) try {conn.close();}	 catch(SQLException ex) {}
		} 
	}
	//LoginPro.jsp ���� �α����� �õ� �Ҵ� ȣ��
	public int userCheck(String id,String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		try {
			conn =  getConnection();
			pstmt = conn.prepareStatement("select passwd from MEMBERS where id =? ");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd))
					return 1; //���� ����
				else
					return 0; // ��й�ȣ Ʋ��
			}
			else
				return -1; //�ش� ���̵� ����
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs != null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn != null) try {conn.close();} catch(SQLException ex) {}
		}
		return -1;
	}
	// ConfirmId.jsp ���� ID�� üũ �Ҷ� ���
	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select id from MEMBERS where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				return 1; //�ش� ���̵� ����
			else
				return -1; //�ش� ���̵� ����
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();}catch(SQLException ex) {}
			if(conn!=null) try {conn.close();} catch(SQLException ex) {}
	}
		return -1;
	}
	
	public LogonDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from MEMBERS where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new  LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs!=null)	try {rs.close();}	 catch(SQLException ex) {}
			if(pstmt!=null)	try {pstmt.close();} catch(SQLException ex) {}
			if(conn!=null)	try {conn.close();}	 catch(SQLException ex) {}
		}
		return member;
	}
	
	public void updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("update MEMBERS set passwd=?,name=?,email=?,blog=?,zipcode=?,address=? where id=?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBlog());			
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getId());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(pstmt!= null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn!=null) try {conn.close();} catch(SQLException ex) {}
		}
	}
	
	public int deleteMember(String id, String passwd) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		String dbpasswd = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from MEMBERS where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from MEMBERS where id =?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					return 1; //ȸ�� Ż�� ����
				} else {
					return 0; //��й�ȣ Ʋ��
				}
			} 
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs!= null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn!= null) try {conn.close();} catch(SQLException ex) {}
		}
		return -1;
	}
	public ArrayList<ZipcodeBean> zipcodeRead(String area3) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ZipcodeBean> zipList = new ArrayList<ZipcodeBean>();
		
		try {
			conn = getConnection();
			//pstmt = conn.prepareStatement("select * from zipcode where area3 like '"+area3+"%'");
			pstmt = conn.prepareStatement("select * from zipcode where area3 like ?");
			pstmt.setString(1,area3+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ZipcodeBean tempZipcode = new ZipcodeBean();
				tempZipcode.setZipcode(rs.getString("zipcode"));
				tempZipcode.setArea1(rs.getString("area1"));
				tempZipcode.setArea2(rs.getString("area2"));
				tempZipcode.setArea3(rs.getString("area3"));
				tempZipcode.setArea4(rs.getString("area4"));
				zipList.add(tempZipcode);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch(SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch(SQLException ex) {}
			if(conn!=null) try {conn.close();} catch(SQLException ex) {}
		}
		return zipList;
	}
	public LogonDataBean findId(String name,String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member = null;
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select id from MEMBERS where name=? and email = ?");
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs!=null)	try {rs.close();}	 catch(SQLException ex) {}
			if(pstmt!=null)	try {pstmt.close();} catch(SQLException ex) {}
			if(conn!=null)	try {conn.close();}	 catch(SQLException ex) {}
		}
		return member;
	}
	
	public LogonDataBean findPw(String id,String name,String email) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member = null;
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement("select * from MEMBERS where id=? and name=? and email = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if(rs!=null)	try {rs.close();}	 catch(SQLException ex) {}
			if(pstmt!=null)	try {pstmt.close();} catch(SQLException ex) {}
			if(conn!=null)	try {conn.close();}	 catch(SQLException ex) {}
		}
		return member;
	}
}
