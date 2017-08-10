<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글삭제</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
</head>
<body>
<div id="wrap">
	<form action="deleteMessage.jsp" method="post">
	<input type="hidden" name = "messageId" value ="<%=request.getParameter("messageId") %>" />
		<div class ="delForm">
			<p> 암호를 입력하세요:</p>
			<dl>
				<dt>비밀번호</dt>
				<dd><input type="password" name = "password" /></dd>
			</dl>
		</div>
		<div id = "footer" class ="deleteBtn">
			<input type="submit" value = "메시지 삭제하기" />
		</div>
	</form>
</div>
</body>
</html>