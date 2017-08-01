<%@page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="web.logon.LogonDBBean"%>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="member" class ="web.logon.LogonDataBean">
	<jsp:setProperty name ="member" property="*"/>
</jsp:useBean>

<%
	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	LogonDBBean manager = LogonDBBean.getInstance();
	manager.insertMember(member);
	response.sendRedirect("loginForm.jsp");
%>