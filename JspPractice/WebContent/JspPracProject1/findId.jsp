<%@page import="web.logon.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>���̵� ã��</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<% request.setCharacterEncoding("euc-kr"); %>

<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	LogonDBBean manager = LogonDBBean.getInstance();
	LogonDataBean c = manager.findId(name,email);
	
	try
	{
%>
<body>
<center>
<form action="main.jsp" method="post">
<%
	if(c!=null)
	{
%>
	<%=name %>���� ���̵�� <b><%=c.getId() %></b>�Դϴ�.<p>
<%
	}
	else
	{
%>
	�̸� �Ǵ� �̸����� �߸��Ǿ����ϴ�.
	<input type="button" value = "reset" onclick="javascript:window.location='findIdForm.jsp'" />
<%
	}
%>	
</form>
</center>
</body>
<%

	}catch(Exception e) {}
%>
</html>