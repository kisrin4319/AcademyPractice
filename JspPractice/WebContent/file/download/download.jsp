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

		//응답 헤더 다운로드로 설정
		response.reset();
		//list와 upload로 인해 쌓인 response정보들을
		//download response 정보로 세팅하기 위해 reset 해준다.

		String fileName = new String(item.getFileName().getBytes("euc-kr"), "iso-8859-1");
		//파일 이름이 올바르게 출력되도록 변환
		response.setContentType("application/octet-stream");
		//다운로드를 위한 컨테츠타입 설정
		response.setHeader("Content-Disposition", "attachment; filename = \"" + fileName + "\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setContentLength((int) item.getFileSize());
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");

		out.clear();
		out = pageContext.pushBody();

		/* 	getOutputStream은 서블릿 단에서 작성 해야 하며, jsp 페이지에서 호출 할 경우 에러가 발생한다.
			해결 방법은 위에 out.clear()와 out = pageContext.pushBody()를 getOutputStream 호출 전에
			입력 해주면 된다.
			out은 jsp 웹페이지 자신을 가리키는 것.
		 */
		FileDownloadHelper.copy(item.getRealPath(), response.getOutputStream());

		response.getOutputStream().close();

		IncreaseDownloadCountService.getInstance().increaseCount(id);
	} catch (PdsItemNotFoundException e) {
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	}
%>