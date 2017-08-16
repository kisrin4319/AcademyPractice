<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="web.article.service.ReplyArticleService"%>
<%@page import="web.article.model.Article"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<% request.setCharacterEncoding("euc-kr");%>
<jsp:useBean id="replyingRequest" class = "web.article.model.ReplyingRequest" />
<jsp:setProperty property="*" name="replyingRequest"/>
<%
	String viewPage = null;
	try{
		Article postedArticle = ReplyArticleService.getInstance().reply(replyingRequest);
		request.setAttribute("postedArticle", postedArticle);
		viewPage = "./reply_success.jsp";
	} catch(Exception ex){
		viewPage = "./reply_error.jsp";
		request.setAttribute("replyException", ex);
	}

%>
<jsp:forward page="<%=viewPage %>" />
<body>

</body>
</html>