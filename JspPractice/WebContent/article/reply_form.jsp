<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>�亯����</title>
</head>
<body>

	<form action="reply.jsp" method="post">
		<input type="hidden" name = "parentArticleId" value="${param.parentId }" />
		<input type="hidden" name = "p" value="${param.p }" />
		����: <input type="text" name ="title" size = "20" value ="re:" /> <br />
		�ۼ��� : <input type="text" name ="writerName" /> <br />
		�۾�ȣ : <input type="password" name = "password" /> <br />
		�۳��� : <br />
		<textarea name="content" rows="5" cols="40"></textarea>
		<br />
		<input type="submit" value="����" />
	</form>
</body>
</html>