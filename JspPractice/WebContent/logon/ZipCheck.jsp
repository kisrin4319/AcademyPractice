<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />
<title>우편번호검색</title>
<link href="css/popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
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
<body>
<div id="zipCheck">
	<h1>우편번호 검색</h1>
<form name = "zipForm" method="post" action="ZipCheck.jsp">
	<p class="desc"> 동이름 입력: <input type="text" name = "area3" /></p>
	<div>
		<input type="button" value="검색" onclick="dongCheck();" />		
		<input type="hidden" name = "check" value="n" />
	</div>			
</form>
<%
if(check.equals("n")){ //first if
%>
<%
	if(zipcodeList.isEmpty()){
%>
	<p class ="desc">검색된 결과가 없습니다.</p>
<%
} else {
%>
	<div class ="spot">
	※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</div>
	<ul>
<%
	for(int i = 0; i<totalList;i++){
		ZipcodeBean zipBean = (ZipcodeBean)zipcodeList.get(i);
		String tempZipcode = zipBean.getZipcode();
		String tempArea1 = zipBean.getArea1();
		String tempArea2 = zipBean.getArea2();
		String tempArea3 = zipBean.getArea3();
		String tempArea4 = zipBean.getArea4();
%>
	<li>
		<a href="javascript:sendAddress('<%=tempZipcode %>','<%=tempArea1 %>','<%=tempArea2 %>','<%=tempArea3 %>','<%=tempArea4 %>')">
			<%=tempZipcode %>&nbsp;<%=tempArea1 %>&nbsp;<%=tempArea2 %>&nbsp;<%=tempArea3 %>&nbsp;<%=tempArea4 %>
		</a>
	</li>
<%
	} //for end
} // else end
%>
	</ul>
<% 
} // first if end
%>
</div>
</body>
</html>