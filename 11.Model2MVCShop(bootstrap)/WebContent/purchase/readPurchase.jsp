<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>구매상세조회</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link href="/css/animate.min.css" rel="stylesheet">
   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
	
	<script type="text/javascript">	
	function fndAlertCheck() {
		alert('구매정보를 수정할 수 없는 상태입니다.');
	}
	
	$(function() {
		$( ".btn-primary:contains('수정')" ).on("click" , function() {
			var tranNo = ${purchase.tranNo};
			var tranCode = $.trim(${purchase.tranCode});
			
			if ( tranCode == '1' ) {
				self.location = "/purchase/updatePurchase?tranNo="+tranNo;
			}
			
			if ( tranCode != '1' ) {
				fndAlertCheck();
			}
		});
		
		$( ".btn-primary:contains('확인')" ).on("click" , function() {
			history.go(-1);
		});
		
		
	});
	</script>

	<script type="text/javascript">
	$( function() {
		
			var prodNo = "${purchase.purchaseProd.prodNo }";

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
						var displayValue = 	"<h4>" + 
											"<span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;" + 
											"상품명 : " + JSONData.product.prodName + "&nbsp;&nbsp;<br/>" + 
											"<span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;" +
											"상세설명 : " + JSONData.product.prodDetail + "&nbsp;&nbsp;</h4>"
				
						$("#product").attr("title", displayValue);				
					}
				}
			)
	
			
		$(  document  ).tooltip({
			track: true , 
			content : function(){
				return $(this).prop('title');
			}
		});
		
		$("#address").on("click", function(){
			var tranNo = ${purchase.tranNo};
	
			popWin 
			= window.open("/kakao/checkMap.jsp",
										"popWin", 
										"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0,"+
										"scrollbars=no, scrolling=no, menubar=no, resizable=no");
		})
		
	
	});
	</script>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<dlv class="page-header">
			<h3 class="text-info">구매상세조회</h3>
			<h5 class="text-muted">구매한 상품을 <strong class="text-danger">확인 </strong>할 수 있습니다.</h5>
		</dlv>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4" id="product">${purchase.purchaseProd.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>구매자이름</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName }</div>
		</div>
		
		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매방법</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:set var="tranCode" value="${fn:trim(purchase.paymentOption) }" />
				<c:if test="${tranCode == '1' }">
					현금구매
				</c:if>
				<c:if test="${tranCode == '2' }">
					신용구매
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자연락처</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty purchase.receiverPhone ? purchase.receiverPhone : '입력하지 않았습니다.'}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매자주소</strong></div>
			<div id="address" class="col-xs-8 col-md-4">
			<input type="hidden" name="divyAddr" value="${ !empty purchase.divyAddr ? purchase.divyAddr : '입력하지 않았습니다.'}" />
			${ !empty purchase.divyAddr ? purchase.divyAddr : '입력하지 않았습니다.'}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매요청사항</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty purchase.divyRequest ? purchase.divyRequest : '입력하지 않았습니다.'}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송희망일</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty divyDate ? divyDate : '입력하지 않았습니다.'}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주문일</strong></div>
			<div class="col-xs-8 col-md-4">${ purchase.orderDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송상태</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:set var="tranCode" value="${fn:trim(purchase.tranCode) }" />
				현재 		
				<c:if test="${tranCode == 1 }" >
					구매완료	 
				</c:if>
				<c:if test="${tranCode == 2 }" >
					배송중 
				</c:if>
				<c:if test="${tranCode == 3 }" >
					배송완료 	
				</c:if>
		 		상태입니다.
 			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">수정</button>
	  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  			<button type="button" class="btn btn-primary">확인</button>
	  		</div>
		</div>
		
		<br/>
		
	</div>
</body>

</html>