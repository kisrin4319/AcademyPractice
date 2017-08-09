<%@page import="web.service.GetMessageListService"%>
<%@page import="web.model.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�۸��</title>
<link rel="stylesheet" type="text/css" href="./css/style.css" />
</head>
<%
	String pageNumberStr = request.getParameter("page");
	int pageNumber = 1;
	if(pageNumberStr!= null){
		pageNumber = Integer.parseInt(pageNumberStr);
	}
	
	GetMessageListService messageListService = GetMessageListService.getInstance();
	MessageListView viewData = messageListService.getMessageList(pageNumber);
%>

<body>
	<div id ="wrap">
		<div class = "commentWrap">
			<div class = "commentWrite">
				<form action = "writeMessage.jsp" method="post">
				<p class = "writer">
				�ۼ��� <input type="text" name = "guestName" />
				��й�ȣ <input type="password" name = "password" />
				</p>
			<div class = "commentCon">
				<textarea name="message"></textarea>
				<span><input type="submit" value ="Ȯ��" /></span>
			</div>	
				</form>			
			</div>

<% if(viewData.isEmpty()) { %>
��ϵ� �޽����� �����ϴ�.
<% } else { /*�޽����� �ִ� ��� ó�� ���� */ %>
	<div class = "commentList">
	<ul>
<%
	for(Message message: viewData.getMessageList()){
%>
	<li>
		<span class ="no">�޽��� ��ȣ : <%=message.getId() %></span>
		<span class="writer"><%=message.getGuestName() %></span>
		<p><%=message.getMessage() %>&nbsp;<span class="delBtn"><a href="confirmDeletion.jsp?messageId=<%=message.getId() %>">X</a></span></p>
	</li>
	<% } %>
	</ul>
	</div>
</div>
<div class = "paging">
	<ul>	
<%	for(int i = 1; i<=viewData.getPageTotalCount(); i++){ %>
	<li><a href="list.jsp?page=<%=i %>">[<%=i %>]</a></li>
<%		} %>
	</ul>
	</div>
<% } /*�޽����� �ִ� ��� ó�� �� */ %>
</div>
</body>
</html>