<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>글쓰기</title>
</head>
<body>

	<form action="<c:url value='./write.jsp'/>" method="post">
	제목: <input type="text" name = "title" size = "20" /> <br/>
	작성자: <input type="text" name ="writerName" /> <br />
	글암호 : <input type="password" name ="password" /> <br />
	글내용 : <br />
	<textarea name="content" rows="5" cols="40"></textarea>
	<br />
	<input type="submit" value ="전송" />	
	</form>
</body>
</html>