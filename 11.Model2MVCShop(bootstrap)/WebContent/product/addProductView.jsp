<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<title>��ǰ���</title>
	
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
    
	<script type="text/javascript">

	function fncAddProduct() {
	
		var id = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var date = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		var count = $("input[name='prodCount']").val();
		
		if(id == null || id.length <1){
			alert("��ǰ���� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(detail == null || detail.length <1){
			alert("��ǰ�󼼼�����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(date == null || date.length <1){
			alert(" �������ڴ�  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length <1){
			alert("������  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(count == null || count.length <1){
			alert("�Ǹż�����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		$("form").attr("method", "post").attr("action", "/product/addProduct").submit();
		
	}
	</script>
	
	<script type="text/javascript" src="/javascript/calendar.js"></script>
	<link rel="stylesheet" href="/css/bootstrap-datepicker.css" type="text/css">
	<script type="text/javascript" src="/javascript/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/javascript/bootstrap-datepicker.ko.js"></script>
	<script type="text/javascript" src="/javascript/bootstrap-datepicker.ko.min.js"></script>
	
	<script type="text/javascript">
	$(function(){
		$('#manuDate').datepicker({
		    format: "yyyy-mm-dd",	
		    startDate: '-10y',	
		    endDate: '+10y',	
		    autoclose : true,	
		    calendarWeeks : false, 
		    clearBtn : false, 
		    disableTouchKeyboard : false,	
		    immediateUpdates: false,	
		    templates : {
		        leftArrow: '&laquo;',
		        rightArrow: '&raquo;'
		    },
		    showWeekDays : true ,
		    title: "��������",
		    todayHighlight : true ,	
		    toggleActive : true,	
		    weekStart : 0 ,
		    language : "eng"	
		    
		});
	})
	</script>
	
	<script type="text/javascript">
		$(function(){
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddProduct();
			});
			
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		})
	
	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
		
		<div class="page-header text-center">
			<h3 class="text-info">��ǰ���</h3>
		</div>
		
		<form class="form-horizontal" enctype="multipart/form-data">
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ�� �Է�">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ���� �Է�">
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" class="form-control" placeholder="�������� ����">
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" placeholder="���� �Է�">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodCount" class="col-sm-offset-1 col-sm-3 control-label">�Ǹż���</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodCount" name="prodCount" placeholder="�Ǹż��� �Է�">
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
	
	

</form>

</body>
</html>
