<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "practice.member.MemberInfo" %>

<jsp:useBean id="member" scope = "request" class = "practice.member.MemberInfo"/>

<%

	member.setId("Aspirins");
	member.setName("아스피린");
%>
<jsp:forward page="./useObject.jsp"/>