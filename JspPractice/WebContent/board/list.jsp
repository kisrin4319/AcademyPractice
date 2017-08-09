<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="web.board.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>게시판</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%
		int pageSize = 5; // 한 페이지에 보여줄 글의 갯수
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //날짜 표현 형식 지정
	%>
	<%
		String pageNum = request.getParameter("pageNum"); //pageNum 파라미터를 pageNum으로 선언
		if (pageNum == null) { // 만약 pageNum 이 없다면(전송받지 못한다면) pageNum 을 1로 지정
			pageNum = "1";
		}

		int currentPage = Integer.parseInt(pageNum);
		//System.out.println(currentPage);
		int startRow = (currentPage * 5) - 4;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		int n = 0;
		List articleList = null;
		String keyword = request.getParameter("keyword"); //검색창에 입력한 키워드를 받아 String keyword 로 대입
		//keyword가 없다면 그냥 일반 글 목록(List)를 보여줘야 함.
		if (keyword == null) {
			keyword = "";
		}
		//keyword를 통한 검색이라면  검색조건이 작성자(0),제목(1),내용(2) 중 구별 하여 int n 에 대입
		else

		{
			n = Integer.parseInt(request.getParameter("keyField"));
		}

		BoardDBBean dbPro = BoardDBBean.getInstance(); //게시판DBBean 객체 생성
		CommentDBBean cdb = CommentDBBean.getInstance(); //댓글DBBean 객체 생성

		//검색이 아니라면 전체 글의 갯수를 가져옴
		if (keyword.equals("") || keyword == null) {
			count = dbPro.getArticleCount();
		}

		else {
			count = dbPro.getArticleCount(n, keyword);
		}

		if (count > 0) {

			if (keyword.equals("") || keyword == null) {
				articleList = dbPro.getArticles(startRow, endRow);
			} else {
				articleList = dbPro.getArticles(startRow, endRow, n, keyword);
			}
		}

		number = count - (currentPage - 1) * pageSize;
		// 11 -(2-1)*5  =6
	%>

	<div id="wrap">
		<div id="header">
			<h1>
				글목록(전체 글: <span class="count"><%=count%></span>)
			</h1>
		</div>
		<!-- 전체 글 갯수  -->
		<table width="700">
			<tr>
				<td align="left">
					<%
						if (session.getAttribute("memId") != null) {
					%> <%=session.getAttribute("memId")%>님 <input type="button"
					value="로그아웃" onclick="document.location.href='../logon/logout.jsp'"
					<%}%>
				</td>
				<td align="right">
					<%
						if (session.getAttribute("memId") != null) {
					%> 	<a href="writeForm.jsp">글쓰기</a>
					<% } else { %>
					 	<a href="../logon/loginForm.jsp">로그인</a>
					<% } %>
				</td>
			</tr>
		</table>

		<div id="content">
			<%
				if (count == 0) { //전체 글의 갯수가 0개 라면
			%>
			<p class="noData">작성된 글이 없습니다.</p>
			<% } else { // 전체글의 갯수가 0개 이상이라면 %>
			<table class="ListForm">
				<colgroup>
					<col width="10%" />
					<col width="*" />
					<col width="15%" />
					<col width="20%" />
					<col width="9%" />
					<col width="15%" />
				</colgroup>
				<tr>
					<th>번 호</th>
					<th>제 목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조 회</th>
					<th>IP</th>
				</tr>

				<%
					try {
							for (int i = 0; i < articleList.size(); i++) {
								BoardDataBean article = (BoardDataBean) articleList.get(i);
								int com_count = cdb.getCommentCount(article.getNum()); //글에 달린 댓글의 갯수를 가져옴
				%>

				<tr class="listCon">
					<td><%=number--%></td>
					<td class="subject">
						<%
							//int wid = 0; //답변글의 공백 지정 (들여쓰기)
							if (article.getRe_level() > 0) { //답변글이라면...
							//wid = 5*(article.getRe_level());
						%> &nbsp;&nbsp;<span class="reply">└&nbsp;[re]</span>
						<% } else {	}%>
						<% if (com_count > 0) { %>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
						&nbsp;<span class="cmtCount">[<%=com_count%>] </span>
						<% } else { %>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
						<% }
						   if (article.getReadcount() >= 20) { %> <!-- 조회수가 20이 넘어가면 Hot 사진 추가 -->
						    <span class="icoHot">Hit</span>
						<% } else { } %>
					</td>
					<td><a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
					<td><%=sdf.format(article.getReg_date())%></td>
					<td><%=article.getReadcount()%></td>
					<td><%=article.getIp()%></td>
				</tr>
				<%
					}
				%>
			</table>
			<%
				} catch (Exception e) {
						int prePage = Integer.parseInt(pageNum);
						prePage--;
			%>
			<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=prePage%>">
			<%
				}
			}
			%>

			<div class="paging">
				<%
					if (count > 0) {
						//전체 페이지의 수를 연산
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
						int startPage = (int) (currentPage / 5) * 5 + 1;
						int pageBlock = 5;
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount)
							endPage = pageCount;

						if (startPage > 5) {
							if (keyword.equals("") || keyword == null) {
				%>
				<a href="list.jsp?pageNum=<%=startPage - 5%>" class="spot">[이전]</a>
				<%
					} else {
				%>
				<a
					href="list.jsp?pageNum=<%=startPage - 5%>&keyword=<%=keyword%>&n=<%=n%>"
					class="spot">[이전]</a>
				<%
					}
						}
				%>
				<ol>
					<%
						for (int i = startPage; i <= endPage; i++) {
								if (keyword.equals("") || keyword == null) {
					%>
					<li><a href="list.jsp?pageNum=<%=i%>">[<%=i%>]
					</a></li>
					<%
						} else {
					%>
					<li><a href="list.jsp?pageNum=<%=i%>&keyword=<%=keyword%>&n=<%=n%>">[<%=i%>]</a></li>
					<%
							}
						}
					%>
				</ol>
				<%
					if (endPage < pageCount) {
							//다음페이지
							if (keyword.equals("") || keyword == null) {
				%>
				<a href="list.jsp?pageNum=<%=startPage + 5%>" class="spot">[다음]</a>
				<%
					} else {
				%>
				<a
					href="list.jsp?pageNum=<%=startPage + 5%>&keyword=<%=keyword%>&n=<%=n%>"
					class="spot">[다음]</a>
				<%
					}
						}
					}
				%>
			</div>
		</div>
		<%
			if (session.getAttribute("memId") != null) {
		%>
		<form>
			<div class="searchWarp">
				<select name="keyField">
					<option value="0">작성자 </option>
					<option value="1">제목</option>
					<option value="2">내용</option>
				</select> <input type="text" name="keyword" size="15" maxlength="30" /> <input
					type="submit" value="검 색" class="btn" />
			</div>
		</form>
		<div id="footer">
			<input type ="button" value="글쓰기"
				onclick="javascript:window.location.href='writeForm.jsp'" />
			<input type = "button" value="Home" onclick="javascript:window.location.href='../logon/main.jsp'" /> 	
		</div>
		<%} %>
	</div>
</body>
</html>