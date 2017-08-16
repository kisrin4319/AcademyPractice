<?xml version="1.0" encoding="EUC-KR" ?>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title>dateFormat태그 사용</title></head>
<body>

<c:set var ="now" value="<%=new Date() %>" />
<fmt:formatDate value="${now }" type="date" dateStyle="full" /> <br>
<fmt:formatDate value="${now }" type="date" dateStyle="short" /> <br>
<fmt:formatDate value="${now }" type="date" dateStyle="full" /> <br>
<fmt:formatDate value="${now }" type="time" /> <br>
<fmt:formatDate value="${now }" type="both" dateStyle="full" timeStyle="full" /> <br>
<fmt:formatDate value="${now }" pattern="z a h: mm" /> <br>
</body>
</html>
