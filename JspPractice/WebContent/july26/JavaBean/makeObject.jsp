<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "KH.member.MemberInfo" %>

<jsp:useBean id="member" scope = "request" class = "KH.member.MemberInfo"/>

<%

	member.setId("Aspirins");
	member.setName("아스피린");
%>
<jsp:forward page="./useObject.jsp"/>