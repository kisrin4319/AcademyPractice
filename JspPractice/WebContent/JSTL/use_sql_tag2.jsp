<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title>JSTL sql 예제 - update,param</title>
</head>
<body>
<sql:update dataSource="jdbc:apache:commons:dbcp:/pool">
	update member set password=? where memberid=?
		<sql:param value="${3456 }" />
		<sql:param value="${'SS' }"/>
</sql:update>>

<table border="1">
	<tr><%--필드명    출력 --%>
		<c:forEach var="columnName" items="${rs.columnNames }">
			<th><c:out value="${columnName }"/></th>
		</c:forEach>
	</tr>
	<c:forEach var ="row" items="${rs.rowsByIndex }"><%-- 레코드의 수 만큼 반복한다. --%>
	<tr>
		<c:forEach var ="column" items="${row }" varStatus="i"><%-- 레코드의 필드 수 만큼 반복한다. --%>
		<td>
			<c:if test="${column!=null }"><%-- 해당 필드값이 null이 아니면 --%>
				<c:out value="${column }" />
			</c:if> <%-- 해당 필드값이 null이면 --%>
			<c:if test="${column==null }">
				&nbsp;
			</c:if>
		</td>
		</c:forEach>
	</tr>
	</c:forEach>
</table>
</body>
</html>