<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 
<%@ page import="java.util.*"  %>

<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>

<%
	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");
	
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	
	String check = request.getParameter("menu");
%>
--%>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
	
	function fndAlertCheck() {
		alert('���������� ������ �� ���� �����Դϴ�.');
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
	
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td>
			��������  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="searchTranCode" class="ct_input_g" style="width:100px" onchange="javascript:fncGetList(1);">
				<option value="0" ${ ! empty search.searchTranCode && search.searchTranCode == 0 ? "selected" : "" }>��ü����</option>
				<option value="1" ${ ! empty search.searchTranCode && search.searchTranCode == 1 ? "selected" : "" }>���ſϷ�</option>
				<option value="2" ${ ! empty search.searchTranCode && search.searchTranCode == 2 ? "selected" : "" }>�����</option>
				<option value="3" ${ ! empty search.searchTranCode && search.searchTranCode == 3 ? "selected" : "" }>��ۿϷ�</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td colspan="11" >��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage } ������</td>		
	</tr>
	
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">���ż���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">�������̸�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">�����ݾ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
	</tr>
	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list }" >
		<c:set var="i" value="${i + 1 }" />
		<c:set var="tranCode" value="${fn:trim(purchase.tranCode) }" />
			<tr class="ct_list_pop">
				<td align="center">
						<a href="/purchase/getPurchase?tranNo=${purchase.tranNo }">${i }</a>
				</td>
				<td></td>
				<td align="left">
						<a href="/purchase/getProduct?prodNo=${purchase.purchaseProd.prodNo }&menu=purchase">${purchase.purchaseProd.prodName }</a>
				</td>
				<td></td>
				<td align="left">${purchase.tranCount } ��</td>
				<td></td>
				<td align="left">${purchase.receiverName } </td>
				<td></td>
				<td align="left"><fmt:formatNumber value="${ purchase.tranCount * purchase.purchaseProd.price }" type="currency" /></td>
				<td></td>
				<td align="left">
					${tranCode }. ����
					
					<c:if test="${ tranCode == '1'}" >
								���ſϷ�
					</c:if>
					<c:if test="${ tranCode == '2'}" >
								�����
					</c:if>
					<c:if test="${ tranCode == '3'}" >
								��ۿϷ�
					</c:if>
					���� �Դϴ�.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<c:if test="${ tranCode == '1'}" >
						<a href="/updateTranCode.do?tranNo=${purchase.tranNo }&tranCode=4">�ֹ����</a>
					</c:if>
				
					<c:if test="${ tranCode == '2'}" >
						<a href="/updateTranCode.do?tranNo=${purchase.tranNo }&tranCode=3">��ǰ����</a>
					</c:if>
					</td>

			</tr>
			
			<tr>
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
	
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>