<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>로그인 기능 구현 해보기</title>
</head>
<body>
	<%
	String userID = (String)session.getAttribute("id");
	
	if(userID == null){
		%>

	<form action="tloginForm.jsp" method="post">
		<tr>
		<td>아이디 : <input type="text" name="id" maxlength="10" /></td>
		<td>비밀번호 : <input type="password" name="passwd" maxlength="10" /></td>
		</tr>
		<br />
		<tr>
		<input type="submit" value="Login" />
		<input type="reset" value="clear" />
		</tr>
	</form>
	<%	
	}
	
%>
</body>
</html>