<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="web.article.service.ArticleNotFoundException"%>
<%@page import="web.article.service.ReadArticleService"%>
<%@page import="web.article.model.Article"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<%
	String viewPage = null;
	try {
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		Article article = ReadArticleService.getInstance().getArticle(articleId);
		viewPage = "./update_form_view.jsp";
		request.setAttribute("article", article);
	} catch(ArticleNotFoundException ex){
		viewPage = "./article_not_found.jsp";
	}
%>
<jsp:forward page="<%= viewPage %>" />
<body>

</body>
</html>