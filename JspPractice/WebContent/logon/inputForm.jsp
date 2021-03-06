<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>회원가입</title>
</head>
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function checkIt(){
		var userinput = eval("document.userinput");
		if(!userinput.id.value){
			alert("아이디를 입력하세요!");
			return false;
		}
		
		if(!userinput.passwd.value){
			alert("비밀번호를 입력하세요!");
			return false;
		}
		if(userinput.passwd.value!= userinput.passwd2.value){
			alert("비밀번호를 동일하게 입력하세요!");
			return false;
		}
		
		if(!userinput.name.value){
			alert("이름을 입력하세요!")
			return false;
		}
		
		if(!userinput.jumin1.value || !userinput.jumin2.value){
			alert("주민등록번호를 입력하세요!");
			return false;
		}
		if(!userinput.zipcode.value){
			alert("우편번호를 입력하세요.");
			return false;
		}
		if(!userinput.address.value){
			alert("주소를 입력하세요.");
			return false;
		}
		if(!userinput.email.value){
			alert("이메일을 입력하세요.");
			return false;
		}
	}
	
	//아이디 중복 여부를 판단
	function openConfirmid(userinput) {
		//아이디를 입력했는지 검사
		if(userinput.id.value==""){
			alert("아이디를 입력하세요.");
			return;
		}
		
		//url과 사용자 입력 id를 조합합니다.
		url = "confirmId.jsp?id="+userinput.id.value;
		
		//새로운 윈도우를 엽니다.
		open(url,"confirm","toolbar=no, location=no,status=no,menubar=no,scrollbars=no,"
				+"resizable=no, width=300,height=200");
	}
	
	function zipCheck() {
		url = "ZipCheck.jsp?check=y";
		open(url,"post","toolbar=no, width=500,height=300,directories=no,status=yes,scrollbars=yes,menubar=no");
	}
</script>
<div id="joinWrap">
	<h1>Member Join</h1>
	<form method="post" action="inputPro.jsp" name="userinput"
		onsubmit="return checkIt()">
		<table>
			<colgroup>
				<col width="25%" />
				<col width="*" />
			</colgroup>
			<tr>
				<th><span class="star">*</span>아이디</th>
				<td><input type="text" name="id" maxlength="10" /> <span
					class="idCheck"><input type="button" name="confirm_id"
						onclick="openConfirmid(this.form)" /></span></td>
			</tr>
			<tr>
				<th><span class="star">*</span>비밀번호</th>
				<td><input type="password" name="passwd" maxlength="10" /></td>
			</tr>
			<tr>
				<th><span class="star">*</span>비밀번호 확인</th>
				<td><input type="password" name="passwd2" maxlength="10" /></td>
			</tr>
			<tr>
				<th><span class="star">*</span>이름</th>
				<td><input type="text" name="name" maxlength="10" /></td>
			</tr>
			<tr>
				<th><span class="star">*</span>주민등록번호</th>
				<td><input type="text" name="jumin1" maxlength="6" /> <span>
						- </span> <input type="text" name="jumin2" maxlength="7" /></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="zipcode" maxlength="7" class="w50" />
					<span class="zipCheck"><input type="button"
						onclick="zipCheck()" /></span> <span class="addr"><input
						type="text" name="address" maxlength="70" class="w300" /></span></td>
			</tr>
			<tr>
				<th><span class="star">*</span>E-Mail</th>
				<td><input type="text" name="email" maxlength="50" class="w300" /></td>
			</tr>
			<tr>
				<th>Blog</th>
				<td><input type="text" name="blog" maxlength="50" class="w300" /></td>
			</tr>
		</table>
		<div class="btnArea">
			<input type="submit" name="confirm" value="Ok" /> <input
				type="reset" name="reset" value="Reset" /> <input type="button"
				value="Cancel" onclick="javascript:window.location='main.jsp'" />
		</div>
	</form>
</div>
</body>
</html>
