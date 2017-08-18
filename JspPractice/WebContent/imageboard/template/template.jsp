<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page errorPage="../error/error_view.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>테마 갤러리</title>
<style>
A {color: blue; font-weight: bold; text-decoration: none}
A:hover {
	color: blue; font-weight: bold; text-decoration: underline
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
</head>
<body>

<table width="100%" border="1" cellpadding="2" cellspacing="0">
	<tr>
		<td>
			<jsp:include page="../module/top.jsp" flush="false" />
		</td>
	</tr>
	<tr>
		<td>
			<!--  내용 부분 : 시작 -->
			<jsp:include page="${param.CONTENTPAGE }" flush="false" />
			<!--  내용 부분: 끝 -->
		</td>
	</tr>
	<tr>
		<td>
			<jsp:include page="../module/bottom.jsp" flush="false" />
		</td>
	</tr>
</table>
</body>
</html>