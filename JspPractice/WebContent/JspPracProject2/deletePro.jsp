<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "web.board.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("euc-kr"); %>

<%

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd = request.getParameter("passwd");
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	int check = dbPro.deleteArticle(num, passwd);
	List articleList = null;
	if(check==1){
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">
<%} else { %>

	<script type="text/javascript">
		alert("��й�ȣ�� ���� �ʽ��ϴ�.");
		history.go(-1);	
	</script>
<%
}
%>