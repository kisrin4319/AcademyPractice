<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.logon.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file="../view/color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	String pageNum = request.getParameter("pageNum");
	int pageNumber = 1;
	if(pageNum!= null){
		pageNumber =Integer.parseInt(pageNum);
	}
	int startRow = (pageNumber *5) -4;
	int endRow = pageNumber * pageSize;
	int count =0;
	int number =0;
	int n =0;
	List memberList = null;
	List searchmemberList = null;
	String keyword = request.getParameter("keyword");
	if(keyword == null){
		keyword ="";
	}
	LogonDBBean dbPro = LogonDBBean.getInstance();
	
	if(keyword.equals("") || keyword == null){
		count = dbPro.getmemberCount();
	} else {
		count = dbPro.getMemberCount(keyword);
	}
	
	if(count>0){
		if(keyword.equals("") || keyword == null){
			memberList = dbPro.getMembers(startRow, endRow);
		}
		else{
			memberList = dbPro.getMembers(startRow, endRow, keyword);
		}
	}
	number = count-(pageNumber-1)* pageSize;
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ�� ����Ʈ</title>
<link href ="../css/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<center><b>ȸ�����(��ü ȸ��: <%=count %>)</b>
<table width ="1200">
<tr>
	<td align="left" bgcolor="<%=value_c %>">
<%
	if(session.getAttribute("memId")!=null){
%>
	<a href="main.jsp">Ȩ ȭ������</a>
<%} else { %>
	<a href="loginForm.jsp">�α���</a>
	<% }%>
</td>
	<td align="right" bgcolor="<%=value_c %>">
	<form>
	<input type="text" name ="keyword" size = "15" maxlength="30"/>
	<input type="submit" value ="�� ��"/>
	</form>
	</td>
</tr>
</table>
<%
	if(count ==0){
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	ȸ������� �����ϴ�.
	</td>
</table>

<%} else { %>
<table border="1" width="1200" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c%>">
		<td align="center" width="50">��ȣ</td>
		<td align="center" width="100">���̵�</td>
		<td align="center" width="50">��й�ȣ</td>
		<td align="center" width="100">�̸�</td>
		<td align="center" width="150">�ֹι�ȣ</td>
		<td align="center" width="150">�̸���</td>
		<td align="center" width="50">�����ȣ</td>
		<td align="center" width="150">�ּ�</td>
		<td align="center" width="150">��α�</td>
		<td align="center" width="100">���Գ�¥</td>
		<td align="center" width="100">
		����/����
		</td>
	</tr>
	
<%
	try{
		for(int i =0; i<memberList.size();i++){
			LogonDataBean member = (LogonDataBean) memberList.get(i);
%>
	<tr height="30">
		<td align="center" width="50"><%=number-- %></td>
		<td align="center" width="100"><%=member.getId() %></td>
		<td align="center" width="50"><%=member.getPasswd() %></td>
		<td align="center" width="100"><%=member.getName() %></td>
		<td align="center" width="150"><%=member.getJumin1() %>-<%=member.getJumin2() %></td>
		<td align="center" width="150"><%=member.getEmail() %></td>
		<td align="center" width="50"><%=member.getZipcode() %></td>
		<td align="center" width="250"><%=member.getAddress() %></td>
		<%if(member.getBlog()!=null){ %>
		<td align="center" width="150"><%=member.getBlog() %></td>
		<%} else { %>
		<td align="center" width="150"><%} %></td>
		<td align="center" width="100"><%=sdf.format(member.getReg_date()) %></td>
		<td align="center" width="100">
		<a href="modifyForm.jsp?id=<%=member.getId() %>">����</a>/<a href="deletePro.jsp?id=<%=member.getId() %>&passwd=<%=member.getPasswd() %>">����</a>
		</tr>
		<% }%>
</table>
<%} catch(Exception e) {} } %>
<%--����¡!!! --%>
<%
	 if(count >0){
		 
		 int pageCount = count/pageSize +(count % pageSize ==0 ? 0:1);
		 
		 int startPage = (int)(pageNumber/5)*5+1;
		 int pageBlock = 5;
		 int endPage = startPage + pageBlock-1;
		 if(endPage >pageCount) endPage = pageCount;
		 
		 if(startPage >5){ %>
		 <a href="list.jsp?page=<%= startPage-5 %>">[����]</a>
<%	 }
		for(int i = startPage; i<=endPage; i++){ %>
		<a href="list.jsp?page=<%=i %>">[<%=i %>]</a>
<%
		}
		if(endPage<pageCount){ %>
		<a href="list.jsp?page=<%=startPage +5 %>">[����]</a>
<%
		}
	 }
%>
</center>
</body>
</html>