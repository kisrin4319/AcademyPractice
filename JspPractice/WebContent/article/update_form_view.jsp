<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>수정하기</title>
</head>
<body>

<form action="update.jsp" method ="post">
	<input type="hidden" name = "articleId" value="${article.id }" />
	<input type="hidden" name = "p" value = "${param.p }" />
	제목 : <input type="text" name = "title" size ="20" value="${article.title }" /> <br />
	글암호 : <input type="password" name ="password" /> <br />
	글내용 : <br />
	<textarea rows="5" cols="40" name ="content">${article.content }</textarea>
	<br/>
	<input type="submit" value="수정" />
</form>
</body>
</html>