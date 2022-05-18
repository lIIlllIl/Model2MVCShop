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
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
	
	function fndAlertCheck() {
		alert('구매정보를 수정할 수 없는 상태입니다.');
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
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td>
			가격정렬  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="searchTranCode" class="ct_input_g" style="width:100px" onchange="javascript:fncGetList(1);">
				<option value="0" ${ ! empty search.searchTranCode && search.searchTranCode == 0 ? "selected" : "" }>전체보기</option>
				<option value="1" ${ ! empty search.searchTranCode && search.searchTranCode == 1 ? "selected" : "" }>구매완료</option>
				<option value="2" ${ ! empty search.searchTranCode && search.searchTranCode == 2 ? "selected" : "" }>배송중</option>
				<option value="3" ${ ! empty search.searchTranCode && search.searchTranCode == 3 ? "selected" : "" }>배송완료</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
		<td colspan="11" >전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage } 페이지</td>		
	</tr>
	
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">구매수량</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매자이름</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">결제금액</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
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
				<td align="left">${purchase.tranCount } 개</td>
				<td></td>
				<td align="left">${purchase.receiverName } </td>
				<td></td>
				<td align="left"><fmt:formatNumber value="${ purchase.tranCount * purchase.purchaseProd.price }" type="currency" /></td>
				<td></td>
				<td align="left">
					${tranCode }. 현재
					
					<c:if test="${ tranCode == '1'}" >
								구매완료
					</c:if>
					<c:if test="${ tranCode == '2'}" >
								배송중
					</c:if>
					<c:if test="${ tranCode == '3'}" >
								배송완료
					</c:if>
					상태 입니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<c:if test="${ tranCode == '1'}" >
						<a href="/updateTranCode.do?tranNo=${purchase.tranNo }&tranCode=4">주문취소</a>
					</c:if>
				
					<c:if test="${ tranCode == '2'}" >
						<a href="/updateTranCode.do?tranNo=${purchase.tranNo }&tranCode=3">물품도착</a>
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

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>