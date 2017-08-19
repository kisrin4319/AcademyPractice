<?xml version="1.0" encoding="euc-kr" ?>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@ page import="imageBoard.gallery.ThemeManager"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="imageBoard.util.ImageUtil"%>
<%@ page import="java.io.File"%>
<%@ page import="imageBoard.fileupload.FileUploadRequestWrapper"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page errorPage="./error/error_view.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	FileUploadRequestWrapper requestWrap = new FileUploadRequestWrapper(request,-1,-1,"C:\\git\\JspPractice\\WebContent\\temp");
	HttpServletRequest tempRequest = request;
	request = requestWrap;
%>
<jsp:useBean id = "theme" class ="imageBoard.gallery.Theme">
	<jsp:setProperty name ="theme" property="*"/>
</jsp:useBean>
<%
	FileItem imageFileItem = requestWrap.getFileItem("imageFile");
	String image ="";
	if(imageFileItem.getSize() >0){
		image = Long.toString(System.currentTimeMillis());
		
		//이미지를 지정한 경로에 저장
		File imageFile = new File("C:\\Java\\App\\JspPractice\\JspPractice\\WebContent\\image",image);
		//같은 이름의 파일이름 처리
		if(imageFile.exists()){
			for(int i = 0; true; i++){
				imageFile = new File("C:\\Java\\App\\JspPractice\\JspPractice\\WebContent\\image",image+"_"+i);
				if(!imageFile.exists()){
					image = image +"_"+i;
					break;
				}
			}
		}
		imageFileItem.write(imageFile);
		
		//썸네일 이미지 생성
		File destFile = new File("C:\\Java\\App\\JspPractice\\JspPractice\\WebContent\\image",image+".small.jpg");
		ImageUtil.resize(imageFile, destFile, 50, ImageUtil.RATIO);
	}
	theme.setRegister(new Timestamp(System.currentTimeMillis()));
	theme.setImage(image);
	
	ThemeManager manager = ThemeManager.getInstance();
	manager.insert(theme);

%>
<script>
	alert("새로운 이미지를 등록했습니다.");
	location.href = "list.jsp";
</script>