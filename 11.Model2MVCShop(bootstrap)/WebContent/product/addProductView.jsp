<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<title>상품등록</title>
	
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
			alert("상품명은 반드시 입력하셔야 합니다.");
			return;
		}
		if(detail == null || detail.length <1){
			alert("상품상세설명은  반드시 입력하셔야 합니다.");
			return;
		}
		if(date == null || date.length <1){
			alert(" 제조일자는  반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length <1){
			alert("가격은  반드시 입력하셔야 합니다.");
			return;
		}
		if(count == null || count.length <1){
			alert("판매수량은  반드시 입력하셔야 합니다.");
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
		    title: "제조일자",
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
			<h3 class="text-info">상품등록</h3>
		</div>
		
		<form class="form-horizontal" enctype="multipart/form-data">
			<div class="form-group">
				<label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명 입력">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품설명 입력">
				</div>
			</div>
			
			<div class="form-group">
				<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" class="form-control" placeholder="제조일자 선택">
				</div>
			</div>
			
			<div class="form-group">
				<label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" placeholder="가격 입력">
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodCount" class="col-sm-offset-1 col-sm-3 control-label">판매수량</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="prodCount" name="prodCount" placeholder="판매수량 입력">
				</div>
			</div>
			
			<div class="form-group">
				<label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
				<div class="col-sm-4">
					<input type="file" class="form-control" id="file" name="file" multiple="multiple" placeholder="이미지 파일 선택">
				</div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary">등 록</button>
				  <a class="btn btn-primary btn" href="#" role="button">취 소</a>
			    </div>
		  	</div>
			
		</form>
		
		
	</div>
	
	

</form>

</body>
</html>
