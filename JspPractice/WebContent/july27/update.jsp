<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	String USERID = request.getParameter("userID");
	String USERNAME = request.getParameter("name");

	int updateCount = 0;

	Class.forName("oracle.jdbc.driver.OracleDriver");

	Connection conn = null;
	Statement stmt = null;

	try {
		String jdbcDriver = "jdbc:oracle:thin:@Localhost:1521:orcl";
		String dbUser = "scott";
		String dbPass = "tiger";

		String query = "update MEMBER set USERNAME = '" + USERNAME + "' where USERID = '" + USERID + "'";

		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

		stmt = conn.createStatement();
		updateCount = stmt.executeUpdate(query);
	} finally {
		if (stmt != null)
			try {
				stmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>이름 변경</title>
</head>
<body>
	<%
		if (updateCount > 0) {
	%>
	<%=USERID%>의 이름을
	<%=USERNAME%>(으)로 변경
	<%
		} else {
	%>
	<%=USERID%>
	아이디가 존재하지 않음
	<%
		}
	%>
</body>
</html>