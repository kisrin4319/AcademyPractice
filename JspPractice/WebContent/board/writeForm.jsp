<%@page import="web.logon.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글입력</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/test.js"></script>
</head>
<body>
<%
	int num = 0, ref = 1, re_step = 0, re_level = 0; //num은 글번호 , ref = 메인글과 답변글을 묶어주는 그룹번호 
													 // re_step	화면출력 순서  , re_level 은 메인,답변글 구별
	LogonDataBean c = null;
	if(session.getAttribute("memId")!=null){
		String id = (String)session.getAttribute("memId");
		LogonDBBean m = LogonDBBean.getInstance();
		c = m.getMember(id);
				
	}
	try {
		if (request.getParameter("num") != null) {
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			re_step = Integer.parseInt(request.getParameter("re_step"));
			re_level = Integer.parseInt(request.getParameter("re_level"));
		}
%>
	<div id="wrap">
		<div id ="header"><h1>글작성</h1></div>
		<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave();">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="ref" value="<%=ref%>">
			<input type="hidden" name="re_step" value="<%=re_step%>">
			<input type="hidden" name="re_level" value="<%=re_level%>">
				<div id="content">
				
			<table>
				<colgroup>
					<col width ="20%" />
					<col width="*" />
				</colgroup>
				
				<tr>
					<th>이 름</td>
					<td>
					<%
					if(session.getAttribute("memId")!=null){
					%>
					<input type="text" size="10" maxlength="10"	name="writer" value="<%=c.getName()%>">
					<% } else { %>
					<input type="text" size="10" maxlength="10"	name="writer">
					<%} %>
					</td>
				</tr>
				<tr>
					<th>제 목</td>
					<td>
						<%if (request.getParameter("num") == null) {%> 
						<input type="text" name="subject" />
					<%} else {%>
					<input type="text" name="subject" value="[re]" />
					<%}%>
					</td>
				</tr>
				<tr>
					<th>Email</td>
					<td>
					<%
					if(session.getAttribute("memId")!=null){
					%>
					<input type="text" name="email" value ="<%=c.getEmail()%>" />
					<%} else { %>
					<input type="text" name="email" />
					<%} %>
					</td>
				</tr>
				<tr>
					<th>내 용</td>
					<td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<th>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				</table>
			</div>
				<div id = "footer">
					<input type="submit" value="글쓰기" />
					<input type="reset" value="다시작성" />
					<input type="button" value="목록보기" OnClick="window.location='list.jsp'" />
				</div>
			</form>
		</div>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>

</html>