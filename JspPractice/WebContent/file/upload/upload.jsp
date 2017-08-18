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
	//���۹��� request�� multipart/form-data�� �����ߴ����� ���θ� ��ȯ�޾� �ʱ�ȭ.
	if (!isMultipart) { //request�� ������ ����� �߸��Ǿ����� ó�����.
		response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		//��ȿ���� ���� request�� �޾����� �˸��� �����ڵ带 �߻�.(400)
		return;
	}
	//fileitem ��ü�� �����ϴ� Ŭ���� DiskFileFactory�� ��ü ����.
	DiskFileItemFactory factory = new DiskFileItemFactory();
	//���ε� ��û�� ó���ϴ� ServletFileUpload�� ��ü ����.
	ServletFileUpload upload = new ServletFileUpload(factory);
	//���ε� ��û �����Ͽ� ��ü�� ��� list�÷������� �����ش�.
	List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
	//9.0�������� �ƴ��� �𸣰ڴµ� FileUpload�� �Ķ���Ͱ� �ٲ����.
	//���� new ServletRequestContext(request))�ν� �߰��ؾ� �Ѵ�.
	AddRequest addRequest = new AddRequest();
	Iterator<FileItem> iter = items.iterator(); //iterator�� �̿��ؼ� ��簪�� �����´�.
	while (iter.hasNext()) {
		FileItem item = iter.next();
		if (item.isFormField()) { //form�������� ���.
		//item�� ����Ȱ��� ���ϵ��������� �׿������� �Ǵ��Ѵ�.
		//form�������� ���� true ������ ���� false�� ��ȯ.
			String name = item.getFieldName(); //field�̸��� �޾� ����.
			if (name.equals("description")) {  //������ ��� ����. 
				String value = item.getString("euc-kr"); //������ ������ value�� ����.
				addRequest.setDescription(value); // addRequest��ü�� ���� �����Ѵ�.
			}
		} else {
			String name = item.getFieldName(); //field�̸��� �޾� ����.
			if (name.equals("file")) { //�ش� field�̸��� file�� ��� ����. 
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
<title>���ε� ����</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body>

<div id = "wrap" class = "descForm">
	<p><%=pdsItem.getFileName() %> ������ ���ε� �߽��ϴ�.</p>
	<div id = "footer">
		<a href = "../list.jsp">���</a>
	</div>
</div>
</body>
</html>