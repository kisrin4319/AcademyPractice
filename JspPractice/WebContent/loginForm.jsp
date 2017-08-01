<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file = "../view/color.jsp"%>
<html>
<head><title>로그인</title></head>
<link href="style.css" rel = "stylesheet" type = "text/css">

	<script type="text/javascript">
	
	function begin() {
		documetn.myform.id.focus();
	}
	function checkIt() {
		if(!document.myform.id.value){
			alert("이름을 입력하지 않으셨습니다.");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.passwd.value){
			alert("비밀번호를 입력하지 않으셨습니다.");
			document.myform.passwd.focus();
			return false;
		}
	}	
	</script>
<body onload="begin()" bgcolor="<%=bodyback_c%>">
<form name="myform" action="loginPro.jsp" method="post" onsubmit="return checkIt()">
<table cellspacing ="1" cellpadding="1" width ="260" border="1" align="center">
	<tr height="30">
		<td colspan="2" align="middle" bgcolor="<%=title_c %>"><strong>회원로그인</strong></td></tr>
	<tr height="30">
		<td width="110" bgcolor="<%=title_c %>" align="center">아이디 <input type = "checkbox" value="IS"></td>
		<td width="150" bgcolor="<%=value_c %>" align="center">
		<%
				Cookie[] cookie = request.getCookies();
				String id = "";
				if(cookie!=null){
					for(Cookie cookies : cookie){
						if(cookies.getName().equals("id"))
							id = cookies.getValue();
						}
				}				
		%>
			<input type="text" name = "id" size = "15" maxlength="12" value="<%=id %>"></td>
	</tr>
	
	<tr height="30">
		<td width="110" bgcolor="<%=title_c %>" align="center">비밀번호</td>
		<td width="150" bgcolor="<%=value_c %>" align="center">
			<input type = "password" name = "passwd" size ="15" maxlength="12"></td>
	</tr>
	
	<tr height="30">
	<td colspan="2" align="middle" bgcolor="<%=title_c %>">
		<input type = "submit" value = "로그인">
		<input type="reset" value = "다시입력">
		<input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'"></td>
	</tr>
</table>
</form>
</body>
</html>