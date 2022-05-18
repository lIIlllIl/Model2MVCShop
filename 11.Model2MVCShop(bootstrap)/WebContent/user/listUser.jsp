<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="EUC-KR">
	
	<title>회원 목록 조회</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<style>
			  body {
		            padding-top : 50px;
		      }
    </style>
    
    <style>
	       .ui-autocomplete {
	            max-height: 150px;
	            overflow-y: auto;
	            overflow-x: hidden;
	            padding-right: 20px;
	        } 
	</style>
	
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
	}
	
	function checkPoint() {
		$( "i" ).on("click" , function(){
			var userId = $(this).next().val();
			$.ajax(
					{
						url : "/user/json/getUser/"+userId , 
						method : "get" , 
						dataType : "json" , 
						headers : {
							"Accept" : "application/json" ,
							"Content-Type" : "application/json"
						} , 
						success : function( JSONData , status ) {
							var displayValue = 	"<h6>" + 
												"아이디 : " + JSONData.userId + "<br/>" + 
												"이 름 : " + JSONData.userName + "<br/>" + 
												"등 급 : " + JSONData.role + 
												"<br/><br/>" + "<span name='saw'>상세보기</span></h6>";
							$("h6").remove();
							$("#"+JSONData.userId+"").html(displayValue);
							
							$("span[name='saw']").on("click", function() {
								self.location ="/user/getUser?userId="+JSONData.userId;
							})
						}
					});
		});
	}
	
	function getUserId() {
		$( "td:nth-child(2)" ).on("click" , function() {
			self.location ="/user/getUser?userId="+$(this).text().trim();
		});
	}
	
	function scrollUser() {
		if( $(document).height() <= $(window).scrollTop() + $(window).height() ){

			if ( ${resultPage.maxPage} >= currentPage ) {
				console.log("maxpage : ${resultPage.maxPage}");
				$.ajax(
						{
							url : "/user/json/listUser/" + currentPage , 
							method : "get" , 
							dataType : "json" , 
							headers : {
								"Accept" : "application/json" , 
								"Content-Type" : "application/json"
							} , 
							success : function( JSONData, status ) {
								currentPage = currentPage + 1;
								
								var count = 0;
								var display = "";
								var email = "";
								for ( count = 0; count < JSONData.list.length; count++ ) {

									display += "<tr>";
									display += "<td align='center'>" + ( count + 1 ) + "</td>";
									display += "<td align='left'  title='상세보기'>" + JSONData.list[count].userId + "</td>";
									display += "<td align='left'>" + JSONData.list[count].userName + "</td>";
									
									if (JSONData.list[count].email == null ) {
										email = "";
									}
									else {
										email = JSONData.list[count].email;
									}

									display += "<td align='left'>" + email + "</td>";
									display += "<td align='left'>";
									display += "<i class='glyphicon glyphicon-ok' id='" + JSONData.list[count].userId + "'></i>";
									display += "<input type='hidden' value='" + JSONData.list[count].userId + "'>";
									display += "</td></tr>";

								}
								
								$("tbody:last").append(display);
								
								checkPoint();
								getUserId();
							}
						}
				)
			}			
		}
	}
	 
	</script>
	
	<script type="text/javascript">
		var delta = 50;
		var timer = null;
		var currentPage = 2;
		
		$(function(){
			
			$( document ).tooltip({
				track: true
			});
			
			$( ".btn.btn-default:contains('검색')" ).on("click" , function() {
				fncGetList(1);
			});
			
			$("input[name='searchKeyword']").on("keydown", function(key){
				if ( key.keyCode == 13 ) {
					fncGetList(1);
				}
			})
			
			$("input[name='searchKeyword']").autocomplete({
				
				source : function( request , response ) {
					var searchCondition = $("select[name='searchCondition']").val();
					var type = '';
					var restUrl = "/user/json/enterUser";
		
					if ( searchCondition == '0' ) {
						type = "userId";
					}
					if ( searchCondition == '1' ) {
						type = "userName";
					}
					$.ajax(
						{
							url : restUrl , 
							method : "post" , 
							dataType : "json" , 
							headers : {
								"Accept" : "application/json" , 
								"Content-Type" : "application/json"
							} , 
							data : JSON.stringify({ 
								dataName : request.term , 
								dataType : type 
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
			
			$(window).scroll(function(){
				clearTimeout( timer );
			    timer = setTimeout( scrollUser, delta );
			})
			
			checkPoint();
			getUserId();
			
			$("span[name='page']").on("click", function() {
				var currentPage = $(this).text().trim();
				alert(currentPage);
				fncGetList(currentPage);
			})
			
		});
	</script>	
</head>

<body>
	
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-info">
			<h3>회원목록조회</h3>
		</div>
		
		<div class="col-md-6 text-left">
			<p class="text-primary">
				전체 ${resultPage.totalCount } 건수 
			</p>
		</div>
		
		<div class="col-md-6 text-right">
			<form class="form-inline" name="detailForm">
				<div class="form-group">
					<select class="form-control" name="searchCondition">
						<option  value="0"  ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>회원ID</option>
						<option  value="1"  ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>회원명</option>
					</select>
				</div>
				
				<div class="form-group">
					<label class="sr-only" for="searchKeyword">검색어</label>
					<input type="text" class="form-control" name="searchKeyword" title="대소문자를 구별합니다." placeholder="검색어"
						value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  > 
				</div>
				
				<button type="button" class="btn btn-default">검색</button>
				
				<input type="hidden" id="currentPage" name="currentPage" value="" />
				
			</form>
		</div>
	
	<table class="table table-hover table-striped" >
		
		<thread>
			<tr>
	            <th align="center">No</th>
	            <th align="left" >회원 ID</th>
	            <th align="left">회원명</th>
	            <th align="left">이메일</th>
	            <th align="left">간략정보</th>
          	</tr>
		</thread>
		
		<tbody>
		  <c:set var="i" value="0" />
		  <c:forEach var="user" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left"  title="상세보기">${user.userId}</td>
			  <td align="left">${user.userName}</td>
			  <td align="left">${user.email}</td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id="${user.userId}"></i>
			  	<input type="hidden" value="${user.userId}">
			  </td>
			</tr>
          </c:forEach>
               
        </tbody>
		
		
		
	</table>
	
	</div>
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	
</body>

</html>