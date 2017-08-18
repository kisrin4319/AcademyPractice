<%@page import="pds.service.PdsItemNotFoundException"%>
<%@page import="pds.service.IncreaseDownloadCountService"%>
<%@page import="pds.file.FileDownloadHelper"%>
<%@page import="pds.service.GetPdsItemService"%>
<%@page import="pds.model.PdsItem"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	int id = Integer.parseInt(request.getParameter("id"));
	try {

		PdsItem item = GetPdsItemService.getInstance().getPdsItem(id);

		//���� ��� �ٿ�ε�� ����
		response.reset();
		//list�� upload�� ���� ���� response��������
		//download response ������ �����ϱ� ���� reset ���ش�.

		String fileName = new String(item.getFileName().getBytes("euc-kr"), "iso-8859-1");
		//���� �̸��� �ùٸ��� ��µǵ��� ��ȯ
		response.setContentType("application/octet-stream");
		//�ٿ�ε带 ���� ������Ÿ�� ����
		response.setHeader("Content-Disposition", "attachment; filename = \"" + fileName + "\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setContentLength((int) item.getFileSize());
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");

		out.clear();
		out = pageContext.pushBody();

		/* 	getOutputStream�� ���� �ܿ��� �ۼ� �ؾ� �ϸ�, jsp ���������� ȣ�� �� ��� ������ �߻��Ѵ�.
			�ذ� ����� ���� out.clear()�� out = pageContext.pushBody()�� getOutputStream ȣ�� ����
			�Է� ���ָ� �ȴ�.
			out�� jsp �������� �ڽ��� ����Ű�� ��.
		 */
		FileDownloadHelper.copy(item.getRealPath(), response.getOutputStream());

		response.getOutputStream().close();

		IncreaseDownloadCountService.getInstance().increaseCount(id);
	} catch (PdsItemNotFoundException e) {
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	}
%>