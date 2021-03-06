<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var ="exceptionType" value ="${updateException.getClass().simpleName }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>수정 실패</title>
</head>
<body>
에러:
<c:choose>
	<c:when test="${exceptionType == 'ArticleNotFoundException'}">
	수정할 게시글이 존재하지 않습니다.	
	</c:when>
	<c:when test="${exceptionType == 'InvalidPasswordException'}">
	암호를 잘못 입력하셨습니다.
	</c:when>
</c:choose>
<br />
<a href="./list.jsp?p=${param.p }">목록보기</a>
</body>
</html>