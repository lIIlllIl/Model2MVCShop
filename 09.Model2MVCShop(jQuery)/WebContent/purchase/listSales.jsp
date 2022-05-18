<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>�Ǹ� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

function fncGetList(currentPage) {
	$("input[name='currentPage']").val(currentPage);
	$("form").attr("method", "post").attr("action", "/purchase/listSale").submit();
}

function fndAlertCheck() {
	alert('�Ǹ������� ������ �� ���� �����Դϴ�.');
}

$(function() {
	$("select[name='searchTranCode']").on("change", function(){
		fncGetList(1);
	})
	
	$(".ct_list_pop td:nth-child(1)").on("click", function(){
		var tranNo = $(this).children("input[name='tranNo']").val();
		
		self.location = "/purchase/getPurchase?tranNo="+tranNo;
	})
	
	$(".ct_list_pop td:nth-child(3)").on("click", function() {
		var userId = $(this).children("input[name='userId']").val();
		
		self.location = "/user/getUser?userId="+userId;
	})
	
	$(".ct_list_pop td:contains('����ϱ�')").on("click", function(){
		var tranNo = $(this).children("input[name='tranCode']").val();
		
		self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=2";
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
					<td width="93%" class="ct_ttl01">�ǸŸ����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td>
			�����Ȳ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="searchTranCode" class="ct_input_g" style="width:100px">
				<option value="0" ${ ! empty search.searchTranCode && search.searchTranCode == 0 ? "selected" : "" }>��ü����</option>
				<option value="1" ${ ! empty search.searchTranCode && search.searchTranCode == 1 ? "selected" : "" }>���ſϷ�</option>
				<option value="2" ${ ! empty search.searchTranCode && search.searchTranCode == 2 ? "selected" : "" }>�����</option>
				<option value="3" ${ ! empty search.searchTranCode && search.searchTranCode == 3 ? "selected" : "" }>��ۿϷ�</option>
			</select>
		</td>
		<td></td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	
	<tr>
		<td colspan="11" >��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage } ������</td>		
	</tr>
	
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="350">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="250">��������</td>
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
					<input type="hidden" id="userId" name="userId" value="${purchase.buyer.userId }"/>
						${purchase.buyer.userId }
				</td>
				<td></td>
				<td align="left">${purchase.buyer.userName }</td>
				<td></td>
				<td align="left">${purchase.receiverPhone }</td>
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
					���� �Դϴ�.</td>
				<td></td>
				<td align="left">
					<input type="hidden" id="tranCode" name="tranCode" value="${purchase.tranNo }"/>
				<c:if test="${ tranCode == '1'}" >
					����ϱ�
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