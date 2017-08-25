<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
	pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 1L);
	String keyword = (String)request.getParameter("keyword");
%>
<head>
<title>게시글 목록</title>
</head>
<body>	
	<table border="1">
		<c:if test="${listModel.totalPageCount > 0}">
			<tr>
				<td colspan="5">${listModel.startRow}-${listModel.endRow}
					[${listModel.requestPage}/${listModel.totalPageCount}]</td>
			</tr>
		</c:if>
		<tr>
			<td>글 번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		<c:choose>
			<c:when test="${listModel.hasArticle == false}">
				<tr>
					<td colspan="5">게시글이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="article" items="${listModel.articleList}">
					<tr>
						<td>${article.id }</td>
						<td><c:if test="${article.level >0}">
								<c:forEach begin="1" end="${article.level}">-</c:forEach>&gt;
    						</c:if>
     						<c:set var="query" value="articleId=${article.id }&p=${listModel.requestPage}" />
     						<a href="<c:url value="./read.jsp?${query}"/>">	${article.title } </a></td>
						<td>${article.writerName }</td>
						<td>${article.postingDate }</td>
						<td>${article.readCount }</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">			
						<c:if test="${beginPage > 10 }">
							<a href="<c:url value="./list.jsp?p=${beginPage-1}"/>">이전</a>
						</c:if>
						<c:if test="${keyword == null }">
						<c:forEach var="pno" begin="${beginPage+1}" end="${endPage}">
							<a href="<c:url value="./list.jsp?p=${pno}"/>">[${pno}]</a>
						</c:forEach>
						</c:if>
						<c:if test="${keyword!= null }">
					
						<c:forEach var="pno" begin="${beginPage+1}" end="${endPage}">							
							<a href="<c:url value="./list.jsp?p=${pno }&keyField=${keyField}&keyword=${keyword}"/>">[${pno}]</a>
						</c:forEach>						
						</c:if>						
						<c:if test="${endPage <listModel.totalPageCount}">
							<a href="<c:url value="./list.jsp?p=${endPage + 1}"/>">다음</a>
						</c:if>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>

		<tr>
			<td colspan="5"><a href="writeForm.jsp">글쓰기</a></td>
		</tr>
	</table>
	 <form action="list.jsp">
	 <select name="keyField">
	 	<option value="0">작성자 </option>
		<option value="1">제목</option>
		<option value="2">내용</option>
	 </select>
		 <input type="text" name="keyword" size="15" maxlength="30" />
		 <input type="submit" value="검 색" />
	 </form>
</body>
</html>