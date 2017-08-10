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
<c:if test="${param.dest == '1' }">
	<c:redirect url="/use_c_set.jsp" />
</c:if>
<c:if test="${param.dest == '2' }">
	<c:redirect url="use_c_set.jsp" />
</c:if>
<c:if test="${param.dest == '3' }">
	<c:redirect url="/el/viewToday.jsp" context="/KH" />
</c:if>
<c:if test="${param.dest == '4' }">
	<c:redirect url="http://www.youtube.com/results" >
		<c:param name="search_query" value="ryu" />
	</c:redirect>
</c:if>
</body>
</html>