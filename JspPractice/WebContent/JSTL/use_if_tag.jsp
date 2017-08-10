<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title>if 태그</title>
</head>
<body>
<c:if test="true">
무조건 수행<br>
</c:if>

<c:if test="${param.name=='aspirins'}">
name 파라미터의 값이 ${param.name } 입니다.<br>
</c:if>

<c:if test="${18<param.age }">
당신의 나이는 18세 이상입니다.
</c:if>
</body>
</html>