<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>로그인</title>
<link href="css/style.css" rel = "stylesheet" type = "text/css" />
</head>
<body onload="begin()">
<!--  before login -->
<%
	if(session.getAttribute("memId")==null){
%>
	<script type="text/javascript">
	
	function begin() {
		document.myform.id.focus();
	}
	function checkIt() {
		if(!document.myform.id.value){
			alert("아이디를 입력하세요!");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.passwd.value){
			alert("비밀번호를 입력하세요!");
			document.myform.passwd.focus();
			return false;
		}
	}	
	</script>
	
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
<div id="loginWrap">
	<h1>Member Login</h1>
	<form action="loginPro.jsp" method="post" name="myform" onsubmit="return checkIt();">
		<fieldset>
			<legend>로그인</legend>
			<dl>
				<dt>Id</dt>
				<dd><input type="text" name="id" maxlength="10" value="<%=id %>" /></dd>
				<dt>Password</dt>
				<dd><input type="password" name="passwd" maxlength="10" /></dd>
			</dl>
			<div class="btnArea">
				<input type="submit" name="Submit" value="Ok" />
				<input type="reset" value="Reset" />
				<input type="button" value="Join" onclick="javascript:window.location='inputForm.jsp'" />
			</div>
		</fieldset>
	</form>
</div>

<%
	} else {
%>

<!-- after login -->
<div id="loginWrap">
	<h1>Welcome to my world!</h1>
	<div class="afterLogin">
		<p><strong><%= session.getAttribute("memId") %></strong>님 환영합니다.</p>
		<form action="logout.jsp" method="post">
			<div class="btnArea">
				<input type="submit" name="Submit" value="Logout" />
				<input type="button" value="Modify" onclick="javascript:window.location='modify.jsp'" />
			</div>
		</form>
	</div>
</div>

<% } %>
</body>
</html>