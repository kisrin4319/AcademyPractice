<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<head>
<title>MultiPart 홈</title></head>
<body>
<form action="multipart_data.jsp" method="post" enctype="multipart/form-data">
text1 : <input type="text" name = "text1" /> <br />
file1 : <input type="file" name = "file1" /> <br />
file2 : <input type="file" name = "file2" /> <br />
<input type="submit" value ="전송" />
</form>
</body>
</html>