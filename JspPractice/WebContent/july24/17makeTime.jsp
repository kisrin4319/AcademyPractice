<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.Calendar" %>
<%
	Calendar cal = Calendar.getInstance();
	request.setAttribute("time", cal);
	
	/* response.sendRedirect("../to/viewTime.jsp"); */
%>
<jsp:forward page="../to/18viewTime.jsp" />