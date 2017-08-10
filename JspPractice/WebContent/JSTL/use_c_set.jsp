<%@page import="KH.Member"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
		Member member = new Member();
		HashMap<String,String> pref = new HashMap<String,String>();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
</head>
<body>

<%--
set태그는 변수를 설정할때 사용한다. 그리고 기본객체의 영역에 속성설정까지한다.
<c:set var="member" value="<%= member %>" scope="request"/>
<c:set target="${member}" property="name" value="최범균" />

Member member = new Member();
member.setName("최범균");
pageContext.setAttribute("member", member);

${member.name}
Member member=(Member)pageContext.getAttribute("member");
member.getName();
 --%>
<c:set var = "member" value = "<%=member %>" scope="page" />
<c:set target ="${member }" property ="name" value ="aspirins" />
<c:set var = "pref" value = "<%= pref %>" />
<c:set var = "favoriateColor" value = "#{pref.color }"/>
회원 이름 : ${member.name },
좋아하는 색 : ${favoriateColor }
<br />
<c:set target = "${pref }" property ="color" value = "red" />
설정 이후 좋아하는 색 : ${favoriateColor }
</body>
</html>