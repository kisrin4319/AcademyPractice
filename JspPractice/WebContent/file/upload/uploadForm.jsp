<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>파일 등록</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body>
<div id ="wrap">
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
	<div id = "content">
		<div class = "uploadForm">
			<dl>
				<dt>파일</dt>
				<dd><input type="file" name = "file" /></dd>
				<dt>설명</dt>
				<dd class="desc"><input type="text" name = "description" /></dd>			
			</dl>
		</div>
	</div>
	<div id = "footer">
		<input type="submit" value="upload" />
	</div>
	</form>
</div>
</body>
</html>