<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="EUC-KR">
	
	<title>로그인 화면</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
  	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>

	<script type="text/javascript">
	
		$( function() {
	
			$("#userId").focus();
	
			$("button:contains('로 그 인')").on("click" , function() {

				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("input:text").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("input:password").focus();
					return;
				}
			    
				$.ajax(
					{
						url : "/user/json/login" , 
						method : "post" , 
						dataType : "json" , 
						headers : {
							"Accept" : "application/json" , 
							"Content-Type" : "application/json" 
						} , 
						data : JSON.stringify({
							userId : id , 
							password : pw
						}) , 
						success : function(JSONData , status ) {
							if ( JSONData != null ) {
								self.location = "/index.jsp";
							}
						}
					}		
				)
				
				
			});
		});
		
		
	
		$( function() {
			$("button:contains('회 원 가 입')").on("click" , function() {
				self.location = "/user/addUser";
			});
			
			$("input:password").on("keydown", function(key){
				if ( key.keyCode == 13 ) {
					var id=$("input:text").val();
					var pw=$("input:password").val();
					
					$.ajax(
							{
								url : "/user/json/login" , 
								method : "post" , 
								dataType : "json" , 
								headers : {
									"Accept" : "application/json" , 
									"Content-Type" : "application/json" 
								} , 
								data : JSON.stringify({
									userId : id , 
									password : pw
								}) , 
								success : function( JSONData , status ) {

									if ( JSONData != null ) {
										self.location = "/index.jsp";
									}
									else {
										alert("아이디, 패스워드를 다시 입력해주세요.");
									}
								}
							}		
						)
				}
			});
		});
		
		$(function() {
	
			$("input[name='userId']").autocomplete({
				
				source : function( request, response ) {
					$.ajax(
						{
							url : "/user/json/enterUser" , 
							method : "post" , 
							dataType : "json" , 
							headers : {
								"Accept" : "application/json" , 
								"Content-Type" : "application/json"
							} ,
							data : JSON.stringify({ 
								dataName : request.term , 
								dataType : "userId"
							}) , 
							success : function( result ) {
								response (
									$.map(result , function(item){
										return {
											label : item , 
											value : item
										} 
										
									})
								);
							}
						}
					)
				}
			});
		});
		
		
	</script>	
	
	<style>
	       .ui-autocomplete {
	            max-height: 150px;
	            overflow-y: auto;
	            overflow-x: hidden;
	            padding-right: 20px;
	        } 
	</style>
</head>

<body>

	<div class="navbar navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>

	<div class="container">
		
		<div class="row">
		
			<div class="col-md-6">
				<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
			
			<div class="col-md-6">
				
				<br/><br/>
				
				<div class="jumbotron">
					<h1 class="text-center">로 그 인</h1>
					
					<form class="form-horizontal">
					
						<div class="form-group">
							<label for="userId" class="col-sm-4 control-label">아 이 디</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="password" class="col-sm-4 control-label">비 밀 번 호</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" name="password" id="password"  placeholder="비밀번호" >
							</div>
						</div>
						
						<div class="form-group">
					    	<div class="col-sm-offset-4 col-sm-6 text-center">
						      <button type="button" class="btn btn-primary">&nbsp;&nbsp;로 그 인&nbsp;&nbsp;</button>
						      <button type="button" class="btn btn-primary">회 원 가 입</button>
						    </div>
					  	</div>
					
					</form>
				</div>
			
			</div>
		
		</div>
		
	</div>

</body>

</html>