<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="web.article.service.UpdateArticleService"%>
<%@page import="web.article.model.Article"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="updateRequest" class ="web.article.model.UpdateRequest" />
<jsp:setProperty property="*" name="updateRequest" />
<%
	String viewPage = null;
	try{
		Article article = UpdateArticleService.getInstance().update(updateRequest);
		request.setAttribute("updateArticle", article);
		viewPage = "./update_success.jsp";
	} catch(Exception ex){
		request.setAttribute("updateException", ex);
		viewPage ="./update_error.jsp";
	}
%>
<jsp:forward page="<%=viewPage %>" />
