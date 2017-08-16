<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="web.article.service.DeleteArticleService"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="deleteRequest" class ="web.article.model.DeleteRequest" />
<jsp:setProperty property="*" name="deleteRequest"/>
<%
	String viewPage = null;
	try{
		DeleteArticleService.getInstance().deleteArticle(deleteRequest);
		viewPage  = "./delete_success.jsp";
	} catch(Exception ex){
		request.setAttribute("deleteException", ex);
		viewPage = "./delete_error.jsp";
	}	
%>
<jsp:forward page="<%=viewPage %>" />