<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.logon.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원 리스트</title>
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
		회원목록(전체 회원:<span class="count"><%=count %></span>)
		</h1>
	</div>
</div>
<table width ="1200">
<tr>
	<td align="left">
<%
	if(session.getAttribute("memId")!=null){
%>
	<a href="main.jsp">홈 화면으로</a>
<%} else { %>
	<a href="loginForm.jsp">로그인</a>
	<% }%>
</td>
	<td align="right">
	<form>
	<div class = "searchWarp">
	<input type="text" name ="keyword" size = "15" maxlength="30"/>
	<input type="submit" value ="검 색"/>
	</div>
	</form>
	</td>
</tr>
</table>

	<div id ="content">
<%
	if(count ==0){
%>
 	<p class = "noData">회원목록이 없습니다.</p>
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
		<th text-align="center">번호 </th>
		<th align="center">아이디</th>
		<th align="center">이름</th>
		<th text-align="center">주민번호</th>
		<th align="center">이메일</th>
		<th align="center">우편번호</th>
		<th align="center">주소</th>
		<th align="center">블로그</th>
		<th align="center">가입날짜</th>		
		<th align="center">수정/삭제</th>
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
		<a href="modifyForm.jsp?id=<%=member.getId() %>">수정</a>/<a href="deletePro.jsp?id=<%=member.getId() %>&passwd=<%=member.getPasswd() %>">삭제</a>
		<% } else { } %> </td>
		</tr>
		<% }%>
</table>
<%} catch(Exception e) {} } %>
<%--페이징!!! --%>
<div class ="paging">
<%
	 if(count >0){
		 
		 int pageCount = count/pageSize +(count % pageSize ==0 ? 0:1);
		 
		 int startPage = (int)(pageNumber/5)*5+1;
		 int pageBlock = 5;
		 int endPage = startPage + pageBlock-1;
		 if(endPage >pageCount) endPage = pageCount;
		 
		 if(startPage >5){ %>
		 <a href="list.jsp?page=<%= startPage-5 %>" class="spot">[이전]</a>
		<ol>
<%	 }
		for(int i = startPage; i<=endPage; i++){ %>
		<li><a href="list.jsp?page=<%=i %>" class = "spot">[<%=i %>]</a></li>
		</ol>
<%
		}
		if(endPage<pageCount){ %>
		<a href="list.jsp?page=<%=startPage +5 %>" class ="spot">[다음]</a>
<%
		}
	 }
%>
</div>
</div>
</body>
</html>