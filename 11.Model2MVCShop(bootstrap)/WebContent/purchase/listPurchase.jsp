<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>구매 목록조회</title>
	
	<style>
		body {
            padding-top : 50px;
        }
    </style>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
	<script type="text/javascript">
		
		function fndAlertCheck() {
			alert('구매정보를 수정할 수 없는 상태입니다.');
		}
		
		$(function(){
			$("a[href='#']:contains('주문취소')").on("click", function(){
				var tranNo = $(this).children("input[name='tranNo']").val();
				self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=4"
			})
			
			$("a[href='#']:contains('물품수령')").on("click", function(){
				var tranNo = $(this).children("input[name='tranNo']").val();
				self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3"
			})
			
			$("a[href='#']:contains('상세보기')").on("click", function(){
				var tranNo = $(this).children("input[name='tranNo']").val();
				self.location = "/purchase/getPurchase?tranNo="+tranNo;
			})
		})
	
		
	</script>
	
	<script type="text/javascript">
    var delta = 50;
	var timer = null;
	var currentPage = 2;
	
	$(function(){
		$(window).scroll(function(){
			clearTimeout( timer );
		    timer = setTimeout( scrollPurchase, delta );
		})
		
		
		function scrollPurchase() {

	 		if( $(document).height() <= $(window).scrollTop() + $(window).height() ){
	 			
	 			
	 			if ( ${resultPage.maxPage} >= currentPage ) {
	 				var obj = new Object(); 
	 				obj.currentPage = currentPage;

	 				$.ajax( 
	  
	 	 					{
	 	 						url : "/purchase/json/listPurchase" , 
	 	 						method : "post" ,  
	 	 						dataType : "json" ,  
	 	 						headers : {
	 	 							"Accept" : "application/json" , 
	 	 							"Content-Type" : "application/json"
	 	 						} , 
	 	 						data : JSON.stringify({
	 	 							json : obj 
	 	 						}) ,
	 	 						success : function( JSONData, status ) {
	 	 							currentPage = currentPage + 1;
	 	 							var display = "";
	 	 							var count = 0;
	 	 							display += "<div class='row'>";
	 	 							for ( count = 0; count < JSONData.list.length; count++) { 
	 	 								display += "<div class='col-xs-4 col-md-4'>";
	 	 								display += "<div class='thumbnail'>";
										var image = '';
	 	 								
	 	 								if ( JSONData.list[count].purchaseProd.fileName != null ) {
	 	 									image = JSONData.list[count].purchaseProd.fileName.split("/")[0];
	 	 								}
	 	 								
	 	 								display += "<img class='img-rounded' src='../images/uploadFiles/" + image + "' width='200' height='200' />";
	 	 								
	 	 								display += "<div class='caption'>";
	 	 								display += "<h3 class='text-primary'><span class='glyphicon glyphicon-shopping-cart'></span>&nbsp;&nbsp;&nbsp;" + JSONData.list[count].purchaseProd.prodName + "</h1>";
	 	 								display += "<br/>";
	 	 								display += "<h4><p><span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;&nbsp; 구매수량 : " + JSONData.list[count].tranCount + "</p></h4>"; 
	 	 								display += "<h4><p><span class='glyphicon glyphicon-usd'></span>&nbsp;&nbsp;&nbsp; 구매자이름 : " + JSONData.list[count].receiverName + "</p></h4>";
	 	 								
	 	 								var tranPrice = JSONData.list[count].purchaseProd.price * JSONData.list[count].tranCount;
	 	 								
	 	 								display += "<h4><p><span class='glyphicon glyphicon-shopping-cart'></span>&nbsp;&nbsp;&nbsp; 결제금액 : " + tranPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 개</p></h4>";
	 	 						//		display += "<h4><p><span class='glyphicon glyphicon-shopping-cart'></span>&nbsp;&nbsp;&nbsp; 결제금액 : " + (JSONData.list[count].purchaseProd.price * JSONData.list[count].tranCount) + "</p></h4>";
	 	 								
	 	 								var tranCode = JSONData.list[count].tranCode.replace(/^\s+|\s+$/g,"");
	 	 								
	 	 								display += "<h4><p><span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;&nbsp;현재";
	 	 								
	 	 								if (tranCode == '1') {
	 	 									display += "&nbsp;구매완료&nbsp;";
	 	 								}
	 	 								else if (tranCode == '2') {
	 	 									display += "&nbsp;배송중&nbsp;";
	 	 								}
	 	 								else if (tranCode == '3') {
	 	 									display += "&nbsp;배송완료&nbsp;";
	 	 								}
	 	 								display += "상태 입니다.";
	 	 								display +="</p></h4>";
	 	 								
	 	 								display += "<br/>";
	 	 								display += "<br/>";
	 	 								
	 	 								display += "<h4><p>";
	 	 								display += "<a class='btn btn-default' href='#' role='button'>";
	 	 								display += "<span class='glyphicon glyphicon-search'></span>";
	 	 								display += "<input type='hidden' id='tranNo' name='tranNo' value='"+JSONData.list[count].tranNo+"'/>&nbsp;&nbsp;&nbsp; 상세보기 &raquo;</a>";
	 									display += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	 									
	 	 								if (tranCode == '1') {
	 	 									display += "<a class='btn btn-default' href='#' role='button'>";
		 	 								display += "<span class='glyphicon glyphicon-remove'></span>";
		 	 								display += "<input type='hidden' id='tranNo' name='tranNo' value='"+JSONData.list[count].tranNo+"'/>&nbsp;&nbsp;&nbsp; 주문취소 &raquo;</a>";
	 	 								}
	 	 								else if (tranCode == '2') {
	 	 									display += "<a class='btn btn-default' href='#' role='button'>";
		 	 								display += "<span class='glyphicon glyphicon-ok'></span>";
		 	 								display += "<input type='hidden' id='tranNo' name='tranNo' value='"+JSONData.list[count].tranNo+"'/>&nbsp;&nbsp;&nbsp; 물품수령 &raquo;</a>";
	 	 								}
	 	 								
	 	 								display += "</p></h4>";
	 	 								display += "</div>";
										display += "</div>";
										display += "</div>";
	 	 							}
	 	 							display += "</div>";
	 	 							display += "<span></span>";
	 
	 	 							$("span:last").append(display);
	 	 							
	 	 							$("a[href='#']:contains('주문취소')").on("click", function(){
	 	 								var tranNo = $(this).children("input[name='tranNo']").val();
	 	 								self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=4"
	 	 							})
	 	 							
	 	 							$("a[href='#']:contains('물품수령')").on("click", function(){
	 	 								var tranNo = $(this).children("input[name='tranNo']").val();
	 	 								self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode=3"
	 	 							})
	 	 							
	 	 							$("a[href='#']:contains('상세보기')").on("click", function(){
	 	 								var tranNo = $(this).children("input[name='tranNo']").val();
	 	 								self.location = "/purchase/getPurchase?tranNo="+tranNo;
	 	 							})
	 	 						}        
	 	 					}               
	 	 			)           
	 			}    
	 						    
	 		}    
	 	} 
	})
	</script>
	
	
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="page-header text-info">
		<h3>구매목록조회</h3>
		<h6>전체 ${resultPage.totalCount } 건수</h6>
		<br/>
		<h6 class="text-muted">구매한 상품들을 <strong class="text-danger">확인 </strong>할 수 있습니다.</h6>
	</div>
	
	<div class="container">
		<div class="col-md-6 col-md-offset-7 text-right">
			<form class="form-inline" name="detailForm">
				<div class="form-group">
					<select class="form-control" name="searchTranCode">
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>전체보기</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>구매완료</option>
						<option value="3" ${ ! empty search.searchCondition && search.searchCondition == 3 ? "selected" : "" }>배송중</option>
						<option value="4" ${ ! empty search.searchCondition && search.searchCondition == 4 ? "selected" : "" }>배송완료</option>
					</select>
				</div>
			</form>
		</div>
	</div>
	
	<div class="container">
	<br/><br/>
		<div class="row">
		<c:forEach var="purchase" items="${list }" >
			<div class="col-xs-4 col-md-4">
				<div class="thumbnail">
					<img class="img-rounded" src="../images/uploadFiles/${purchase.purchaseProd.fileName}" width="200" height="200" />
					<div class="caption">
						<h3 class="text-primary"><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;&nbsp;&nbsp; ${purchase.purchaseProd.prodName}</h3>
						<br/>
						<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp; 구매수량 : ${purchase.tranCount}</p></h4>
						<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp; 구매자이름 : ${purchase.receiverName}</p></h4>
						<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp; 결제금액 : <fmt:formatNumber value="${ purchase.tranCount * purchase.purchaseProd.price }" pattern="#,###" /></p></h4>
						<h4>
							<c:set var="tranCode" value="${fn:trim(purchase.tranCode) }" />
							<p>
								<span class="glyphicon glyphicon-asterisk"></span>
								&nbsp;&nbsp;&nbsp;현재
								<c:if test="${ tranCode == '1'}" >
									구매완료
								</c:if>
								<c:if test="${ tranCode == '2'}" >
									배송중
								</c:if>
								<c:if test="${ tranCode == '3'}" >
									배송완료
								</c:if>
								상태 입니다.
							</p>
						</h4>
						<br/>
						<br/>
						<h4>
							<p>
								<a class="btn btn-default" href="#" role="button"><span class="glyphicon glyphicon-search"></span>
								<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo }"/>&nbsp;&nbsp;&nbsp; 상세보기 &raquo;</a>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<c:if test="${tranCode == '1' }" >
									<a class="btn btn-default" href="#" role="button"><span class="glyphicon glyphicon-remove"></span>
									<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo }"/>&nbsp;&nbsp;&nbsp; 주문취소 &raquo;</a>								
								</c:if>
								<c:if test="${tranCode == '2' }" >
									<a class="btn btn-default" href="#" role="button"><span class="glyphicon glyphicon-ok"></span>
									<input type="hidden" id="tranNo" name="tranNo" value="${purchase.tranNo }"/>&nbsp;&nbsp;&nbsp; 물품수령 &raquo;</a>	
								</c:if>
							</p>	
						</h4>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
		<span></span>
	</div>
</body>
</html>