<%@ page import = "java.net.URLEncoder" %>
<%@ page pageEncoding="euc-kr" %>
<%
	String value = "�ڹ�";
	String encodedValue = URLEncoder.encode(value, "UTF-8");
	response.sendRedirect("./login.jsp?memberId=" + encodedValue);
%>
