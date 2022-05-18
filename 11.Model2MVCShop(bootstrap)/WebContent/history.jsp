<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">



function fncGetList(currentPage){

	var condition = $("select[name='searchCondition']").val();

	if ( condition == '4' && document.detailForm.searchKeyword.value != ""  ) {
//		var price = document.detailForm.searchKeyword.value;
		var price = $("input[name='searchKeyword']").val();
		var co = price.indexOf('~');
		var ch = price.charAt(co + 1);
		var pront = price.substring(0, co);
		var back = price.substring(co + 1);
		
		if ( price.indexOf('~') == -1 ) {
			alert('~ 기호를 추가해서 검색해주세요.');
//			document.getElementById("searchKeyword").focus();
			$( ".input[name='searchKeyword']").focus();
			event.preventDefault();
		} 
		else if ( price.indexOf('~') < 1 || (price.match(/~/g) || []).length != 1 || ch == null || ch == "undefined" || ch == "" ) {
			alert('정확한 범위를 입력해주세요.');
//			document.getElementById("searchKeyword").focus();
			$( "input[name='searchKeyword']").focus();
			event.preventDefault();
		}
		else if ( isNaN(pront) || isNaN(back) ) {
			alert('숫자를 입력해주세요.');
//			document.getElementById("searchKeyword").focus();
			$( "input[name='searchKeyword']").focus();
			event.preventDefault();
		}
		
		else {
//			document.getElementById("currentPage").value = currentPage;
//		   	document.detailForm.submit();
			alert(currentPage)
			$( "input[name='currentPage']" ).val(currentPage);
			$('form').attr("method", "post").attr("action", "/product/history" ).submit();
		}
	}
	else if ( condition == '2' || condition == '3'  ) {
//		var price = document.detailForm.searchKeyword.value;
		var price = $("input[name='searchKeyword']").val();
		
		if ( isNaN(price) ) {
			alert('숫자를 입력해주세요.');
//			document.getElementById("searchKeyword").focus();
			$("input[name='searchKeyword']").focus();
			event.preventDefault();	
		}
		else {
			$( "input[name='currentPage']" ).val(currentPage)
			$('form').attr("method", "post").attr("action", "/product/history" ).submit();
		}
	}
	else if ( condition == '0' ) {
//		var prodNo = document.detailForm.searchKeyword.value;
		var prodNo = $("input[name='searchKeyword']").val();
		
		if ( isNaN(prodNo) ) {
			alert('숫자를 입력해주세요.');
//			document.getElementById("searchKeyword").focus();
			$("input[name='searchKeyword']").focus();
			event.preventDefault();	
		}
		else {
			$( "input[name='currentPage']" ).val(currentPage);
			$('form').attr("method", "post").attr("action", "/product/history" ).submit();
		}
	}
	else {
		$( "input[name='currentPage']" ).val(currentPage);
		$('form').attr("method", "post").attr("action", "/product/history" ).submit();	
	}
}

function fndAlertCheck() {
	alert('상품정보를 수정할 수 없는 상태입니다.');
}

$(function() {
	
	$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
	
	$("input[name='searchKeyword']").on("keydown", function(key){
		if ( key.keyCode == 13 ) {
			fncGetList(1);
		}
	});
	
	$(".ct_btn01:contains('검색')").on("click", function() {
		fncGetList(1);
	});
	
	$(".ct_list_pop td:nth-child(3)").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=cookie";
	});
	
	$("select[name='searchPrice']").on("change", function(){
		fncGetList(1);
	});
	
	$("h7").css("color", "red").css({"font-size":"13px"});
	
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
	
	$(".ct_list_pop td:nth-child(3)").tooltip({
		show: {
			  duration: 0
			} , 
		items : '[data-photo]' , 
		content : function() {
			var photo = $(this).data('photo');
			return '<img src="../images/uploadFiles/'+photo+'" width="80" height="80" />';
		}
	})

});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">${param.menu == "search" ? "상품 목록조회" : "상품관리"  }</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${totalCount } 건수</td>
	</tr>
	
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="170">
		상품명
		<br/>
		<h7>click시 상품 상세보기</h7>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100">가격</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >재고현황</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" >할인여부</td>
		<td class="ct_line02"></td>
		
	</tr>
	
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
		<c:forEach var="event" items="${list }" >
			<c:set var="i" value="${i + 1 }" />
			
			<tr class="ct_list_pop">
				<c:set var="images" value="${fn:split(event.product.fileName , '/') }" />
				<td align="center">${i }</td>
				<td></td>
				
				<td align="left" data-photo="${images[0] }">
					<input type="hidden" id="prodNo" name="prodNo" value="${event.product.prodNo }"/>
					${event.product.prodName }
				</td>
				<td></td>
				
				<td align="left">
				<fmt:formatNumber value="${event.product.price }" type="currency" />
				</td>
				<td></td>
			<!--  
				<c:set var="images" value="${fn:split(event.product.fileName , '/') }" />
					<td align="left">
					<c:forEach var="image" items="${images }" >
						<img src="../images/uploadFiles/${image}" width="100" height="100" />
					</c:forEach>
					</td>
					<td></td>
			-->	
				<td align="left">
					<c:choose>
						<c:when test="${event.product.prodCount == 0 }" >
							재고없음
						</c:when>
						<c:otherwise>
							판매중 재고 : ${event.product.prodCount } 개
						</c:otherwise>
					</c:choose>
				</td>
				<td></td>
				
				<td align="left">
					<c:if test="${event.product.checkEvent == 1 }" >
						할인중
					</c:if>
				</td>
			</tr>
			
			

			<tr>
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
			
			</c:forEach>
</table>

</form>
</div>

</body>
</html>