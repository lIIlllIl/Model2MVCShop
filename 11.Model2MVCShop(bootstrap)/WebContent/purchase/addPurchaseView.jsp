<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<title>상품등록</title>
	
	<style>
       body > div.container{
            margin-top: 50px;
        }
        body > div.container #a{
        	display: flex;
        }
    </style>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
    
	<script type="text/javascript">

	function fncAddPurchase() {
		var tranCount = $("input[name='tranCode']").val();
		var prodCount = ${event.product.prodCount };
		
		if ( tranCount > prodCount ) {
			alert('판매수량이 부족합니다.');
			$("input[name='tranCount']").focus();
			event.preventDefault();
		}
		else {
			$("form").attr("method", "post").attr("action", "/purchase/addPurchase").submit();
			
	//		var obj = new Object();
			
	//		obj.buyer.userId = $("input[name='buyerId']").val();
	//		obj.purchaseProd.prodNo = "${event.product.prodNo }";
	//		obj.paymentOption = $("input[name='paymentOption']").val();
	//		obj.tranCount = $("input[name='tranCount']").val();
			
	//		$.ajax(
	//				{
	//					url : "/purchase/json/addPurchase" , 
	//					method : "post" , 
	//					dataType : "json" , 
	//					headers : {
	//						"Accept" : "application/json" , 
	//						"Content-Type" : "application/json"
	//					} , 
	//					data : JSON.stringify({
	//						json : obj
	//					}) , 
	//					success : function( JSONData , Status ) {
	//						alert("구매 성공???");
	//						self.location = "/purchase/listPurchase";
	//					}
	//				}
	//		)
		}
	}
	
	function fncAddWishPurchase() {
		var tranCount = $("input[name='tranCode']").val();
		var prodCount = ${event.product.prodCount };
	
		if ( tranCount > prodCount ) {
			alert('판매수량이 부족합니다.');
			$("input[name='tranCount']").focus();
			event.preventDefault();
		}
		else {
			$("form").attr("method", "post").attr("action", "/purchase/addWishPurchase").submit();
		}
	}
	
	$(function(){
		$("a[href='#' ]").on("click" , function() {
			history.go(-1);
		});
		
		$(".btn-primary:contains('구매')").on("click", function(){
			fncAddPurchase();
		})
		
		$(".btn-primary:contains('장바구니')").on("click", function(){
			fncAddWishPurchase();
		})
		
		$("input[name='divyAddr']").on("click", function(){
			popWin 
			= window.open("/kakao/testMap.jsp",
										"popWin", 
										"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0,"+
										"scrollbars=no, scrolling=no, menubar=no, resizable=no");
		});
	})
	
	</script>
	
	<script type="text/javascript" src="/javascript/calendar.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	
	<script type="text/javascript">
	$(function(){
		$( "#divyDate" ).datepicker({
			dateFormat : 'yymmdd' , 
			showOtherMonths : true , 
			showMonthAfterYear : true , 
			changeYear : true , 
			nextText : '다음 달' ,
	        prevText : '이전 달' , 
			monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'] , 
			monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] , 
			dayNamesMin : ['일','월','화','수','목','금','토'] , 
			dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	  	});
	})
	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		<div class="page-header text-center">
			<h3 class="text-info">상품구매</h3>
		</div>
		
		<form class="form-horizontal">
		
		<input type="hidden" name="prodNo" value="${event.product.prodNo }" />
		
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" value="${event.product.prodName }" readonly>
				</div>
			</div>
			
			<hr/>
						
			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" class="form-control" value="${event.product.manuDate }" readonly>
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" value="${event.product.price }" readonly>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="regDate" name="regDate" value="${event.product.regDate }" readonly>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="buyerId" name="buyerId" value="${user.userId }" readonly>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="prodCount" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
				<div class="col-sm-4">
					<select class="form-control" name="paymentOption">
						<option value="1" selected>현금구매</option>
						<option value="2">신용구매</option>
					</select>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="tranCount" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
				<div class="col-sm-4" id="a">
					<input type="text" class="form-control" id="tranCount" name="tranCount" value="${event.product.prodCount }"/>
					<p>&nbsp;개</p>
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName }" >
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone }">
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr }">
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="">
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="divyDate" name="divyDate" value="">
				</div>
			</div>
			
			<hr/>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary">구매</button>
			      
			      <button type="button" class="btn btn-primary">장바구니</button>
			      
				  <a class="btn btn-primary btn" href="#" role="button">취 소</a>
			    </div>
		  	</div>
		  	

			
		</form>
		
		
	</div>
	
	

</form>

</body>
</html>
