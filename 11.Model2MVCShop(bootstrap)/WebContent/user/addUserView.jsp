<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
	
	<title>회원가입</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script type="text/javascript">
	
	function fncAddUser() {
		
	
		var id=$("input[name='userId']").val();
		var pw=$("input[name='password']").val();
		var pw_confirm=$("input[name='password2']").val();
		var name=$("input[name='userName']").val();
		
		
		if(id == null || id.length <1){
			alert("아이디는 반드시 입력하셔야 합니다.");
			return;
		}
		if(pw == null || pw.length <1){
			alert("패스워드는  반드시 입력하셔야 합니다.");
			return;
		}
		if(pw_confirm == null || pw_confirm.length <1){
			alert("패스워드 확인은  반드시 입력하셔야 합니다.");
			return;
		}
		if(name == null || name.length <1){
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}
		
		if( pw != pw_confirm ) {				
			alert("비밀번호 확인이 일치하지 않습니다.");
			$("input:text[name='password2']").focus();
			return;
		}
		
		var value = "";	
		if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-" 
								+ $("input[name='phone2']").val() + "-" 
								+ $("input[name='phone3']").val();
		}
		
		$("input:hidden[name='phone']").val( value );

		var obj = new Object();
		
		obj.userId = $("input[name='userId']").val();
		obj.userName = $("input[name='userName']").val();
		obj.password = $("input[name='password']").val();
		obj.ssn = $("input[name='ssn']").val();
		obj.phone = $("input[name='phone']").val();
		obj.addr = $("input[name='addr']").val();
		obj.email = $("input[name='email']").val();
		
		$.ajax(
				{
					url : "/user/json/addUser" , 
					method : "post" , 
					dataType : "json" , 
					headers : {
						"Accept" : "application/json" , 
						"Content-Type" : "application/json" 
					} , 
					data : JSON.stringify({
						json : obj 
					}) , 
					success : function( JSONData, Status ) {
						self.location = "/user/loginView.jsp";
					}
				}
		)
	}
	
	$(function() {
		 $( "button.btn.btn-primary" ).on("click" , function() {
			fncAddUser();
		});
	});	
	
	$(function() {
		 $( "a[href='#']" ).on("click" , function() {
			$("form")[0].reset();
		});
	});	
	 
	 $(function() {
		 
		 $("input[name='email']").on("change" , function() {
				
			 var email=$("input[name='email']").val();
		    
			 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
		    	alert("이메일 형식이 아닙니다.");
		     }
		});
		 
	});	
	
	function checkSsn() {
		var ssn1, ssn2; 
		var nByear, nTyear; 
		var today; 
	
		ssn = document.detailForm.ssn.value;
		
		if(!PortalJuminCheck(ssn)) {
			alert("잘못된 주민번호입니다.");
			return false;
		}
	}
	
	function PortalJuminCheck(fieldValue){
	    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
		var num = fieldValue;
	    if (!pattern.test(num)) return false; 
	    num = RegExp.$1 + RegExp.$2;
	
		var sum = 0;
		var last = num.charCodeAt(12) - 0x30;
		var bases = "234567892345";
		for (var i=0; i<12; i++) {
			if (isNaN(num.substring(i,i+1))) return false;
			sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
		}
		var mod = sum % 11;
		return ((11 - mod) % 10 == last) ? true : false;
	}
	
	 $(function() {
	
		 $("button.btn.btn-info").on("click" , function() {
			popWin 
			= window.open("/user/checkDuplication.jsp",
										"popWin", 
										"left=300,top=200,width=300,height=200,marginwidth=0,marginheight=0,"+
										"scrollbars=no,scrolling=no,menubar=no,resizable=no");
		});
		 
		 $("input[name='addr']").on("click", function(){
			 popWin 
				= window.open("/kakao/addUserMap.jsp",
											"popWin", 
											"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0,"+
											"scrollbars=no, scrolling=no, menubar=no, resizable=no");
		 })
	});	
	
	</script>		
	
</head>

<body>

	<div class="navbar navbar-default">
		<div class="container">
			<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		</div>
	</div>
	
	<div class="container">
		
		<h1 class="bg-primary text-center">회 원 가 입</h1>
		
		<form class="form-horizontal">
			
			<div class="form-group">
				<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="중복확인이 필요합니다." readonly>
						<span id="helpBlock" class="help-block">
							<strong class="text-danger">중복확인이 필요합니다.</strong>
						</span>
				</div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-info">중복확인</button>
				</div>
			</div>
			
			<div class="form-group">
				<label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
				</div>
			</div>
			
			<div class="form-group">
				<label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호">
				</div>
			</div>
			
			<div class="form-group">
		    	<label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    	<div class="col-sm-4">
		      		<input type="password" class="form-control" id="userName" name="userName" placeholder="회원이름">
		    	</div>
		  	</div>
			
			
			<div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주민번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="주민번호">
		      <span id="helpBlock" class="help-block">
		      	 <strong class="text-danger">"-" 기호를 제외하고 입력해주세요.</strong>
		      </span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="addr" name="addr" placeholder="주소" readonly>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		    <input type="hidden" name="phone"  />
		  </div>
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >가 &nbsp;입</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
	</div>


</body>

</html>