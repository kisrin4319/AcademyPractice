<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="web.board.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>�Խ���</title>
<link href="./css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%
		int pageSize = 5; // �� �������� ������ ���� ����
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //��¥ ǥ�� ���� ����
	%>
	<%
		String pageNum = request.getParameter("pageNum"); //pageNum �Ķ���͸� pageNum���� ����
		if (pageNum == null) { // ���� pageNum �� ���ٸ�(���۹��� ���Ѵٸ�) pageNum �� 1�� ����
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
		String keyword = request.getParameter("keyword"); //�˻�â�� �Է��� Ű���带 �޾� String keyword �� ����
		//keyword�� ���ٸ� �׳� �Ϲ� �� ���(List)�� ������� ��.
		if (keyword == null) {
			keyword = "";
		}
		//keyword�� ���� �˻��̶��  �˻������� �ۼ���(0),����(1),����(2) �� ���� �Ͽ� int n �� ����
		else

		{
			n = Integer.parseInt(request.getParameter("keyField"));
		}

		BoardDBBean dbPro = BoardDBBean.getInstance(); //�Խ���DBBean ��ü ����
		CommentDBBean cdb = CommentDBBean.getInstance(); //���DBBean ��ü ����

		//�˻��� �ƴ϶�� ��ü ���� ������ ������
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
				�۸��(��ü ��: <span class="count"><%=count%></span>)
			</h1>
		</div>
		<!-- ��ü �� ����  -->
		<table width="700">
			<tr>
				<td align="left">
					<%
						if (session.getAttribute("memId") != null) {
					%> <%=session.getAttribute("memId")%>�� <input type="button"
					value="�α׾ƿ�" onclick="document.location.href='../logon/logout.jsp'"
					<%}%>
				</td>
				<td align="right">
					<%
						if (session.getAttribute("memId") != null) {
					%> 	<a href="writeForm.jsp">�۾���</a>
					<% } else { %>
					 	<a href="../logon/loginForm.jsp">�α���</a>
					<% } %>
				</td>
			</tr>
		</table>

		<div id="content">
			<%
				if (count == 0) { //��ü ���� ������ 0�� ���
			%>
			<p class="noData">�ۼ��� ���� �����ϴ�.</p>
			<% } else { // ��ü���� ������ 0�� �̻��̶�� %>
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
					<th>�� ȣ</th>
					<th>�� ��</th>
					<th>�ۼ���</th>
					<th>�ۼ���</th>
					<th>�� ȸ</th>
					<th>IP</th>
				</tr>

				<%
					try {
							for (int i = 0; i < articleList.size(); i++) {
								BoardDataBean article = (BoardDataBean) articleList.get(i);
								int com_count = cdb.getCommentCount(article.getNum()); //�ۿ� �޸� ����� ������ ������
				%>

				<tr class="listCon">
					<td><%=number--%></td>
					<td class="subject">
						<%
							//int wid = 0; //�亯���� ���� ���� (�鿩����)
							if (article.getRe_level() > 0) { //�亯���̶��...
							//wid = 5*(article.getRe_level());
						%> &nbsp;&nbsp;<span class="reply">��&nbsp;[re]</span>
						<% } else {	}%>
						<% if (com_count > 0) { %>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
						&nbsp;<span class="cmtCount">[<%=com_count%>] </span>
						<% } else { %>
						<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
						<% }
						   if (article.getReadcount() >= 20) { %> <!-- ��ȸ���� 20�� �Ѿ�� Hot ���� �߰� -->
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
						//��ü �������� ���� ����
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
						int startPage = (int) (currentPage / 5) * 5 + 1;
						int pageBlock = 5;
						int endPage = startPage + pageBlock - 1;
						if (endPage > pageCount)
							endPage = pageCount;

						if (startPage > 5) {
							if (keyword.equals("") || keyword == null) {
				%>
				<a href="list.jsp?pageNum=<%=startPage - 5%>" class="spot">[����]</a>
				<%
					} else {
				%>
				<a
					href="list.jsp?pageNum=<%=startPage - 5%>&keyword=<%=keyword%>&n=<%=n%>"
					class="spot">[����]</a>
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
							//����������
							if (keyword.equals("") || keyword == null) {
				%>
				<a href="list.jsp?pageNum=<%=startPage + 5%>" class="spot">[����]</a>
				<%
					} else {
				%>
				<a
					href="list.jsp?pageNum=<%=startPage + 5%>&keyword=<%=keyword%>&n=<%=n%>"
					class="spot">[����]</a>
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
					<option value="0">�ۼ��� </option>
					<option value="1">����</option>
					<option value="2">����</option>
				</select> <input type="text" name="keyword" size="15" maxlength="30" /> <input
					type="submit" value="�� ��" class="btn" />
			</div>
		</form>
		<div id="footer">
			<input type ="button" value="�۾���"
				onclick="javascript:window.location.href='writeForm.jsp'" />
			<input type = "button" value="Home" onclick="javascript:window.location.href='../logon/main.jsp'" /> 	
		</div>
		<%} %>
	</div>
</body>
</html>