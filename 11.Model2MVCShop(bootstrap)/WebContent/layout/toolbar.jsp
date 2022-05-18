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
	       	 				<span>ȸ������</span>
	       	 				<span class="caret"></span>
	       	 			</a>
	       	 			
	       	 			<ul class="dropdown-menu">
	       	 				<li><a href="#">����������ȸ</a></li>
	       	 				
	       	 				<c:if test="${user.role == 'admin' }">
	       	 					<li><a href="#">ȸ��������ȸ</a></li>
	       	 				</c:if>
	       	 				
	       	 				<li class="divider"></li>
	       	 				<li><a href="#">etc...</a></li>
	       	 			</ul>
	       	 		</li>
	       	 		
	       	 		<c:if test="${user.role == 'admin' }" >
	       	 			<li class="drodown">
	       	 				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	       	 					<span>��ǰ����</span>
	       	 					<span class="caret"></span>
	       	 				</a>
	       	 				
	       	 				<ul class="dropdown-menu">
	       	 					<li><a href="#">�ǸŻ�ǰ���</a></li>
	       	 					<li><a href="#">�ǸŻ�ǰ����</a></li>
	       	 					<li><a href="#">������Ȳ</a></li>
	       	 					<li><a href="#">�Ǹ���Ȳ</a></li>
	       	 					<li class="divider"></li>
	       	 					<li><a href="#">etc...</a></li>
	       	 				</ul>
	       	 			</li>
	       	 		</c:if>
	       	 		
	       	 		<li class="dropdown">
	       	 			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
       	 					<span>��ǰ����</span>
       	 					<span class="caret"></span>
       	 				</a>
       	 				
       	 				<ul class="dropdown-menu">
       	 					<li><a href="#">�� ǰ �� ��</a></li>
       	 					
       	 					<c:if test="${user.role == 'user' }" >
       	 						<li><a href="#">�����̷���ȸ</a></li>
       	 						<li><a href="#">�� �� �� ��</a></li>
       	 					</c:if>
       	 					
       	 					<li><a href="#">�ֱ� �� ��ǰ</a></li>
       	 					<li class="divider"></li>
       	 					<li><a href="#">etc...</a></li>
       	 				</ul>
       	 			</li>
       	 			
       	 			<li><a href="#">etc...</a></li>
	       	 	</ul>
	       	 	</c:if>
	       	 	
	       	 	<c:if test="${user != null }">
		       	 	<ul class="nav navbar-nav navbar-right">
		       	 		<li><a href="#">�α׾ƿ�</a></li>
		       	 	</ul>
		       	 </c:if>
		       	 <c:if test="${user == null }">
		       	 	<ul class="nav navbar-nav navbar-right">
		       	 		<li><a href="#">ȸ������</a></li>
		       	 		<li><a href="#">�� �� ��</a></li>
		       	 	</ul>
		       	 </c:if>
	       	 </div>

	</div>

</div>

<script type="text/javascript">
	$(function(){
		$("a:contains('�ֱ� �� ��ǰ')").on("click", function(){
			window.open("/product/history",
					"popWin",
					"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		})
		
		$("a:contains('�α׾ƿ�')").on("click", function(){
			self.location = "/user/logout";
		})
		
		$("a:contains('����������ȸ')").on("click", function(){
			self.location = "/user/getUser?userId=${user.userId}";
		})
		
		$("a:contains('ȸ��������ȸ')").on("click", function(){
			self.location = "/user/listUser";
		})
		
		$("a:contains('�ǸŻ�ǰ���')").on("click", function(){
			self.location = "/product/addProduct";
		});
		
		$("a[href='#']:contains('�ǸŻ�ǰ����')").on("click", function(){
			self.location = "/product/listProduct?menu=manage";
		})
		
		$("a:contains('������Ȳ')").on("click", function(){
			self.location = "/product/listDiscount";
		})
		
		$("a:contains('�Ǹ���Ȳ')").on("click", function(){
			self.location = "/purchase/listSale";
		})
		
		$("a:contains('�� ǰ �� ��')").on("click", function(){
			self.location = "/product/listProduct?menu=search";
		})
		
		$("a:contains('�����̷���ȸ')").on("click", function(){
			self.location = "/purchase/listPurchase";
		})
		
		$("a:contains('�� �� �� ��')").on("click", function(){
			self.location = "/purchase/listWishPurchase";
		})
		
		$("a:contains('ȸ������')").on("click", function(){
			self.location = "/user/addUser";
		})
		
		$("a:contains('�� �� ��')").on("click", function(){
			self.location = "/user/loginView.jsp";
		})
		
	})
</script>