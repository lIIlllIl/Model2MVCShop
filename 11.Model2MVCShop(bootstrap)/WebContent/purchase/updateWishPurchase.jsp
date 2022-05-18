<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>��ٱ��� ����</title>
	
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
   	
   	<script type="text/javascript" src="/javascript/calendar.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   
	<script type="text/javascript">
	
	$(function() {
		$( ".btn-primary:contains('����')" ).on("click" , function() {
			var tranNo = ${purchase.tranNo };
			
			$("form").attr("method", "post").attr("action", "/purchase/updateWishPurchase?tranNo="+tranNo).submit();
		});
		
		$(".btn-primary:contains('���')").on("click" , function() {
			$("form")[0].reset();
		});
		
		$("input[name='divyAddr']").on("click", function(){
			popWin 
			= window.open("/kakao/testMap.jsp",
										"popWin", 
										"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0,"+
										"scrollbars=no, scrolling=no, menubar=no, resizable=no");
		})
	});	
		
	</script>		
	
	<script type="text/javascript">
	$(function(){
		$( "#divyDate" ).datepicker({
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
	
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">��ٱ��� ����</h3>
	       <h5 class="text-muted">��ٱ��Ͽ� ���� ���ų����� <strong class="text-danger">���� </strong>�� �� �ֽ��ϴ�.</h5>
	    </div>
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName }" />
		    </div>
		  </div>
		  
		  <hr/>
		  	  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone }" />
		    </div>
		  </div>
		  
		  <hr/>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr }" />
		    </div>
		  </div>
		  
		  <hr/>

		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest }" />
		    </div>
		  </div>
		  
		  <hr/>
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate }" />
		    </div>
		  </div>
		  
		  <hr/>
		  
		  <div class="form-group">
		    <label for="tranCount" class="col-sm-offset-1 col-sm-3 control-label">���ż���</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="tranCount" name="tranCount" value="${purchase.tranCount}" />
		    </div>
		  </div>
		  
		  <hr/>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <div class="col-sm-4">
		      <select class="form-control" name="paymentOption">
						<option value="1" ${purchase.paymentOption == '1' ? "selected" : "" }>���ݱ���</option>
						<option value="2" ${purchase.paymentOption == '2' ? "selected" : "" }>�ſ뱸��</option>
				</select>
		    </div>
		  </div>
		  
		  <hr/>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">����</button>
		      &nbsp;&nbsp;&nbsp;
			  <button type="button" class="btn btn-primary">���</button>
		    </div>
		  </div>
		</form>
	    
 	</div>
 	
</body>

</html>