<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title>catch 태그</title>
</head>
<body>

<c:catch var ="ex">
name 파라미터의 값 = <%=request.getParameter("name") %><br>
<% if(request.getParameter("name").equals("test")) { %>
${param.name }은 test입니다.
<% } %>
</c:catch>
<p>
<c:if test="${ex!=null }">
예외가 발생하였습니다:<br> ${ex }
</c:if>
</body>
</html>