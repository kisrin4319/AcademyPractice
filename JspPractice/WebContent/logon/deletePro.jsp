<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="web.logon.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>회원 탈퇴</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="memberWrap">
		<div class="innerDiv">
			<h1>Member secession</h1>
			<%
				String id = (String) request.getParameter("id");
				String passwd = request.getParameter("passwd");

				LogonDBBean manager = LogonDBBean.getInstance();
				int check = manager.deleteMember(id, passwd);

				if (check == 1) {
					String memId = session.getAttribute("memId")
					if(memId.equals(id)){
						session.invalidate();
					}
			%>

			<form action="main.jsp" name="userinput" method="post">
				<p class="desc">회원정보가 삭제되었습니다.</p>
				<div class="btnArea2">
					<input type="submit" value="Ok" class="btn" />
				</div>
			</form>
			<%
				} else {
			%>
			<script type="text/javascript">
				alert("비밀번호가 맞지 않습니다.");
				history.go(-1);
			</script>

			<%
				}
			%>
		</div>
	</div>
</body>
</html>