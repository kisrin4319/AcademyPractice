<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>�����ϱ�</title>
</head>
<body>

<form action="update.jsp" method ="post">
	<input type="hidden" name = "articleId" value="${article.id }" />
	<input type="hidden" name = "p" value = "${param.p }" />
	���� : <input type="text" name = "title" size ="20" value="${article.title }" /> <br />
	�۾�ȣ : <input type="password" name ="password" /> <br />
	�۳��� : <br />
	<textarea rows="5" cols="40" name ="content">${article.content }</textarea>
	<br/>
	<input type="submit" value="����" />
</form>
</body>
</html>