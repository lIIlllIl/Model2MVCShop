<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="navbar navbar-inverse navbar-fixed-top">

	<div class="container">
	
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<c:if test="${user != null }">
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		
		<div class="collapse navbar-collapse" id="target" 
	       	 data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	       	 	
	       	 	<ul class="nav navbar-nav">
	       	 		<li class="dropdown">
	       	 			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	       	 				<span>회원관리</span>
	       	 				<span class="caret"></span>
	       	 			</a>
	       	 			
	       	 			<ul class="dropdown-menu">
	       	 				<li><a href="#">개인정보조회</a></li>
	       	 				
	       	 				<c:if test="${user.role == 'admin' }">
	       	 					<li><a href="#">회원정보조회</a></li>
	       	 				</c:if>
	       	 				
	       	 				<li class="divider"></li>
	       	 				<li><a href="#">etc...</a></li>
	       	 			</ul>
	       	 		</li>
	       	 		
	       	 		<c:if test="${user.role == 'admin' }" >
	       	 			<li class="drodown">
	       	 				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	       	 					<span>상품관리</span>
	       	 					<span class="caret"></span>
	       	 				</a>
	       	 				
	       	 				<ul class="dropdown-menu">
	       	 					<li><a href="#">판매상품등록</a></li>
	       	 					<li><a href="#">판매상품관리</a></li>
	       	 					<li><a href="#">할인현황</a></li>
	       	 					<li><a href="#">판매현황</a></li>
	       	 					<li class="divider"></li>
	       	 					<li><a href="#">etc...</a></li>
	       	 				</ul>
	       	 			</li>
	       	 		</c:if>
	       	 		
	       	 		<li class="dropdown">
	       	 			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
       	 					<span>상품구매</span>
       	 					<span class="caret"></span>
       	 				</a>
       	 				
       	 				<ul class="dropdown-menu">
       	 					<li><a href="#">상 품 검 색</a></li>
       	 					
       	 					<c:if test="${user.role == 'user' }" >
       	 						<li><a href="#">구매이력조회</a></li>
       	 						<li><a href="#">장 바 구 니</a></li>
       	 					</c:if>
       	 					
       	 					<li><a href="#">최근 본 상품</a></li>
       	 					<li class="divider"></li>
       	 					<li><a href="#">etc...</a></li>
       	 				</ul>
       	 			</li>
       	 			
       	 			<li><a href="#">etc...</a></li>
	       	 	</ul>
	       	 	</c:if>
	       	 	
	       	 	<c:if test="${user != null }">
		       	 	<ul class="nav navbar-nav navbar-right">
		       	 		<li><a href="#">로그아웃</a></li>
		       	 	</ul>
		       	 </c:if>
		       	 <c:if test="${user == null }">
		       	 	<ul class="nav navbar-nav navbar-right">
		       	 		<li><a href="#">회원가입</a></li>
		       	 		<li><a href="#">로 그 인</a></li>
		       	 	</ul>
		       	 </c:if>
	       	 </div>

	</div>

</div>

<script type="text/javascript">
	$(function(){
		$("a:contains('최근 본 상품')").on("click", function(){
			window.open("/product/history",
					"popWin",
					"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		})
		
		$("a:contains('로그아웃')").on("click", function(){
			self.location = "/user/logout";
		})
		
		$("a:contains('개인정보조회')").on("click", function(){
			self.location = "/user/getUser?userId=${user.userId}";
		})
		
		$("a:contains('회원정보조회')").on("click", function(){
			self.location = "/user/listUser";
		})
		
		$("a:contains('판매상품등록')").on("click", function(){
			self.location = "/product/addProduct";
		});
		
		$("a[href='#']:contains('판매상품관리')").on("click", function(){
			self.location = "/product/listProduct?menu=manage";
		})
		
		$("a:contains('할인현황')").on("click", function(){
			self.location = "/product/listDiscount";
		})
		
		$("a:contains('판매현황')").on("click", function(){
			self.location = "/purchase/listSale";
		})
		
		$("a:contains('상 품 검 색')").on("click", function(){
			self.location = "/product/listProduct?menu=search";
		})
		
		$("a:contains('구매이력조회')").on("click", function(){
			self.location = "/purchase/listPurchase";
		})
		
		$("a:contains('장 바 구 니')").on("click", function(){
			self.location = "/purchase/listWishPurchase";
		})
		
		$("a:contains('회원가입')").on("click", function(){
			self.location = "/user/addUser";
		})
		
		$("a:contains('로 그 인')").on("click", function(){
			self.location = "/user/loginView.jsp";
		})
		
	})
</script>