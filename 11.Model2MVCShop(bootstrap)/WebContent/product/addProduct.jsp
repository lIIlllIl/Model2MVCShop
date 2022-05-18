<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
	<title>상품등록확인</title>
	
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
	
	<script type="text/javascript">
	
		$(function(){
			
			$("td.ct_btn01:contains('확인')").on("click", function() {
				self.location = "/product/listProduct?menu=manage";
			});
			
			$("td.ct_btn01:contains('추가등록')").on("click", function() {
				self.location = "/product/addProductView.jsp";
			});
			
		});
	
	</script>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header text-center">
			<h3 class="text-info">상품등록확인</h3>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodName }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodDetail }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
		<div class="col-xs-8 col-md-4">${product.manuDate }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
		<div class="col-xs-8 col-md-4">${product.price }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>판매수량</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodCount }</div>
	</div>
	
	<hr/>

</body>
</html>
