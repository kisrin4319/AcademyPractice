<%@ page contentType="text/html; charset=euc-kr" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:forward page="./template/template.jsp">
	<jsp:param value="../list_view.jsp" name="CONTENTPAGE"/>
</jsp:forward>