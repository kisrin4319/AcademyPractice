<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import ="web.logon.LogonDBBean"%>

<% request.setCharacterEncoding("euc-kr");%>

<jsp:useBean id="member" class ="web.logon.LogonDataBean">
	<jsp:setProperty name ="member" property="*"/>
</jsp:useBean>

<%
	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	LogonDBBean manager = LogonDBBean.getInstance();
	manager.insertMember(member);
	response.sendRedirect("loginForm.jsp");
%>