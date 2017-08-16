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
<title>게시글 작성</title>
</head>
<body>
게시글을 등록했습니다.
<br />
<a href="<c:url value ='./list.jsp'/>">목록보기</a>
<a href="<c:url value ='./read.jsp?articleId=${postedArticle.id }'/>">게시글 읽기</a>
</body>
</html>