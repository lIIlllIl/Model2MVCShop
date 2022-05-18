<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<head>
	<title>��ǰ���Ȯ��</title>
	
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
			
			$("td.ct_btn01:contains('Ȯ��')").on("click", function() {
				self.location = "/product/listProduct?menu=manage";
			});
			
			$("td.ct_btn01:contains('�߰����')").on("click", function() {
				self.location = "/product/addProductView.jsp";
			});
			
		});
	
	</script>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		<div class="page-header text-center">
			<h3 class="text-info">��ǰ���Ȯ��</h3>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodName }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodDetail }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
		<div class="col-xs-8 col-md-4">${product.manuDate }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
		<div class="col-xs-8 col-md-4">${product.price }</div>
	</div>
	
	<hr/>
	
	<div class="row">
		<div class="col-xs-4 col-md-2"><strong>�Ǹż���</strong></div>
		<div class="col-xs-8 col-md-4">${product.prodCount }</div>
	</div>
	
	<hr/>

</body>
</html>
