<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<c:set var ="exceptionType" value ="${deleteException.getClass().simpleName }" />
<head><title>���� ����</title></head>
<body>
����:
<c:choose>
	<c:when test="${exceptionType =='ArticleNotFoundException' }">
	������ �Խñ��� �������� �ʽ��ϴ�.
	</c:when>
	<c:when test="${exceptionType == 'InvalidPasswordException' }">
		��ȣ�� �߸� �Է��ϼ̽��ϴ�.
	</c:when>
</c:choose>
<br />
<a href="./list.jsp">��Ϻ���</a>
</body>
</html>