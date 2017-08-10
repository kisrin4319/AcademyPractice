<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<fmt:setBundle var = "message" basename="resource.message" />
<<fmt:message bundle="${message }" key="TITLE" var="title" />
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head><title>${title }</title></head>
<body>

<fmt:message bundle="${message }" key="GREETING" />
<br>
<c:if test="${!empty param.id }">
<fmt:message bundle="${message }" key ="VISITOR">
	<fmt:param value ="${param.id }" />
</fmt:message>
</c:if>
</body>
</html>