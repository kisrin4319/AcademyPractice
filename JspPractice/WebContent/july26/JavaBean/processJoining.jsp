<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="memberInfo" class = "practice.member.MemberInfo" scope ="page"/>
<jsp:setProperty property="*" name="memberInfo"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%--
 <%
   String id = request.getParameter("id");
   String name = request.getParameter("name");
   String email = request.getParameter("email");
   String address = request.getParameter("address");
   memberInfo.setId(id);
   memberInfo.setName(name);
   memberInfo.setEmail(email);
   memberInfo.setAddress(address);
 
 %>

 --%>
<jsp:setProperty property="password" name="memberInfo" value = "<%= memberInfo.getId() %>"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����</title>
</head>
<body>

<table width = "400" border ="1" cellpadding="0" cellspacing="0">
<tr>
	<td>���̵�</td>
	<td><%=memberInfo.getId() %></td>
	<td>��ȣ</td>
	<td><jsp:getProperty property="password" name="memberInfo"/></td>
</tr>
<tr>
	<td>�̸�</td>
	<td><jsp:getProperty property="name" name="memberInfo"/></td>
	<td>�̸���</td>
	<td><jsp:getProperty property="email" name="memberInfo"/></td>
</tr>
<tr>
	<td>�ּ�</td>
	<td colspan="3">
	<jsp:getProperty property="address" name="memberInfo"/>
	</td>
</tr>
</table>
</body>
</html>