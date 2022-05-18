<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
	<title>��ǰ����ȸ</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
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
		alert('������ �� ���� �����Դϴ�.');
	}
	
	$(function() {
		$(".ct_btn01:contains('����')").on("click", function(){
			var prodNo = ${event.product.prodNo};
			
			self.location = "/product/updateProduct?prodNo="+prodNo;
		})
		
		$("button[name='check']").on("click", function(){
			console.log("abc");
			if( ${param.menu == 'cookie' } ) {
				self.close();
			}
			
			if( ${menu == 'ok'} ) {
				self.location = "/product/listProduct?menu=manage";
			}
			
			if( ${param.menu == 'manage'} ) {
				self.location = "/product/listProduct?menu=manage";
			}
			
			if( ${param.menu == 'search' } ) {
				self.location = "/product/listProduct?menu=search";
			}
			
			if( ${param.menu == 'purchase' } ) {
				self.location = "/purchase/listPurchase";
			}
			
			if( ${param.menu == 'dcCheck' } ) {
				self.location = "/product/listDiscount";
			}
			
		})
		
		$("button:contains('����')").on("click", function(){
	
			if ( ${event.product.prodCount == 0 } ) {
				fndAlertCheck();
			}
			
			if ( ${event.product.prodCount != 0 } ) {
				self.location = "/purchase/addPurchase?prodNo=${event.product.prodNo }";
			}
			
		})
		
		$("button:contains('����')").on("click", function(){
			var prodNo = ${event.product.prodNo};
			
			self.location = "/product/updateProduct?prodNo="+prodNo;	
		})
		
	})
	
	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header">
			<h3 class="text-info">��ǰȮ��</h3>
			<h5 class="text-muted">�ش� ��ǰ�� <strong class="text-danger">���� </strong>�����Դϴ�.</h5>
		</div>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�󼼼���</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.prodDetail }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-2 col-md-2">
			<c:set var="images" value="${fn:split(event.product.fileName , '/') }" />
			<c:forEach var="image" items="${images }" >
						<img src="../images/uploadFiles/${image}" width="100" height="100" />
				</c:forEach>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.manuDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.price }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�Ǹż���</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.prodCount }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
			<div class="col-xs-4 col-md-4">${event.product.regDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-md-12 text-center ">
				<c:if test="${user.role == 'user'}">
			  		<button type="button" name="buy" class="btn btn-primary">����</button>	  		
				</c:if>
		
				<c:if test="${user.role == 'admin'}">
		  			<button type="button" name="erase" class="btn btn-primary">����</button>
	  			</c:if>
	  			&nbsp;&nbsp;&nbsp;	
	  			<button type="button" name="check" class="btn btn-primary">Ȯ��</button>
	  		</div>
		</div>
		
		
	</div>

</body>
</html>