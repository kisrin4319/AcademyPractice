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
<title>JSTL sql ���� - query</title>
</head>
<body>
<sql:query var="rs" dataSource="jdbc:apache:commons:dbcp:/pool">
	select * from member
</sql:query>

<table border="1">
	<tr><%--�ʵ��    ��� --%>
		<c:forEach var="columnName" items="${rs.columnNames }">
			<th><c:out value="${columnName }"/></th>
		</c:forEach>
	</tr>
	<c:forEach var ="row" items="${rs.rowsByIndex }"><%-- ���ڵ��� �� ��ŭ �ݺ��Ѵ�. --%>
	<tr>
		<c:forEach var ="column" items="${row }" varStatus="i"><%-- ���ڵ��� �ʵ� �� ��ŭ �ݺ��Ѵ�. --%>
		<td>
			<c:if test="${column!=null }"><%-- �ش� �ʵ尪�� null�� �ƴϸ� --%>
				<c:out value="${column }" />
			</c:if> <%-- �ش� �ʵ尪�� null�̸� --%>
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