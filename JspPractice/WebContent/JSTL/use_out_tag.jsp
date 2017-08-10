<?xml version="1.0" encoding="EUC-KR" ?>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>소스 보기</title>
</head>
<body>

<%
	FileReader reader = null;
	try{
		String path = request.getParameter("path");
		reader = new FileReader(getServletContext().getRealPath(path));
%>
<pre>
소스 코드 =<%=path %>
<c:out value="<%=reader %>" escapeXml="true"/>
</pre>
<%
	} catch(IOException ex){
%>
에러 : <%= ex.getMessage() %>
<%
	} finally {
		if(reader!=null) try{ reader.close();} catch(IOException ex){}
	}

%>
</body>
</html>