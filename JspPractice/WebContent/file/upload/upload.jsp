<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="pds.service.AddPdsItemService"%>
<%@page import="pds.model.PdsItem"%>
<%@page import="pds.file.FileSaveHelper"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="pds.model.AddRequest"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	//전송받은 request가 multipart/form-data로 전송했는지의 여부를 반환받아 초기화.
	if (!isMultipart) { //request가 전송한 방법이 잘못되었을때 처리방법.
		response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		//유효하지 않은 request를 받았음을 알리는 상태코드를 발생.(400)
		return;
	}
	//fileitem 객체를 생성하는 클래스 DiskFileFactory의 객체 생성.
	DiskFileItemFactory factory = new DiskFileItemFactory();
	//업로드 요청을 처리하는 ServletFileUpload의 객체 생성.
	ServletFileUpload upload = new ServletFileUpload(factory);
	//업로드 요청 분할하여 객체에 담아 list컬렉션으로 돌려준다.
	List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
	//9.0에러인지 아닌지 모르겠는데 FileUpload의 파라미터가 바뀌었다.
	//따라서 new ServletRequestContext(request))로써 추가해야 한다.
	AddRequest addRequest = new AddRequest();
	Iterator<FileItem> iter = items.iterator(); //iterator를 이용해서 모든값을 가져온다.
	while (iter.hasNext()) {
		FileItem item = iter.next();
		if (item.isFormField()) { //form데이터일 경우.
		//item에 저장된값이 파일데이터인지 그외인지를 판단한다.
		//form데이터의 경우는 true 파일의 경우는 false를 반환.
			String name = item.getFieldName(); //field이름을 받아 저장.
			if (name.equals("description")) {  //설명일 경우 진입. 
				String value = item.getString("euc-kr"); //설명의 내용을 value에 저장.
				addRequest.setDescription(value); // addRequest객체에 값을 저장한다.
			}
		} else {
			String name = item.getFieldName(); //field이름을 받아 저장.
			if (name.equals("file")) { //해당 field이름이 file인 경우 진입. 
				String realPath = FileSaveHelper.save("C:\\Java\\Framework\\pds", item.getInputStream());
				addRequest.setFileName(item.getName());
				addRequest.setFileSize(item.getSize());
				addRequest.setRealPath(realPath);
			}
		}
	}
	PdsItem pdsItem = AddPdsItemService.getInstance().add(addRequest);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>업로드 성공</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body>

<div id = "wrap" class = "descForm">
	<p><%=pdsItem.getFileName() %> 파일을 업로드 했습니다.</p>
	<div id = "footer">
		<a href = "../list.jsp">목록</a>
	</div>
</div>
</body>
</html>