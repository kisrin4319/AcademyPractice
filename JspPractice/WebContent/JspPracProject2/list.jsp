<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.board.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ include file ="../view/color.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
	int pageSize = 5; // �� �������� ������ ���� ����
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //��¥ ǥ�� ���� ����
%>
<%
	
	String pageNum = request.getParameter("pageNum"); //pageNum �Ķ���͸� pageNum���� ����
	if(pageNum == null){ // ���� pageNum �� ���ٸ�(���۹��� ���Ѵٸ�) pageNum �� 1�� ����
		pageNum ="1";
	}
	int currentPage = Integer.parseInt(pageNum);
	System.out.println(currentPage);
	int startRow = (currentPage *5) -4;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	int n =0;
	List articleList = null;
	List searchList = null;
	String keyword = request.getParameter("keyword");
	if(keyword==null){
		keyword = "";
	}
	else{
		n = Integer.parseInt(request.getParameter("keyField"));
	}
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	CommentDBBean cdb=CommentDBBean.getInstance();
	if(keyword.equals("") || keyword == null){
		count = dbPro.getArticleCount();
	}
	else{
		count = dbPro.getArticleCount(n, keyword);
	}
	
	if(count>0){
		
		if(keyword.equals("") || keyword == null){
		articleList = dbPro.getArticles(startRow, endRow);
		}
		else{
			articleList = dbPro.getArticles(startRow, endRow, n, keyword);
		}
	}
	
	number = count-(currentPage-1)*pageSize;
			 // 11 -(2-1)*5  =6
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel ="stylesheet" type = "text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<center><b>�۸��(��ü  ��: <%=count %>)</b> <!-- ��ü �� ����  -->
<table width="700">
<tr>
	<td align="right" bgcolor="<%=value_c %>">
	<a href="writeForm.jsp">�۾���</a>
	</td>
</table>

<%

	if(count ==0){ /*��ü ���� ������ 0�� ���  */
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td align="center">
	�Խ��ǿ� ����� ���� �����ϴ�.
	</td>
</table>

<% }else { %> <!--  ��ü���� ������ 0�� �̻��̶�� -->
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center">
	<tr height="30" bgcolor="<%=value_c %>">
		<td align="center" width="50" >�� ȣ</td>
		<td align="center" width="250" >��    ��</td>
		<td align="center" width="100" >�ۼ���</td>
		<td align="center" width="150" >�ۼ���</td>
		<td align="center" width="50" >��  ȸ</td>
		<td align="center" width="100" >IP</td>
	</tr>
	
<%
	try {
	for(int i =0 ; i<articleList.size();i++)
	{
		BoardDataBean article = (BoardDataBean)articleList.get(i);
		int com_count = cdb.getCommentCount(article.getNum());
%>

	<tr height="30">
		<td align="center" width="50"><%=number-- %></td>
		
	<td align="left">		
<%
	int wid = 0;
	if(article.getRe_level()>0)
	{ //�亯���̶��...
		wid = 5*(article.getRe_level());
%>
	<img src="images/level.gif" width="<%=wid %>" height="16" >
	<img src="images/re.gif">
	
<%	}
	else
	{ /* ���� �� �̶�� */	
%> 
	<img src ="images/level.gif" width="<%=wid %>" height="16">
<%  } %>
<% if(com_count >0) { %>
	<a href ="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>"> <!-- �Խñۿ� ���� ������ �������� ��  -->
			<%=article.getSubject() %>[<%=com_count %>]</a>
<% } else { %>
	<a href ="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>"> <!-- �Խñۿ� ���� ������ �������� ��  -->
			<%=article.getSubject() %></a>
		<%} %>
	
		<% if(article.getReadcount()>=20){ %> <!-- ��ȸ���� 20�� �Ѿ�� Hot ���� �߰� -->
	   <img src = "images/hot.gif" border="0" height="16"><%} %> </td>
	   <td align="center" width="100">
	   	<a href="mailto:<%=article.getEmail() %>"><%=article.getWriter() %></a></td>
	   <td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
	   <td align="center" width="50"><%=article.getReadcount() %></td>
	   <td align="center" width="100"><%=article.getIp() %></td>
	  </tr>
	  <%}%>   
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
	//��ü �������� ���� ����
	int pageCount = count / pageSize +(count%pageSize ==0? 0:1);
	int startPage =(int)(currentPage/5)*5+1;
	int pageBlock = 5;
	int endPage = startPage + pageBlock-1;
	if(endPage> pageCount) endPage = pageCount;
	
	if(startPage>5) {
		if(keyword.equals("") || keyword == null)
		{
		%>
			<a href="list.jsp?pageNum=<%=startPage-5 %>">[����]</a>	
		<%	
		}
		else
		{
		%>
		<a href="list.jsp?pageNum=<%=startPage - 5 %>&keyword=<%=keyword %>&n=<%=n %>">[����]</a>
		<%
		}
		%>
 <%
	}
	for(int i = startPage; i<=endPage;i++){
		if(keyword.equals("") || keyword == null)
		{
	%>
	<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
	<%
	}
		else
		{
	%>
	<a href="list.jsp?pageNum=<%=i %>&keyword=<%=keyword %>&n=<%=n %>">[<%=i %>]</a>
	<%	
		}
	%>
<% }	
	if(endPage<pageCount){ 
	//����������
	if(keyword.equals("") || keyword == null)
	{
%>
	<a href="list.jsp?pageNum=<%=startPage+5 %>">[����]</a>
<%
		}
	else
	{
%>
	<a href="list.jsp?pageNum=<%=startPage+5 %>&keyword=<%=keyword %>&n=<%=n %>">[����]</a>
<%
	}
}
	}
%>
<br>

<form>
   <select name = "keyField">
      <option value = "0">�ۼ��� </option>
      <option value = "1">����</option>
      <option value = "2">����</option>
   </select>
   <input type="text" name = "keyword" size ="15" maxlength="30"/>
   <input type="submit" value = "�� ��" />
   </form>
</center>
</body>
</html>