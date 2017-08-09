<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "web.board.CommentDBBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("euc-kr"); %>
<%
	int content_num = Integer.parseInt(request.getParameter("content_num"));
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	String pageNum = request.getParameter("p_num");
	String passwd = request.getParameter("passwd");
	
	CommentDBBean cmtPro = CommentDBBean.getInstance();
	int check = cmtPro.deleteComment(content_num, passwd, comment_num);
	
	if(check==1){
%>
	<script type="text/javascript">
		location.href="content.jsp?num=<%=content_num%>&pageNum=<%=comment_num %>";
	</script>
	<%} else { %>
	<script type="text/javascript">
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);	
	</script>
	<%} %>