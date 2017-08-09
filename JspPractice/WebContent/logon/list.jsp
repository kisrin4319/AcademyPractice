<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.logon.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ�� ����Ʈ</title>
<link href ="../board/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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


<div id ="wrap">
	<div id ="header">
		<h1>
		ȸ�����(��ü ȸ��:<span class="count"><%=count %></span>)
		</h1>
	</div>
</div>
<table width ="1200">
<tr>
	<td align="left">
<%
	if(session.getAttribute("memId")!=null){
%>
	<a href="main.jsp">Ȩ ȭ������</a>
<%} else { %>
	<a href="loginForm.jsp">�α���</a>
	<% }%>
</td>
	<td align="right">
	<form>
	<div class = "searchWarp">
	<input type="text" name ="keyword" size = "15" maxlength="30"/>
	<input type="submit" value ="�� ��"/>
	</div>
	</form>
	</td>
</tr>
</table>

	<div id ="content">
<%
	if(count ==0){
%>
 	<p class = "noData">ȸ������� �����ϴ�.</p>
<%} else { %>
<table class ="ListForm">
	<colgroup>
		<col width = "2%" />
		<col width = "5%" />
		<col width = "5%" />
		<col width = "20%" />
		<col width = "10%" />
		<col width = "5%" />
		<col width = "10%" />
		<col width = "20%" />
		<col width = "5%" />
		<col width = "10%" />
		<col width = "5%" />
	</colgroup>
	<tr>
		<th text-align="center">��ȣ </th>
		<th align="center">���̵�</th>
		<th align="center">�̸�</th>
		<th text-align="center">�ֹι�ȣ</th>
		<th align="center">�̸���</th>
		<th align="center">�����ȣ</th>
		<th align="center">�ּ�</th>
		<th align="center">��α�</th>
		<th align="center">���Գ�¥</th>		
		<th align="center">����/����</th>
	</tr>
	
<%
	try{
		for(int i =0; i<memberList.size();i++){
			LogonDataBean member = (LogonDataBean) memberList.get(i);
%>
	<tr class ="listCon">
		<td><%=number-- %></td>
		<td><%=member.getId() %></td>
		<td><%=member.getName() %></td>
		<td><%=member.getJumin1() %>-<%=member.getJumin2() %></td>
		<td><%=member.getEmail() %></td>
		<td><%=member.getZipcode() %></td>
		<td><%=member.getAddress() %></td>
		<td><%if(member.getBlog()!=null){ %>
		<%=member.getBlog() %>
		<%} else { %>
		<%} %></td> 
		<td><%=sdf.format(member.getReg_date()) %></td>
		
		<td><% if(session.getAttribute("memId")!=null){%>
		<a href="modifyForm.jsp?id=<%=member.getId() %>">����</a>/<a href="deletePro.jsp?id=<%=member.getId() %>&passwd=<%=member.getPasswd() %>">����</a>
		<% } else { } %> </td>
		</tr>
		<% }%>
</table>
<%} catch(Exception e) {} } %>
<%--����¡!!! --%>
<div class ="paging">
<%
	 if(count >0){
		 
		 int pageCount = count/pageSize +(count % pageSize ==0 ? 0:1);
		 
		 int startPage = (int)(pageNumber/5)*5+1;
		 int pageBlock = 5;
		 int endPage = startPage + pageBlock-1;
		 if(endPage >pageCount) endPage = pageCount;
		 
		 if(startPage >5){ %>
		 <a href="list.jsp?page=<%= startPage-5 %>" class="spot">[����]</a>
		<ol>
<%	 }
		for(int i = startPage; i<=endPage; i++){ %>
		<li><a href="list.jsp?page=<%=i %>" class = "spot">[<%=i %>]</a></li>
		</ol>
<%
		}
		if(endPage<pageCount){ %>
		<a href="list.jsp?page=<%=startPage +5 %>" class ="spot">[����]</a>
<%
		}
	 }
%>
</div>
</div>
</body>
</html>