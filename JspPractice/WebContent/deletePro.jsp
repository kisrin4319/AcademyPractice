<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="web.logon.*" %>
<%@ include file = "../view/color.jsp" %>
<html>
<head>
<title>회원 탈퇴</title>
<link href="style.css" rel = "stylesheet" type="text/css">
</head>
<%
	String id = (String)session.getAttribute("memId");
	String passwd = request.getParameter("passwd");
	
	LogonDBBean manager = LogonDBBean.getInstance();
	int check = manager.deleteMember(id, passwd);
	
	if(check==1){
		session.invalidate();
%>
<body bgcolor="<%=bodyback_c %>">
	<form action="main.jsp" name = "userinput" method="post">
		<table width="270" border="0" cellspacing ="0" cellpadding="5" align="center">
			<tr bgcolor="<%=title_c %>">
				<td height="39" align="center">
				<font size="+1"><b>회원정보가 삭제되었습니다.</b></font>
				</td>
			</tr>
			<tr bgcolor="<%=value_c %>">
				<td align="center">
					<input type="submit" value="확인">
				</td>
			</tr>
		</table>
	</form>
	<%} else { %>
	<script>	
	alert("비밀번호가 맞지 않습니다.");
		history.go(-1);	
	</script>
	
	<%} %>
</body>
</html>