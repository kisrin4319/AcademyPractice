<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<jsp:forward page="./template/template.jsp">
	<jsp:param value="../read_view.jsp" name="CONTENTPAGE"/>
</jsp:forward>