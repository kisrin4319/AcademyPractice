<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
    
    
    
    
<%
	request.setCharacterEncoding("euc-kr");
	
	String memberID	= 	request.getParameter("memberID");
	String password	=	request.getParameter("password");
	String name		=	request.getParameter("name");
	String email	=	request.getParameter("email");
	
	/* Class.forName("oracle.jdbc.driver.OracleDriver"); */
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcDriver	=	"jdbc:oracle:thin:@localhost:1521:orcl";
		String dbUser		=	"scott";
		String dbPass		=	"tiger";
		
		conn	=	DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
		pstmt	=	conn.prepareStatement("insert into MEMBER values(?,?,?,?)");
		pstmt.setString(1,memberID);
		pstmt.setString(2,password);
		pstmt.setString(3, name);
		pstmt.setString(4,email);
		pstmt.executeUpdate();
	} finally{
		if(pstmt!=null) try{pstmt.close();} catch(SQLException ex){}
		if(conn!=null)	try{pstmt.close();} catch(SQLException ex){}
	}

%>  
<html>
<head>
<title>����</title>
</head>
<body>
MEMBER ���̺� ���ο� ���ڵ带 �����߽��ϴ�.
</body>
</html>