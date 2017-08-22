<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="imageBoard.util.ImageUtil"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="imageBoard.gallery.Theme"%>
<%@page import="imageBoard.gallery.ThemeManager"%>
<%@page import="imageBoard.fileupload.FileUploadRequestWrapper"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page  errorPage="./error/error_view.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(request,-1,-1 ,"C:\\git\\JspPractice\\WebContent\\imageboard\\temp");
	HttpServletRequest tempRequest = request;
	request = requestWrap;
%>
<jsp:useBean id ="theme" class = "imageBoard.gallery.Theme">
	<jsp:setProperty name = "theme" property="*" />
</jsp:useBean>
<%
	ThemeManager manager = ThemeManager.getInstance();
	Theme oldTheme = manager.select(theme.getId());
	
	if(theme.getPassword()!=null || oldTheme.getPassword().compareTo(theme.getPassword())==0){
			FileItem imageFileItem = requestWrap.getFileItem("imageFile");
			String image = "";
			if(imageFileItem.getSize()>0){
				int idx = imageFileItem.getName().lastIndexOf("\\");
				if(idx == -1){
					idx = imageFileItem.getName().lastIndexOf("/");
				}
				image = imageFileItem.getName().substring(idx+1);
				//이미지를 지정한 경로에 저장
				File imageFile = new File("C:\\git\\JspPractice\\WebContent\\imageboard\\image",image);
				//같은 이름의 파일이름 처리
				if(imageFile.exists()){
					for(int i = 0; true; i++){
						imageFile = new File("C:\\git\\JspPractice\\WebContent\\imageboard\\image",image+"_"+i);
						if(!imageFile.exists()){
							image = image +"_"+i;
							break;
						}
					}
				}
				imageFileItem.write(imageFile);
				
				//썸네일 이미지 생성
				File destFile = new File("C:\\git\\JspPractice\\WebContent\\imageboard\\image",image+".small.jpg");
				ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);
			}
			if(image.equals("")){
				theme.setImage(oldTheme.getImage());
			} else {
				theme.setImage(image);
			}
			manager.update(theme);
%>
<html><head><title>수정</title></head><body>
<c:set var = "search_cond" value ="<%=requestWrap.getParameterValues("search_cond") %>"/>
<c:set var = "pageNo" value ="<%=requestWrap.getParameter("page") %>"/>
<c:set var = "search_key" value ="<%=requestWrap.getParameter("search_key") %>"/>
<form name = "move" method="post">
	<input type="hidden" name ="page" value ="${pageNo }"/>
	<c:forEach var = "searchCond" items="${search_cond }">
	<c:if test="${searchCond =='title' }">
		<input type="hidden" name = "search_cond" value ="title" />
	</c:if>
	<c:if test="${searchCond == 'name' }">
		<input type="hidden" name = "search_cond" value ="name" />
	</c:if>
	</c:forEach>
	<c:if test="${!empty search_key }">
	<input type="hidden" name = "search_key" value ="${search_key }" />
	</c:if>
</form>

<script language="JavaScript">
alert("수정했습니다.");
document.move.action = "list.jsp";
document.move.submit();
</script>
</body></html>
<% } else { %>
<script>
 alert("암호가 다릅니다.");
 history.go(-1);
</script>
<% } %>