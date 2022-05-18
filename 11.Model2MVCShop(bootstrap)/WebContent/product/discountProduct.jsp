<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>��ǰ����</title>
	
	<style>
       body > div.container{
            margin-top: 50px;
        }
    </style>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
		
		function resetData() {
			document.detailForm.reset();
		}
		
		$(function() {
			$("td.ct_btn01:contains('����')").on("click", function(){
				$("form").attr("method", "post").attr("action", "/product/discountProduct").submit();
			});
			
			$( "td.ct_btn01:contains('���')" ).on("click" , function() {
				$("form")[0].reset();
			});
			
			$( "#startDate" ).datepicker({
				dateFormat : 'yy-mm-dd' , 
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
			
			$( "#endDate" ).datepicker({
				dateFormat : 'yy-mm-dd' , 
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
			
			$(function() {
				 $( "button.btn.btn-primary" ).on("click" , function() {
					$("form").attr("method", "post").attr("action", "/product/discountProduct").submit();
				});
			});	
			
			$(function() {
				 $( "a[href='#']" ).on("click" , function() {
					$("form")[0].reset();
				});
			});	
		})
	
	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-center">
			<h3 class="text-info">���ε��</h3>
		</div>
		
		<form class="form-horizontal">
			<div class="form-group">
				<label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodNo" name="prodNo" value="${event.product.prodNo }" readonly/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" value="${event.product.prodName }" readonly/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����� �Һ񰡰�</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" value="<fmt:formatNumber value="${event.product.price }" type="currency" />" readonly/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="discountPersent" class="col-sm-offset-1 col-sm-3 control-label">������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="discountPersent" name="discountPersent" placeholder="[%] �������� �Է����ּ���."/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" value="${event.product.prodName }" readonly/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="startDate" class="col-sm-offset-1 col-sm-3 control-label">���� ������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="startDate" name="startDate" placeholder="���� �������� �������ּ���."/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="endDate" class="col-sm-offset-1 col-sm-3 control-label">���� ������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="endDate" name="endDate" placeholder="���� �������� �������ּ���."/>
				</div>
			</div>
			
			<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">����</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		  </div>
			
		</form>
	
	</div>

</body>
</html>
