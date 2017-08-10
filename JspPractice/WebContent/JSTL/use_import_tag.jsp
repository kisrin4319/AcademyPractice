<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("euc-kr");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title></title>
</head>
<body>
 <c:choose>
 	<c:when test="${param.type =='flickr }">
 		<%--http://www.flickr.com/search?f=hp&q=보라매공원 --%>
 			<c:import url="https://www.flickr.com/search">
 				<c:param name="f" value ="hp" />
 				<c:param name="q" value ="보라매공원"/>
 			</c:import>
 	</c:when>
 	<c:when test="${param.type=='youtube' }">
 		<c:import url="https://www.youtube.com/results">
 			<c:param name="search_query" value="ryu"/>
 		</c:import>
 	</c:when>
 	<c:otherwise>
 		<c:import url="use_import_tag_help.jsp">
 			<c:param name="message" value = "선택해주세요."/>
 		</c:import>
 	</c:otherwise>	
 </c:choose>
</body>
</html>