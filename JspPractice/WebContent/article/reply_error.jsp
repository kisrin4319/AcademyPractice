<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<c:set var ="exceptionType" value ="${replyException.getClass().simpleName }" />
<head>
<title>�亯 ����</title>
</head>
<body>
���� :
<c:choose>
	<c:when test="${exceptionType == 'ArticleNotFoundException' }">
		�亯�� ����� �Խñ��� �������� �ʽ��ϴ�.
	</c:when>
	<c:when test="${exceptionType== 'CannotReplyArticleException' }">
		�亯 ���� ����� �� ���� �Խñ��Դϴ�.
	</c:when>
	<c:when test="${exceptionType == 'LastChildAlreadyExistsException' }">
	����� �� �ִ� �亯 ������ �ʰ��߽��ϴ�.	
	</c:when>
</c:choose>
<br />
<a href="<c:url value ='./list.jsp?p=${param.p }'/>">��Ϻ���</a>
</body>
</html>