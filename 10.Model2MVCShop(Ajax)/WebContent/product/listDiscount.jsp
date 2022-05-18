<%@ page contentType="text/html; charset=euc-kr" %>

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
			$( "input[name='currentPage']" ).val(currentPage);
			$('form').attr("method", "post").attr("action", "/product/listDiscount" ).submit();
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
			$('form').attr("method", "post").attr("action", "/product/listDiscount" ).submit();
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
			$('form').attr("method", "post").attr("action", "/product/listDiscount" ).submit();
		}
	}
	else {
		$( "input[name='currentPage']" ).val(currentPage);
		$('form').attr("method", "post").attr("action", "/product/listDiscount" ).submit();	
	}
}

$(function(){
	$(".ct_btn01:contains('검색')").on("click", function(){
		fncGetList(1);
	});
	
	$("input[name='searchKeyword']").on("keydown", function(key){
		if ( key.keyCode == 13 ) {
			fncGetList(1);
		}
	});
	
	$("select[name='searchPrice']").on("change", function(){
		fncGetList(1);
	});
	
	$(".ct_list_pop td:nth-child(3)").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		console.log(prodNo);

		$.ajax(
				{
					url : "/product/json/getProduct/"+prodNo , 
					method : "get" , 
					dataType : "json" , 
					headers : {
						"Accept" : "application/json" , 
						"Content-Type" : "application/json"
					} , 
					success : function( JSONData, status ) {
						var displayValue = 	"<h3>" + 
											"상품명 : " + JSONData.product.prodName + "<br/>" + 
											"상세설명 : " + JSONData.product.prodDetail + "<br/>" + 
											"<br/><br/>" + "<span name='saw'>상세보기</span></h3>"
				
						$("h3").remove();
						$("#"+prodNo+"").html(displayValue);
						
						$("span[name='saw']").on("click", function() {
							self.location = "/product/getProduct?prodNo="+JSONData.product.prodNo+"&menu=dcCheck";
						})						
					}
				}
		)
	});
	
	$(".ct_list_pop:nth-child(3n+5)" ).css("background-color" , "whitesmoke");
	// console.log ( $(".ct_list_pop:nth-child(7)" ).html() );
	// 3 , 5,  7
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
	

	$("select[name='searchCondition']").on("change", function(){
		if ( $("select[name='searchCondition']").val() == '1' ) {
			$("input[name='searchKeyword']").autocomplete( "enable" );
		}
		
		if ( $("select[name='searchCondition']").val() != '1' ) {
			$("input[name='searchKeyword']").autocomplete( "disable" );
		}

	})
	
	
		$("input[name='searchKeyword']").autocomplete({
			
			source : function( request , response ) {
				var searchCondition = $("select[name='searchCondition']").val();
				var type = '';
				var restUrl = "/product/json/enterProduct";
				
				
				if ( searchCondition == '1' ) {
					type = "prodName";
				}
				
				$.ajax(
					{
						url : restUrl , 
						method : "post" , 
						dataType : "json" , 
						headers : {
							"Accept" : "application/json" , 
							"Content-Type" : "application/json"
						} , 
						data : JSON.stringify({ 
							dataName : request.term , 
							dataType : type 
						}) , 
						success : function( result ) {
							response (
								$.map(result , function(item){
									return {
										label : item ,
										value : item
									}
								})	
							);
						}
					}	
				)
			}
		});
	
		
})

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listDiscount" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">할인 현황</td>
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
		<td>
			가격정렬  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="searchPrice" id="searchPrice" class="ct_input_g" style="width:100px">
				<option value="0" ${ ! empty search.searchPrice && search.searchPrice == 0 ? "selected" : "" }>번호정렬</option>
				<option value="1" ${ ! empty search.searchPrice && search.searchPrice == 1 ? "selected" : "" }>오름차순</option>
				<option value="2" ${ ! empty search.searchPrice && search.searchPrice == 2 ? "selected" : "" }>내림차순</option>
			</select>
		</td>

		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:150px" >
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>상품명</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>상품가격-이하</option>
				<option value="3" ${ ! empty search.searchCondition && search.searchCondition == 3 ? "selected" : "" }>상품가격-이상</option>
				<option value="4" ${ ! empty search.searchCondition && search.searchCondition == 4 ? "selected" : "" }>상품가격-범위</option>
			</select>
					<input 	type="text" name="searchKeyword" id="searchKeyword"
							value="${! empty search.searchKeyword ? search.searchKeyword : ""}" class="ct_input_g" 
							style="width:200px; height:20px"  />		
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="17" >전체 ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage } 페이지</td>
	</tr>
	
	<tr>
		<td class="ct_list_b" width="80">상품번호</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="130">
		상품명
		<br>
		<h7>click 시 상품 상세보기</h7>
		</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100">사진</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >원가</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >할인가</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >할인율</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="50" >할인기간</td>	
		<td class="ct_line02"></td>

		<td class="ct_list_b" width="250" >상태</td>	
		<td class="ct_line02"></td>
	</tr>
	
	<c:set var="i" value="0" />
		<c:forEach var="event" items="${list }" >
			<c:set var="i" value="${i + 1 }" />
			
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
			<fmt:parseDate  value="${event.startDate}" pattern="yyyy-MM-dd" var="startDate" />	
			<fmt:parseDate  value="${event.endDate}" pattern="yyyy-MM-dd" var="endDate" />	
					
			<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" var="start"/>
			<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" var="end"/>
			
			<tr class="ct_list_pop">
				<td>${event.product.prodNo}</td>
				<td></td>
				
				<td>${event.product.prodName}
				<input type="hidden" id="prodNo" name="prodNo" value="${event.product.prodNo }"/>
				</td>
				<td></td>
				
				<td><img src="/images/uploadFiles/${event.product.fileName}" width="100" height="100" /></td>
				<td></td>
				
				<td><fmt:formatNumber value="${event.product.costPrice }" type="currency" /></td>
				<td></td>
				
				<td><fmt:formatNumber value="${event.product.costPrice * event.dcPersent }" type="currency" /></td>
				<td></td>
				
				<td>${ ( 1 - event.dcPersent ) * 100 } [%]</td>
				<td></td>
				
				<td>
					${start } ~ ${end }
				</td>
				<td></td>
				
				<td>

					현재		
					<c:if test="${event.eventType == '1' && start <= today && today <= end }" >
						할인 진행중 
					</c:if>
					
					<c:if test="${event.eventType == '1' && end < today }" >
						할인 종료된
					</c:if>
					
					<c:if test="${event.eventType == '1' && start > today }" >
						할인 예정된
					</c:if>
	
					<c:if test="${event.eventType == '2' }">
						할인 취소된
					</c:if>
					
					상품 입니다.
				</td>
				<td></td>
			</tr>
			
			<tr>
				<td id="${event.product.prodNo }" colspan="17" bgcolor="D6D7D6" height="1"></td>
			</tr>
			
			</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
</table>
</form>
</div>

</body>
</html>