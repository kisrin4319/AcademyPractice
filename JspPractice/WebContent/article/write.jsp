<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="web.article.model.Article"%>
<%@page import="web.article.service.WriteArticleService"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="writingRequest" class ="web.article.model.WritingRequest" />
<jsp:setProperty property="*" name="writingRequest"/>
<%
	Article postedArticle = WriteArticleService.getInstance().write(writingRequest);
	request.setAttribute("postedArticle", postedArticle);

%>
<head>
<title>�Խñ� �ۼ�</title>
</head>
<body>
�Խñ��� ����߽��ϴ�.
<br />
<a href="<c:url value ='./list.jsp'/>">��Ϻ���</a>
<a href="<c:url value ='./read.jsp?articleId=${postedArticle.id }'/>">�Խñ� �б�</a>
</body>
</html>