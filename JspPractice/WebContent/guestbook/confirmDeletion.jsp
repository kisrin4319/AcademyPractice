<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ۻ���</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
</head>
<body>
<div id="wrap">
	<form action="deleteMessage.jsp" method="post">
	<input type="hidden" name = "messageId" value ="<%=request.getParameter("messageId") %>" />
		<div class ="delForm">
			<p> ��ȣ�� �Է��ϼ���:</p>
			<dl>
				<dt>��й�ȣ</dt>
				<dd><input type="password" name = "password" /></dd>
			</dl>
		</div>
		<div id = "footer" class ="deleteBtn">
			<input type="submit" value = "�޽��� �����ϱ�" />
		</div>
	</form>
</div>
</body>
</html>