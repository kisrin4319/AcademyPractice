<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ǥ������� ��뿹��2</title>
</head>
<body>

<h3>ǥ�����(EL)�� ��뿹��2 - �Ķ���Ͱ� ó��</h3>
<p>

<form action="ELEx2.jsp" method="post">
	�̸� : <input type="text" name = "name" value ="${param.name }">
		 <input type="submit" value = "Ȯ��">
</form>
<p>
�̸��� : ${param.name } �Դϴ�.
</body>
</html>