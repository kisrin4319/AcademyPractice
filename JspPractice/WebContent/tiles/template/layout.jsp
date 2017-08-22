<?xml version="1.0" encoding="euc-kr" ?>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "tiles" uri ="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><tiles:getAsString name ="title" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
</head>
<body>
	<table width="100%" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td colspan="2">
			<tiles:insertAttribute name = "header" />
			</td>		
		</tr>
		<tr>
			<td valign="top"><tiles:insertAttribute name = "menu" /></td>
			<td valign="top"><tiles:insertAttribute name ="body" /></td>
		</tr>
		<tr>
			<td colspan="2">
			<tiles:insertAttribute name = "footer" />
			</td>
		</tr>
	</table>
</body>
</html>