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
set�±״� ������ �����Ҷ� ����Ѵ�. �׸��� �⺻��ü�� ������ �Ӽ����������Ѵ�.
<c:set var="member" value="<%= member %>" scope="request"/>
<c:set target="${member}" property="name" value="�ֹ���" />

Member member = new Member();
member.setName("�ֹ���");
pageContext.setAttribute("member", member);

${member.name}
Member member=(Member)pageContext.getAttribute("member");
member.getName();
 --%>
<c:set var = "member" value = "<%=member %>" scope="page" />
<c:set target ="${member }" property ="name" value ="aspirins" />
<c:set var = "pref" value = "<%= pref %>" />
<c:set var = "favoriateColor" value = "#{pref.color }"/>
ȸ�� �̸� : ${member.name },
�����ϴ� �� : ${favoriateColor }
<br />
<c:set target = "${pref }" property ="color" value = "red" />
���� ���� �����ϴ� �� : ${favoriateColor }
</body>
</html>