<%@page import="web.logon.LogonDBBean"%>
<%@page import="web.logon.LogonDataBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.board.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<!-- list.jsp 에서 넘어오는 정보들을 세팅 -->
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	String pageNum = request.getParameter("pageNum");
	String cPageNum = request.getParameter("cPageNum");
	int pageSize = 5;
	if(cPageNum == null){
		cPageNum = "1";
	}
	int cCurrentPage = Integer.parseInt(cPageNum);
	int startRow = (cCurrentPage *5) -4;
	int endRow = cCurrentPage *pageSize;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	LogonDataBean c = null;
	if(session.getAttribute("memId")!=null){
		String id = (String)session.getAttribute("memId");
		LogonDBBean m = LogonDBBean.getInstance();
		c = m.getMember(id);
				
	}
	
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article = dbPro.getArticle(num);
		CommentDBBean cdb = CommentDBBean.getInstance();
		ArrayList comments  = cdb.getComments(article.getNum(), startRow, endRow);
		int count = cdb.getCommentCount(article.getNum());
		
		
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
%>
<body>
	<div id="wrap">
		<div id="header"><h1>글보기</h1></div>
		<form>
			<div id= "content">
			<table>
				<colgroup>
					<col width="20%" />
					<col width="*" />
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tr>
					<th>글번호</th>
					<td><%=article.getNum() %></td>
					<th>조회수</th>
					<td><%=article.getReadcount() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=article.getWriter() %></td>
					<th>작성일</th>
					<td><%=sdf.format(article.getReg_date()) %></td>
				</tr> 	
				<tr>
					<th>제목</th>
					<td colspan="3"><%=article.getSubject() %></td>
				</tr>
				<tr>
					<th>내용</th>
						<td colspan="3"><textarea name="content"><%=article.getContent() %></textarea></td>
				</tr>
				</table>
			</div>
			<div id = "footer">
				<input type="button" value ="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'"> <!-- updateForm.jsp로 해당페이지 전달 -->
				<input type="button" value ="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'"> <!-- deleteForm.jsp로 해당페이지 전달 -->
				<input type="button" value ="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step%>&re_level=<%=re_level%>'"> <!-- writeForm.jsp로 해당페이지 전달 -->
				<input type="button" value ="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">
			</div>
	</form>
	
	<div class="commentWrap">
		<form method="post" action = "contentPro.jsp">
			<div class ="commentWrite">
			<input type="hidden" name = "content_num" value ="<%=article.getNum() %>"/>
			<input type="hidden" name = "p_num" value ="<%=pageNum %>"/>
			<input type="hidden" name = "comment_num" value ="<%=count+1 %>"/>
			<p class = "writer">
				작성자
				<%if(session.getAttribute("memId")!=null){ %>
				<input type="text" name = "commenter" value = "<%=c.getId()%>"/>
				<%} else { %>
				<input type="text" name = "commenter"/>
				<%} %>
				비밀번호 <input type="password" name = "passwd"/>
			</p>
			<div class = "commentCon">
				<textarea name="commentt"></textarea>
				<span><input type="submit" value = "확인"/></span>
			</div>
		</div>
	</form>
	
	<%if(count>0){ %>
	<div class ="commentList">
		<p class = "count">코멘트 수 : <%=comments.size() %></p>
		<ul>
			<%for(int i = 0 ; i<comments.size();i++){
				CommentDataBean dbc = (CommentDataBean) comments.get(i);
			%>
			<li>
				<span class = "writer"><%=dbc.getCommenter() %></span>님
				<span class = "date">(<%=sdf.format(dbc.getReg_date()) %>)</span>
				<span class = "ip">접속IP:<%=dbc.getIp() %></span>
				<span class = "delBtn"><a href = "delCommentForm.jsp?ctn=<%=dbc.getContent_num() %>&cmn=<%=dbc.getComment_num() %>">X</a></span>
				<p><%=dbc.getCommentt() %></p>
			</li>	
			<%}%>
			</ul>
		</div>
		<%} %>
	</div>	
		<%--페이징!!! --%>
		
	<%
	if(count>0){
		int pageCount = count / pageSize +(count% pageSize ==0 ? 0:1);
		int startPage = (int)(cCurrentPage/5)*5 +1;
		int pageBlock = 5;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage >5){ %>
		<a href = "content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=startPage-5 %>">[이전]</a>
	<%	}
		for(int i = startPage ; i<=endPage; i++){ %>
		<a href="content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=i %>">[<%=i %>]</a>
<%
		}
		if(endPage < pageCount) { %>
		<a href = "content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=startPage+5 %>">[다음]</a>
	<%	
		}
	}
	%>
			</tr>
		</table>
<%
}catch(Exception e){}
%>
</body>
</html>