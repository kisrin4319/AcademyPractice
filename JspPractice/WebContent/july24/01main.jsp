<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head>
<title>main</title>
</head>
<body>
	01main.jsp 에서 생성한 내용.
	
	<jsp:include page="02sub.jsp" flush="false" /> <!-- main 페이지 내에서 sub페이지를 불러온다.  -->

	include 이후의 내용.
</body>
</html>