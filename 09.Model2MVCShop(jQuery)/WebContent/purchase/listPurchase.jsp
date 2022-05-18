<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "post").attr("action", "/purchase/listPurchase").submit();
	}
	
	function fndAlertCheck() {
		alert('구매정보를 수정할 수 없는 상태입니다.');
	}

$(function(){
	$("select[name='searchTranCode']").on("change", function(){
		fncGetList(1);
	});
	
	$(".ct_list_pop td:nth-child(1)").on("click", function() {
		var tranNo = $(this).children("input[name='tranNo']").val();
		
		self.location = "/purchase/getPurchase?tranNo="+tranNo;
	});
	
	$(".ct_list_pop td:nth-child(3)").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=purchase";
	});
	
	$(".ct_list_pop td:contains('주문취소')").on("click", function(){
		var tranNo = $(this).children("input[name='tranCode']").val();
		
		self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=4";
	})
	
	$(".ct_list_pop td:contains('물품도착')").on("click", function(){
		var tranNo = $(this).children("input[name='tranCode']").val();
		
		self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3";
	})
	
	$("span[name='page']").on("click", function() {
			var currentPage = $(this).text().trim();
			
			fncGetList(currentPage);
		})
		
		$( "span" ).on("mouseenter", function() {
		 	$(this).stop().animate({ }, 1000 ).css("font-weight", "bold")
		 })
		 	
		$( "span" ).on("mouseleave", function() {
		 	$(this).stop().animate({ }, 1000 ).css("font-weight", "normal")
		})
		
		$("span[name='before']").on("click", function() {
			var currentPage = ${ resultPage.beginUnitPage - 1};
			
			fncGetList(currentPage);
		})
		
		$("span[name='after']").on("click", function() {
			var currentPage = ${resultPage.endUnitPage + 1};
			
			fncGetList(currentPage);
		})
})

	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form>

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
						<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo }"/>
						${i }
				</td>
				<td></td>
				<td align="left">
						<input type="hidden" id="prodNo" name="prodNo" value="${purchase.purchaseProd.prodNo }"/>
						${purchase.purchaseProd.prodName }
				</td>
				<td></td>
				<td align="left">${purchase.tranCount } 개</td>
				<td></td>
				<td align="left">${purchase.receiverName } </td>
				<td></td>
				<td align="left"><fmt:formatNumber value="${ purchase.tranCount * purchase.purchaseProd.price }" type="currency" /></td>
				<td></td>
				<td align="left">
					<input type="hidden" id="tranCode" name="tranCode" value="${purchase.tranNo }"/>
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
						주문취소
					</c:if>
				
					<c:if test="${ tranCode == '2'}" >
						물품도착
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