<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>자료실 목록</title>
<link rel = "stylesheet" type="text/css" href="./css/style.css" />
</head>
<body>
<div id = "wrap">
	<div id = "header">
		<c:if test="${listModel.totalPageCount >0 }">
		${listModel.startRow }-${listModel.endRow }
		<span class="count">[<span class ="spot">${listModel.requestPage }</span> / ${listModel.totalPageCount }]</span>
		</c:if>
	</div>
	<div id = "content">
		<table class ="listForm">
			<colgroup>
				<col width="10%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
		<tr>
			<th>번호</th>
			<th>파일명</th>
			<th>파일크기</th>
			<th>다운로드회수</th>
			<th>다운로드</th>
		</tr>
	<c:choose>
		<c:when test="${listModel.hasPdsItem == false }">
		<tr>
			<td colspan="5" class = "noDate">게시글이 없습니다.</td>
		</tr>
		</c:when>
		<c:otherwise>
			<c:forEach var = "item" items = "${listModel.pdsItemList }">
				<tr class ="listCon">
					<td>${item.id }</td>
					<td class="subject">${item.fileName }</td>
					<td>${item.fileSize }</td>
					<td>${item.downloadCount }</td>
					<td><a href = "./download/download.jsp?id=${item.id }">[DOWNLOAD]</a></td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</table>

	<div class="paging">
		<c:if test="${beginPage>10 }">
		 <c:choose>
		 	<c:when test="${searchn == null || search== null }">
		 	<a href="<c:url value = "list.jsp?p=${beginPage-1 }"/>">이전</a>
		 	</c:when>
		 	<c:otherwise>
		 		<a href="<c:url value = "list.jsp?p=${beginPage-1 }&searchn=${searchn }&search=${search }" />">이전</a>
		 	</c:otherwise>
		  </c:choose>
		</c:if>
		<c:choose>
			<c:when test="${searchn == null || search== null }">
				<c:forEach var ="pno" begin = "${beginPage }" end ="${endPage }">
					<c:choose>
						<c:when test="${listModel.requestPage== pno }">
							<a href="<c:url value = "list.jsp?p=${pno }" />"><span class = "currentPage">[${pno }]</span></a>
						</c:when>
						<c:otherwise>
							<a href="<c:url value = "list.jsp?p=${pno }"/>">[${pno }]</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
		<c:otherwise>
			<c:forEach var="pno" begin="${beginPage}" end="${endPage}">
				<c:choose>
					<c:when test="${listModel.requestPage == pno}">
					<a href="<c:url value="list.jsp?p=${pno}&searchn=${searchn}&search=${search}" />"><span class="currentPage">[${pno}]</span></a>
					</c:when>
					<c:otherwise>
					<a href="<c:url value="list.jsp?p=${pno}&searchn=${searchn}&search=${search}" />">[${pno}]</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
		</c:choose>
			<c:if test="${endPage < listModel.totalPageCount}">
				<c:choose>
					<c:when test="${searchn == null || search == null}">
					<a href="<c:url value="list.jsp?p=${endPage+1}" />">다음</a>
					</c:when>
					<c:otherwise>
					<a href="<c:url value="list.jsp?p=${endPage+1}&searchn=${searchn}&search=${search}" />">다음</a>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
	</div>

	<form action="list.jsp" method="get">
		<div class = "searchWarp">
			<input type="text" name ="search" value="${search }"/>
			<input type="submit" value ="검색" class = "btn" />
		</div>
	</form>
	<div id = "footer"><a href="./upload/uploadForm.jsp">파일첨부</a></div>
</div>
</body>
</html>