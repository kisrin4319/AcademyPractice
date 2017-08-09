<%@page import="web.service.*"%>
<%@ page import ="web.model.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page errorPage="errorview.jsp" %>


<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="message" class = "web.model.Message">
	<jsp:setProperty name = "message" property="*" />
</jsp:useBean>

<%
	WriteMessageService writeService = WriteMessageService.getInstance();
	writeService.write(message);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>방명록 메시지 남김</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
</head>
<body>
<div id = "wrap">
	<div id = "content">
		<div class ="delForm">
		<p>방명록에 메시지를 남겼습니다.</p>
	<span class="delBtn"><input type = "button" value="목록" onclick= "javascript:window.location='list.jsp'"></span>
		</div>
	</div>
</div>
</body>
</html>