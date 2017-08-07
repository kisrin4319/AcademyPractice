<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.board.*" %>
<%@ include file = "../view/color.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function writeSave() {
	if(document.comment.commentt.value==""){
		alert("�ۼ��ڸ� �Է��Ͻʽÿ�.");
		document.comment.commentt.focus();
		return false;
	}
}
</script>
</head>
<!-- list.jsp ���� �Ѿ���� �������� ���� -->
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
<body bgcolor="<%=bodyback_c %>">
<center><b>�۳��� ����</b>
<br>
<form>
	<table width="500" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">�۹�ȣ</td>
			<td align="center" width="125">
				<%=article.getNum() %></td>
			<td align="center" width="125" bgcolor="<%=value_c %>">��ȸ��</td>
			<td align="center" width="125">
			 	<%=article.getReadcount() %></td>
		</tr>
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">�ۼ���</td>
			<td align="center" width="125">
			 	<%=article.getWriter() %></td>
			<td align="center" width="125" bgcolor="<%=value_c %>">�ۼ���</td>
			<td align="center" width="125">
			 	<%=sdf.format(article.getReg_date()) %></td>
		</tr> 	
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">������</td>
			<td align="center" width="375" colspan="3">
			 	<%=article.getSubject() %></td>
		</tr>
		<tr>
			<td align="center" width="125" bgcolor="<%=value_c %>">�۳���</td>
			<td align="left" width="375" colspan="3"><pre><%=article.getContent() %></pre></td>
		</tr>
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c %>" align="right">
			<input type="button" value ="�ۼ���" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'"> <!-- updateForm.jsp�� �ش������� ���� -->
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value ="�ۻ���" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'"> <!-- deleteForm.jsp�� �ش������� ���� -->
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value ="��۾���" onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step%>&re_level=<%=re_level%>'"> <!-- writeForm.jsp�� �ش������� ���� -->
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value ="�۸��" onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">
			</td>
			</tr>
	</form>
	<form method="post" action = contentPro.jsp name = "comment" onsubmit="return writeSave()">
	<tr bgcolor="<%=value_c %>" align="center">
		<td>�ڸ�Ʈ �ۼ� </td>
		<td colspan="2">
			<textarea rows="6" cols="40" name="commentt"></textarea>
			<input type="hidden" name = "content_num" value ="<%=article.getNum() %>"/>
			<input type="hidden" name = "p_num" value ="<%=pageNum %>"/>
			<input type="hidden" name = "comment_num" value ="<%=count+1 %>"/>
		</td>
		<td align="center">
			�ۼ���<br>
			<input type="text" name = "commenter" size ="10"/><br>
			��й�ȣ<br>
			<input type="password" name = "passwd" size = "10"/><p>
			<input type="submit" value = "�ڸ�Ʈ �ޱ�"/>
		</td>
		</tr>
		</form>
		</table>
		
		<%if(count>0){ %>
		<p>
		<table width="500" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">
			<tr>
				<td>�ڸ�Ʈ �� : <%=comments.size() %>
			</tr>
			<%for(int i = 0 ; i<comments.size();i++){
				CommentDataBean dbc = (CommentDataBean) comments.get(i);
			%>
			<tr>
				<td align="left" size ="250" bgcolor="<%=value_c %>">
				&nbsp;<b><%=dbc.getCommenter() %>&nbsp;��</b>(<%=sdf.format(dbc.getReg_date()) %>)
				</td>
				<td align="right" size ="250" bgcolor="<%=value_c %>">����IP:<%=dbc.getIp() %>
				&nbsp;<a href = "deleteCommentForm.jsp?ctn=<%=dbc.getContent_num() %>&cmn=<%=dbc.getComment_num() %>&p_num=<%=pageNum %>">[����]</a>&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2"><%=dbc.getCommentt() %></td>
				
			<%}%>
			</tr>
		</table>
		<table width="500" border = "0" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">
		<tr>
		<center>
		
		<%--����¡!!! --%>
		
	<%
	if(count>0){
		int pageCount = count / pageSize +(count% pageSize ==0 ? 0:1);
		int startPage = (int)(cCurrentPage/5)*5 +1;
		int pageBlock = 5;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage >5){ %>
		<a href = "content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=startPage-5 %>">[����]</a>
	<%	}
		for(int i = startPage ; i<=endPage; i++){ %>
		<a href="content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=i %>">[<%=i %>]</a>
<%
		}
		if(endPage < pageCount) { %>
		<a href = "content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=startPage+5 %>">[����]</a>
	<%	
		}
	}
	%>
				</center>
			</tr>
		</table>
		<% } %>
<%
}catch(Exception e){}
%>
</center>
</body>
</html>