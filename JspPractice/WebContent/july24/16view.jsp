<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	String code = request.getParameter("code");
	String viewPageURI = null;
	
	if (code.equals("A")) {
		viewPageURI = "/july24/viewModule/a.jsp";
	} else if (code.equals("B")) {
		viewPageURI = "/july24/viewModule/b.jsp";
	} else if (code.equals("C")) {
		viewPageURI = "/july24/viewModule/c.jsp";
	}
%>
<jsp:forward page="<%= viewPageURI %>"/>