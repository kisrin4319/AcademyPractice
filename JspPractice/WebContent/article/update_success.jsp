<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>글 수정</title>
</head>
<body>
글을 수정했습니다.
<br />
<a href="./list.jsp?p=${param.p }">목록보기</a>
<a href="./read.jsp?articleId=${updateArticle.id }&p=${param.p}">게시글 읽기</a>
</body>
</html>