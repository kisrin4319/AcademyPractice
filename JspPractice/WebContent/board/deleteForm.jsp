<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file  ="../view/color.jsp" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src ="./js/common.js"></script>
</head>
<body>
<div id ="wrap">
	<div id = "header"><h1>�ۻ���</h1></div>
	<form method="post" name ="delForm" action="deletePro.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave()">
		<input type="hidden" name ="num" value = "<%=num %>" />
		<div id = "content">
			<div class = "delForm">
				<p>��й�ȣ�� �Է��� �ּ���.</p>	
				<dl>
					<dt>��й�ȣ</dt>
					<dd><input type="password" name ="passwd" /></dd>
				</dl>
			</div>
		</div>
		<div id = "footer" class ="deleteBtn">
			<input type="submit" value="�ۻ���"/>
			<input type="button" value ="�۸��" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'" />
		</div>
	</form>
</div>
</body>
</html>