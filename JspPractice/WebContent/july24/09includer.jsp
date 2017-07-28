<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<title>include 디렉티브</title>
</head>
<body>

<%
	int number = 10;
%>
<%@ include file= "./10includee.jspf" %>

공통변수 DATAFOLDER = "<%= dataFolder %>"
</body>
</html>