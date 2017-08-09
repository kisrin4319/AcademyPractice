<%@page import="web.service.InvalidMessagePassowrdException"%>
<%@page import="web.service.DeleteMessageService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page errorPage="errorView.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int messageId = Integer.parseInt(request.getParameter("messageId"));
	String password = request.getParameter("password");
	boolean invalidPassword = false;
	
	try{
		DeleteMessageService deleteService = DeleteMessageService.getInstance();
		deleteService.deleteMessage(messageId, password);
	} catch(InvalidMessagePassowrdException e){
		invalidPassword = true;
	}
%>

<html>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>방명록 메시지 삭제함</title>
</head>
<body>
<% if(!invalidPassword){ %>
메시지를 삭제하였습니다.
<% } else {%>
입력한 암호가 올바르지 않습니다. 암호를 확인해주세요.
<%} %>
<br/>
<a href="list.jsp">[목록 보기]</a>
</body>
</html>