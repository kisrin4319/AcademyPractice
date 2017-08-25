<?xml version="1.0" encoding="euc-kr" ?>
<%@ page import ="imageBoard.gallery.Theme"%>
<%@ page import ="imageBoard.gallery.ThemeManager"%>
<%@ page import ="imageBoard.gallery.ThemeManagerException" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String parentId = request.getParameter("parentId");
	String title = "";
	Theme theme = null;
	
	if(parentId!= null){
		ThemeManager manager = ThemeManager.getInstance();
		theme = manager.select(Integer.parseInt(parentId));
		if(theme!=null){
			title = "re:"+theme.getTitle();
		}
	}
%>

<c:set var = "theme" value ="<%=theme %>" />
<script language="JavaScript">
function validate(form){
	if(form.title.value == ""){
		alert("������ �Է��ϼ���.");
		return false;
	} else if(form.name.value == ""){
		alert("�̸��� �Է��ϼ���.");
		return false;
	} else if(form.password.value == "")
    {
           alert("��ȣ�� �Է��ϼ���.");
           return false;
    } else if(form["parentId"] == null && form.imageFile.value ==""){
		alert("�̹��� ������ �����ϼ���.");
		return false;
	} else if(form.content.value ==""){
		alert("������ �Է��ϼ���.");
		return false;
	}
}
</script>

<form action="./write.jsp" method="post" enctype="multipart/form-data" onsubmit="return validate(this)">
	<input type="hidden" name = "levels" value = "${theme.levels+1 }" />
	<c:if test="${!empty param.groupId }">
		<input type="hidden" name ="groupId" value ="${param.groupId }" />
	</c:if>
	<c:if test="${!empty param.parentId }">
		<input type="hidden" name = "parentId" value ="${param.parentId }" />
	</c:if>
	<table width="100%" border="1" cellpadding="1" cellspacing="0">
		<tr>
			<td>����</td>
			<td><input type ="text" name ="title" size="40" value="<%=title%>" /></td>
		</tr>
		<tr>
			<td>�̸�</td>
			<td><input type ="text" name ="name" size="10" value="" /></td>
		</tr>
			<tr>
			<td>�̸���</td>
			<td><input type ="text" name ="email" size="10" value="" /></td>
		</tr>
		<tr>
			<td>��ȣ</td>
			<td><input type ="password" name ="password" size="10" value="" /></td>
		</tr>
		<tr>
			<td>�̹���</td>
			<td><input type ="file" name ="imageFile" /></td>
		</tr>
		<tr>
			<td>����</td>
			<td><textarea name ="content" cols="40" row="8" ></textarea></td>
		</tr>
		<tr>
			<td colspan = "2"><input type ="submit" value="���" /></td>
		</tr>
	</table>
</form>