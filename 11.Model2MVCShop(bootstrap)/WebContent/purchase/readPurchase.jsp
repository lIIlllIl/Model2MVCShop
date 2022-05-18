<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	<title>���Ż���ȸ</title>
	
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
		alert('���������� ������ �� ���� �����Դϴ�.');
	}
	
	$(function() {
		$( ".btn-primary:contains('����')" ).on("click" , function() {
			var tranNo = ${purchase.tranNo};
			var tranCode = $.trim(${purchase.tranCode});
			
			if ( tranCode == '1' ) {
				self.location = "/purchase/updatePurchase?tranNo="+tranNo;
			}
			
			if ( tranCode != '1' ) {
				fndAlertCheck();
			}
		});
		
		$( ".btn-primary:contains('Ȯ��')" ).on("click" , function() {
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
											"��ǰ�� : " + JSONData.product.prodName + "&nbsp;&nbsp;<br/>" + 
											"<span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;" +
											"�󼼼��� : " + JSONData.product.prodDetail + "&nbsp;&nbsp;</h4>"
				
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
			<h3 class="text-info">���Ż���ȸ</h3>
			<h5 class="text-muted">������ ��ǰ�� <strong class="text-danger">Ȯ�� </strong>�� �� �ֽ��ϴ�.</h5>
		</dlv>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4" id="product">${purchase.purchaseProd.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName }</div>
		</div>
		
		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:set var="tranCode" value="${fn:trim(purchase.paymentOption) }" />
				<c:if test="${tranCode == '1' }">
					���ݱ���
				</c:if>
				<c:if test="${tranCode == '2' }">
					�ſ뱸��
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty purchase.receiverPhone ? purchase.receiverPhone : '�Է����� �ʾҽ��ϴ�.'}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�������ּ�</strong></div>
			<div id="address" class="col-xs-8 col-md-4">
			<input type="hidden" name="divyAddr" value="${ !empty purchase.divyAddr ? purchase.divyAddr : '�Է����� �ʾҽ��ϴ�.'}" />
			${ !empty purchase.divyAddr ? purchase.divyAddr : '�Է����� �ʾҽ��ϴ�.'}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty purchase.divyRequest ? purchase.divyRequest : '�Է����� �ʾҽ��ϴ�.'}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty divyDate ? divyDate : '�Է����� �ʾҽ��ϴ�.'}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ֹ���</strong></div>
			<div class="col-xs-8 col-md-4">${ purchase.orderDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ۻ���</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:set var="tranCode" value="${fn:trim(purchase.tranCode) }" />
				���� 		
				<c:if test="${tranCode == 1 }" >
					���ſϷ�	 
				</c:if>
				<c:if test="${tranCode == 2 }" >
					����� 
				</c:if>
				<c:if test="${tranCode == 3 }" >
					��ۿϷ� 	
				</c:if>
		 		�����Դϴ�.
 			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">����</button>
	  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  			<button type="button" class="btn btn-primary">Ȯ��</button>
	  		</div>
		</div>
		
		<br/>
		
	</div>
</body>

</html>