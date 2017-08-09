<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.board.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글수정</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/common.js"></script>
</head>
<body>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article = dbPro.updateGetArticle(num);
%>
<div id = "wrap">
	<div id = "header"><h1>글수정</h1></div>
		<form method="post" name="writeform" action="updatePro.jsp?pageNum=<%=pageNum %>" onsubmit="return writeSave()">
			<div id="content">
			<table>
				<colgroup>
					<col width= "20%"/>
					<col width = "*" />
				</colgroup>
				<tr>
					<th>작성자</th>
					<td>
					<input type="text" name="writer" value="<%=article.getWriter() %>" />
						<input type="hidden" name="num" value="<%=article.getNum() %>" />
					</td>
				</tr>
				<tr>
					<th>제 목</th>
					<td>
					<input type="text" name="subject" value="<%=article.getSubject()%>" /></td>
				</tr>
				<tr>
					<th>Email</td>
					<td align="left" width="330"><input type="text" size="40"
						maxlength="30" name="email" value="<%=article.getEmail()%>"></td>
				</tr>
				<tr>
					<th>내 용</th>
					<td><textarea name="content"><%=article.getContent()%></textarea></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="passwd" /></td>
				</tr>
				</table>
			</div>
			<div id ="footer">
				<input type="submit" value="글수정">
				<input type="reset"  value="다시작성">
				<input type="button" value="목록보기" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
			</div>
		</form>
<% }catch(Exception e) {} %>
</div>
</body>
</html>