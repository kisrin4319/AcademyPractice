<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>표현언어의 사용예제2</title>
</head>
<body>

<h3>표현언어(EL)의 사용예제2 - 파라미터값 처리</h3>
<p>

<form action="ELEx2.jsp" method="post">
	이름 : <input type="text" name = "name" value ="${param.name }">
		 <input type="submit" value = "확인">
</form>
<p>
이름은 : ${param.name } 입니다.
</body>
</html>