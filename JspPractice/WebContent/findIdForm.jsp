<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="../view/color.jsp"%>
<html>
<head><title>���̵� ã��</title></head>
<link href="style.css" rel="stylesheet" type="text/css">
<body bgcolor="<%=bodyback_c %>">

<form method="post" action="FindId.jsp">
 <table width="260" border="1" cellspacing="0" cellpadding="3" align = "center">
 	<tr height="30">
 	<td width="110" align="center" bgcolor="<%=value_c %>">
 		<font size="+1" ><b>�̸���</b></font></td>
 	 <td width="150" bgcolor="<%=value_c %>" align="center">
 	 	<input type="text" name = "email" size ="20">
 	 </td>
		</tr>
 </form>
 </body>
</html>