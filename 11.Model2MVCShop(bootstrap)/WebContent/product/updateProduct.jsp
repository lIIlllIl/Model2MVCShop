<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>��ǰ����</title>
	
	<style>
		body {
	           padding-top : 50px;
	       }
	   </style>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   	
	<script type="text/javascript">
	
		function fncUpdateProduct() {
		
		//	var name=document.detailForm.prodName.value;
		//	var prodDetail=document.detailForm.prodDetail.value;
		//	var manuDate=document.detailForm.manuDate.value;
		//	var price=document.detailForm.price.value;
		//	var count=document.detailForm.prodCount.value;
			
			var name = $("input[name='prodName']").val();
			var prodDetail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();
			var count = $("input[name='prodCount']").val();
			
			if(name == null || name.length <1){
				alert("��ǰ����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if(prodDetail == null || prodDetail.length <1){
				alert("��ǰ��������  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if(manuDate == null || manuDate.length <1){
				alert("�������ڴ�  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if(price == null || price.length <1){
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
			if(count == null || count.length <1){
				alert("�Ǹż�����  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			
		//	$("form").attr("method", "post").attr("action", "/product/updateProduct").submit();
		
			var obj = new Object();
			
			obj.prodNo = $("input[name='prodNo']").val();
			obj.prodName = $("input[name='prodName']").val();
			obj.prodDetail = $("input[name='prodDetail']").val();
			obj.manuDate = $("input[name='manuDate']").val();
			obj.price = $("input[name='price']").val();
			obj.prodCount = $("input[name='prodCount']").val();
		
			$.ajax(
					{
						url : "/product/json/updateProduct" , 
						method : "post" , 
						dataType : "json" , 
						headers : {
							"Accept" : "application/json" , 
							"Content-Type" : "application/json"
						} , 
						data : JSON.stringify({
							json : obj
						}) , 
						success : function() {
							self.location = "/product/listProduct?menu=manage";
						}
						
					}
			)
		}
		
		$(function() {
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncUpdateProduct();
			});
			
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
			
			$( "#manuDate" ).datepicker({
				dateFormat : 'yymmdd' , 
				showOtherMonths : true , 
				showMonthAfterYear : true , 
				changeYear : true , 
				nextText : '���� ��' ,
		        prevText : '���� ��' , 
				monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'] , 
				monthNames : ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'] , 
				dayNamesMin : ['��','��','ȭ','��','��','��','��'] , 
				dayNames : ['�Ͽ���','������','ȭ����','������','�����','�ݿ���','�����']
		  	});
		})
	
	</script>
	
	<script type="text/javascript" src="/javascript/calendar.js">
	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		<div class="page-header">
			<h3 class="text-info">��ǰ��������</h3>
			<h5 class="text-muted">��ǰ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
		</div> 
		
		<form class="form-horizontal">
			<div class="form-group">
				<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodNo" name="prodNo" value="${event.product.prodNo }" readonly>
					<span id="helpBlock" class="help-block">
						<strong class="text-danger">��ǰ��ȣ�� �����Ͻ� �� �����ϴ�.</strong>
					</span>
				</div>				
			</div>
			
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" value="${event.product.prodName }" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�󼼼���</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${event.product.prodDetail }" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" value="${event.product.manuDate }" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" value="${event.product.price }" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodCount" class="col-sm-offset-1 col-sm-3 control-label">�Ǹż���</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodCount" name="prodCount" value="${event.product.prodCount }" />
				</div>
			</div>
			
			<div class="form-group">
				<label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
				<div class="col-sm-4">
					<input type="file" class="form-control" id="file" name="file" multiple="multiple" placeholder="�̹��� ���� ����">
				</div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary">�� ��</button>
				  <a class="btn btn-primary btn" href="#" role="button">�� ��</a>
			    </div>
		  	</div>
			
		</form>
		
	</div>



</body>
</html>
