<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/plain; charset=euc-kr" pageEncoding="euc-kr"%>

<%
	InputStream is = null;
	out.print("[");
	out.print(request.getContentType());
	out.print("]");
	try {
		is = request.getInputStream();
		int data = -1;
		
		while((data = is.read())!= -1){
			out.print((char)data);
		}
	} finally {
		if(is!=null) try{ is.close(); } catch(IOException ex) {}
	}
%>