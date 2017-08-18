<%@page import="pds.model.PdsItemListModel"%>
<%@page import="pds.service.ListPdsItemService"%>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

	String pageNumberString = request.getParameter("p"); //������ ��ȣ�� ���ؼ� ���� ���� �Ķ���� p
	String search = request.getParameter("search") == null ? null : request.getParameter("search");
	//keyword�� ���� �ϴ°�? �˻� OR NOT �Ǵ�
	
	
	int pageNumber = 1;
	if(pageNumberString!=null && pageNumberString.length()>0){
		pageNumber = Integer.parseInt(pageNumberString);
	}
	 //�⺻ �������� 1�������̰� ������ �Ķ���� p�� �Ѿ�´ٸ� �װ����� ����
	ListPdsItemService listService = ListPdsItemService.getInstacne();
	 //ListPdsItemService listService�� ��ü ����
	PdsItemListModel itemListModel;
	
	 
	//keyword�� ���� ��� ���� ��츦 �����  itemListModel�� �����Ѵ�. 
	if(search == null){
		itemListModel = listService.getPdsItemList(pageNumber);
	} else {
		itemListModel = listService.getPdsItemList(pageNumber,search);
	}
	
	//List�� �Ѱ��ֱ� ���ؼ� 
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