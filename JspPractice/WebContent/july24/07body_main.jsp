<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>


<html>
<head>
<title>INFO</title>
</head>
<body>

include 전 name 파라미터 값 : <%= request.getParameter("name") %>

<hr>

<jsp:include page="08body_sub.jsp" flush="false">
	<jsp:param value="최범균" name="name"/>
</jsp:include>

</hr>

include 후 name 파라미터 값: <%= request.getParameter("name") %>

</body>
</html>