<?xml version="1.0" encoding="EUC-KR" ?>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% String cp = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<head>
<title>numberFormat 태그 사용</title>
</head>
<body>
<c:set var = "price" value="10000" />
<fmt:formatNumber value="${price }" type="number" var="numberType" />
<br />
통화 : <fmt:formatNumber  value ="${price }" type="currency" currencySymbol="원"/>
<br />
퍼센트 : <fmt:formatNumber value="${price }" type="percent" groupingUsed="false" />
<br />
숫자 : ${numberType }
<br />
패턴 : <fmt:formatNumber value="${price }" pattern="00000000.00" />
</body>
</html>