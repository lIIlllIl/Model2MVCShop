<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<c:if test="${! empty user }" >
	<jsp:forward page="main.jsp" />
</c:if>

<!DOCTYPE html>

<html lang="ko">
<head>

	<title>Model2 MVC Shop</title>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script type="text/javascript">
		$(function(){
			$("a[href='#']:contains('상품검색')").on("click", function(){
				self.location = "/product/listProduct?menu=search";
			})
			
			$("a[href='#']:contains('회원가입')").on("click", function(){
				self.location = "/user/addUser";
			})
			
			$("a[href='#']:contains('로 그 인')").on("click", function(){
				self.location = "/user/loginView.jsp";
			})
			
			$("a[href='#']:contains('최근 본 상품')").on("click", function(){
				window.open("/product/history",
						"popWin",
						"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
			})
		})
		
		
	</script>
</head>

<body>

	<div class="navbar navbar-inverse narvar-fixed-top">
		<div class="container">
			<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">회원가입</a></li>
	                 <li><a href="#">로 그 인</a></li>
	           	</ul>
	       	</div>
	       		       	
		</div>
	</div>
	
	<div class="container">
	
		<div class="row">
			<div class="col-md-3">
			
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;&nbsp; 회원관리 
					</div>
					
					<ul class="list-group">
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">개인정보조회</a></li>
  						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">회원정보조회</a></li>
					</ul>	
				</div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-barcode"></span>&nbsp;&nbsp;&nbsp; 판매상품관리 
					</div>
					
					<ul class="list-group">
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">판매상품등록</a></li>
  						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">판매상품관리</a></li>
					</ul>	
				</div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;&nbsp;&nbsp; 상품구매
					</div>
					
					<ul class="list-group">
 						<li class="list-group-item">
 							<a href="#">상품검색</a></li>
  						<li class="list-group-item">
 							<a href="#">최근 본 상품</a></li>
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">구매이력조회</a></li>
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">장바구니</a></li>
					</ul>	
				</div>
							
			</div>
				
			<div class="col-md-9">
			
				<div class="jumbotron">
					<h1>Model2 MVC Shop</h1>
					<p>로그인 후 사용가능</p>
					<p>로그인 전 상품검색 가능</p>
					<p>상품을 구매하기 위해 회원가입 해 주세요.</p>
					
					<div class="text-center">
						<a class="btn btn-info btn-lg" href="#" role="button">회원가입</a>
						<a class="btn btn-info btn-lg" href="#" role="button">로 그 인</a>
					</div>	
				</div>
			
			</div>
			
		</div>
		
	</div>

</body>


</html>