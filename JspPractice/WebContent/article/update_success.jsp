<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>�� ����</title>
</head>
<body>
���� �����߽��ϴ�.
<br />
<a href="./list.jsp?p=${param.p }">��Ϻ���</a>
<a href="./read.jsp?articleId=${updateArticle.id }&p=${param.p}">�Խñ� �б�</a>
</body>
</html>