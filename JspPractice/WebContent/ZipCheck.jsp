<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*"%>
<%@ page import="web.logon.*"%>

<%
	request.setCharacterEncoding("euc-kr");

	String check = request.getParameter("check");
	String area3 = request.getParameter("area3");
	LogonDBBean manager = LogonDBBean.getInstance();
	ArrayList zipcodeList = manager.zipcodeRead(area3);
	int totalList = zipcodeList.size();
%>

<html>
<head><title>우편번호검색</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function dongCheck() {
		if(document.zipForm.area3.value ==""){
			alert("동이름을 입력하세요.");
			document.zipForm.area3.focus();
			return;
		}
		document.zipForm.submit();
	}
	function sendAddress(zipcode,area1,area2,area3,area4) {
		var address = area1+" "+area2 + " "+area3+" "+area4;
		opener.document.userinput.zipcode.value=zipcode;
		opener.document.userinput.address.value=address;
		self.close();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<center>
<b>우편번호 찾기</b>
<table>
<form name = "zipForm" method="post" action="ZipCheck.jsp">
	<tr>
		<td><br>
		동이름 입력: <input type="text" name = "area3">
		<input type="button" value="검색" onclick="dongCheck();">
		</td>
	</tr>
	<input type="hidden" name = "check" value="n">
</form>
<%
if(check.equals("n")){ //first if
%>
<%
	if(zipcodeList.isEmpty()){
%>
	<tr><td align="center"><br>검색된 결과가 없습니다.</td></tr>
<%
} else {
%>
<tr><td align="center"><br>
	※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td></tr>
<%
	for(int i = 0; i<totalList;i++){
		ZipcodeBean zipBean = (ZipcodeBean)zipcodeList.get(i);
		String tempZipcode = zipBean.getZipcode();
		String tempArea1 = zipBean.getArea1();
		String tempArea2 = zipBean.getArea2();
		String tempArea3 = zipBean.getArea3();
		String tempArea4 = zipBean.getArea4();
%>
<tr><td>
<a href="javascript:sendAddress('<%=tempZipcode %>','<%=tempArea1 %>','<%=tempArea2 %>','<%=tempArea3 %>','<%=tempArea4 %>')">
<%=tempZipcode %>&nbsp;<%=tempArea1 %>&nbsp;<%=tempArea2 %>&nbsp;<%=tempArea3 %>&nbsp;<%=tempArea4 %></a><br>
<%
	} //for end
} // else end
%>
<% 
} // first if end
%>
</td></tr>
<tr><td align="center"><br><a href="javascript:this.close();">닫기</a></td></tr>
</table>
</center>
</body>
</html>