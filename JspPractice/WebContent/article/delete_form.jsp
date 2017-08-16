<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head><title>삭제하기</title></head>
<body>

<form action="<c:url value ='./delete.jsp'/>" method="post">
	<input type="hidden" name = "articleId" value ="${param.articleId }" />
	글암호 : <input type="password" name ="password" /> <br/>
	<input type="submit" value ="삭제" />
</form>
</body>
</html>