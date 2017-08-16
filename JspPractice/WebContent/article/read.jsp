<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="web.article.service.ArticleNotFoundException"%>
<%@page import="web.article.service.ReadArticleService"%>
<%@page import="web.article.model.Article"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<%
	int articleId = Integer.parseInt(request.getParameter("articleId"));
	String viewPage = null;
	try{
		Article article = ReadArticleService.getInstance().readArticle(articleId);
		request.setAttribute("article", article);
		viewPage = "./read_view.jsp";
	} catch(ArticleNotFoundException ex){
		viewPage = "./article_not_found.jsp";
	}
%>
<jsp:forward page = "<%=viewPage %>" />