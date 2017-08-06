<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.board.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file ="../view/color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
	int pageSize = 5; // 한 페이지에 보여줄 글의 갯수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //날짜 표현 형식 지정
%>
<%
	String pageNum = request.getParameter("pageNum"); //pageNum 파라미터를 pageNum으로 선언
	if(pageNum == null){ // 만약 pageNum 이 없다면(전송받지 못한다면) pageNum 을 1로 지정
		pageNum ="1";
	}
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage *5) -4;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	int searchCount =0;
	List articleList = null;
	BoardDBBean dbPro = BoardDBBean.getInstance();
	count = dbPro.getArticleCount();
	
	if(count>0){
		articleList = dbPro.getArticles(startRow, endRow);
	}
	
	number = count-(currentPage-1)*pageSize;
			 // 11 -(2-1)*5  =6
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="style.css" rel ="stylesheet" type = "text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<center><b>글목록(전체  글: <%=count %>)</b> <!-- 전체 글 갯수  -->
<table width="700">
<tr>
	<td align="right" bgcolor="<%=value_c %>">
	<a href="writeForm.jsp">글쓰기</a>
	</td>
</table>

<%

	if(count ==0){ /*전체 글의 갯수가 0개 라면  */
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	게시판에 저장된 글이 없습니다.
	</td>
</table>

<% }else { %> <!--  전체글의 갯수가 0개 이상이라면 -->
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td align="center" width="50" >번 호</td>
		<td align="center" width="250" >제    목</td>
		<td align="center" width="100" >작성자</td>
		<td align="center" width="150" >작성일</td>
		<td align="center" width="50" >조  회</td>
		<td align="center" width="100" >IP</td>
	</tr>
	
<%
	try {
	for(int i =0 ; i<articleList.size();i++){
		BoardDataBean article = (BoardDataBean)articleList.get(i);	
%>

	<tr height="30">
		<td align="center" width="50"><%=number-- %></td>
		<td width="250">
		
<%
	int wid = 0;
	if(article.getRe_level()>0){ //답변글이라면...
		wid = 5*(article.getRe_level());
%>
	<img src="images/level.gif" width="<%=wid %>" height="16" >
	<img src="images/re.gif">
	
<%} else{ /* 메인 글 이라면 */
	
%> 
	<img src ="images/level.gif" width="<%=wid %>" height="16">
<% } %>

	<a href ="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>"> <!-- 게시글에 대한 정보를 가져오는 곳  -->
			<%=article.getSubject() %></a>
		<% if(article.getReadcount()>=20){ %> <!-- 조회수가 20이 넘어가면 Hot 사진 추가 -->
	   <img src = "images/hot.gif" border="0" height="16"><%} %> </td>
	   <td align="center" width="100">
	   	<a href="mailto:<%=article.getEmail() %>"><%=article.getWriter() %></a></td>
	   <td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
	   <td align="center" width="50"><%=article.getReadcount() %></td>
	   <td align="center" width="100"><%=article.getIp() %></td>
	  </tr>
	  <%} %>   
</table>
<%}
 catch(Exception e){
	int prePage = Integer.parseInt(pageNum); 
	prePage--;
	%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=prePage %>">
	<%
}
%>
<% } %>


<%
	if(count>0){
	//전체 페이지의 수를 연산
	int pageCount = count / pageSize +(count%pageSize ==0? 0:1);
	int startPage =(int)(currentPage/5)*5+1;
	int pageBlock = 5;
	int endPage = startPage + pageBlock-1;
	if(endPage> pageCount) endPage = pageCount;
	
	if(startPage>5) {  %>
	<a href="list.jsp?pageNum=<%=startPage-5 %>">[이전]</a>	
<%	}
	for(int i = startPage; i<=endPage;i++){%>
	<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
<%
	}
	if(endPage<pageCount){ %>
	<a href="list.jsp?pageNum=<%=startPage+5 %>">[다음]</a>
<%
		}
	}
%>
<br>
<script type="text/javascript">

	function checkIt() {
		if(document.search.keyword.value==""){
			alert('검색어를 입력하세요.');
			document.search.keyword.focus();
			return false;
		}
	}
</script>
<form action ="list.jsp?pageNum=<%=pageNum %>" name = "search" onsubmit=" return checkIt()">
	<select name = "keyField">
		<option value = "subject" name ="1">제목 </option>
		<option value = "writer" name ="2">이름</option>
		<option value = "content" name="3">내용</option>
	</select>
	<input type="text" name = "keyword"/>
	<input type="submit" value = "검 색" />
	</form>
<%-- <%
	String keyword = request.getParameter("keyword");
	searchCount = dbPro.getArticleCount(searchKeyword);
	int n = Integer.parseInt(request.getParameter("
	
	if(searchCount!=0){
		out.println("조건에 맞는 글이 없습니다.");
		%>
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=currentPage %>"
	<%
	}
	%> --%>
</center>
</body>
</html>