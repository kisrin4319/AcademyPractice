<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title></title>
</head>
<body>
<c:url value ="http://search.daum.net/search" var ="searchUrl">
	<c:param name="w" value = "blog" />
	<c:param name="q" value = "박지성" />
</c:url>
<ul>
	<li>${searchUrl }</li>
	<li><c:url value = "/use_if_tag.jsp" /></li>
	<li><c:url value = "./use_if_tag.jsp"/></li></ul>
</body>
</html>