<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "practice.member.MemberInfo" %>

<jsp:useBean id="member" scope = "request" class = "practice.member.MemberInfo"/>

<%

	member.setId("Aspirins");
	member.setName("�ƽ��Ǹ�");
%>
<jsp:forward page="./useObject.jsp"/>