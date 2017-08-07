<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="web.board.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="cmt" scope ="page" class = "web.board.CommentDataBean">
	<jsp:setProperty name = "cmt" property ="*"/>
</jsp:useBean>

<%
	CommentDBBean comt = CommentDBBean.getInstance();
	cmt.setReg_date(new Timestamp(System.currentTimeMillis()));
	cmt.setIp(request.getRemoteAddr());
	comt.insertComment(cmt);
	
	String content_num 	= request.getParameter("content_num");
	String p_num		= request.getParameter("p_num");
	String url			= "content.jsp?num="+content_num+"&pageNum="+p_num;
	response.sendRedirect(url);
%>