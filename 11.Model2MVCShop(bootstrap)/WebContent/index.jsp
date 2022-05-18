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
			$("a[href='#']:contains('��ǰ�˻�')").on("click", function(){
				self.location = "/product/listProduct?menu=search";
			})
			
			$("a[href='#']:contains('ȸ������')").on("click", function(){
				self.location = "/user/addUser";
			})
			
			$("a[href='#']:contains('�� �� ��')").on("click", function(){
				self.location = "/user/loginView.jsp";
			})
			
			$("a[href='#']:contains('�ֱ� �� ��ǰ')").on("click", function(){
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
	                 <li><a href="#">ȸ������</a></li>
	                 <li><a href="#">�� �� ��</a></li>
	           	</ul>
	       	</div>
	       		       	
		</div>
	</div>
	
	<div class="container">
	
		<div class="row">
			<div class="col-md-3">
			
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;&nbsp; ȸ������ 
					</div>
					
					<ul class="list-group">
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">����������ȸ</a></li>
  						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">ȸ��������ȸ</a></li>
					</ul>	
				</div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-barcode"></span>&nbsp;&nbsp;&nbsp; �ǸŻ�ǰ���� 
					</div>
					
					<ul class="list-group">
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">�ǸŻ�ǰ���</a></li>
  						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">�ǸŻ�ǰ����</a></li>
					</ul>	
				</div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;&nbsp;&nbsp; ��ǰ����
					</div>
					
					<ul class="list-group">
 						<li class="list-group-item">
 							<a href="#">��ǰ�˻�</a></li>
  						<li class="list-group-item">
 							<a href="#">�ֱ� �� ��ǰ</a></li>
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">�����̷���ȸ</a></li>
 						<li class="list-group-item">
 							<span class="glyphicon glyphicon-exclamation-sign"></span>
 							&nbsp;&nbsp;&nbsp; <a href="#">��ٱ���</a></li>
					</ul>	
				</div>
							
			</div>
				
			<div class="col-md-9">
			
				<div class="jumbotron">
					<h1>Model2 MVC Shop</h1>
					<p>�α��� �� ��밡��</p>
					<p>�α��� �� ��ǰ�˻� ����</p>
					<p>��ǰ�� �����ϱ� ���� ȸ������ �� �ּ���.</p>
					
					<div class="text-center">
						<a class="btn btn-info btn-lg" href="#" role="button">ȸ������</a>
						<a class="btn btn-info btn-lg" href="#" role="button">�� �� ��</a>
					</div>	
				</div>
			
			</div>
			
		</div>
		
	</div>

</body>


</html>