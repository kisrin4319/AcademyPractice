<%@page import="pds.model.PdsItemListModel"%>
<%@page import="pds.service.ListPdsItemService"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

	String pageNumberString = request.getParameter("p"); //페이지 번호를 위해서 쓰기 위한 파라미터 p
	String search = request.getParameter("search") == null ? null : request.getParameter("search");
	//keyword가 존재 하는가? 검색 OR NOT 판단
	
	
	int pageNumber = 1;
	if(pageNumberString!=null && pageNumberString.length()>0){
		pageNumber = Integer.parseInt(pageNumberString);
	}
	 //기본 페이지는 1페이지이고 페이지 파라미터 p가 넘어온다면 그것으로 설정
	ListPdsItemService listService = ListPdsItemService.getInstacne();
	 //ListPdsItemService listService로 객체 생성
	PdsItemListModel itemListModel;
	
	 
	//keyword가 있을 경우 없을 경우를 나누어서  itemListModel을 세팅한다. 
	if(search == null){
		itemListModel = listService.getPdsItemList(pageNumber);
	} else {
		itemListModel = listService.getPdsItemList(pageNumber,search);
	}
	
	//List를 넘겨주기 위해서 
	request.setAttribute("listModel", itemListModel);
	
	if(itemListModel.getTotalPageCount() >0){
		int beginPageNumber = (itemListModel.getRequestPage()-1) / 10 * 10 +1;
		int endPageNumber = beginPageNumber + 9;
		if (endPageNumber > itemListModel.getTotalPageCount()) {
			endPageNumber = itemListModel.getTotalPageCount();
		}
		request.setAttribute("beginPage", beginPageNumber);
		request.setAttribute("endPage", endPageNumber);
	}
%>

<jsp:forward page="listView.jsp" />