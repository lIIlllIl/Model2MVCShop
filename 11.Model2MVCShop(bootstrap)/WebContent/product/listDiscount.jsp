<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>상품 목록조회</title>
	
	<style>
 		body { 
            padding-top : 50px; 
        }
         
        .ui-autocomplete {
	            max-height: 150px;
	            overflow-y: auto;
	            overflow-x: hidden;
	            padding-right: 20px;
	    } 
     </style>
    
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
	
	<script type="text/javascript">

	function fncGetList(currentPage){
	
		var condition = $("select[name='searchCondition']").val();
	
		if ( condition == '4' && document.detailForm.searchKeyword.value != ""  ) {
			var price = $("input[name='searchKeyword']").val();
			var co = price.indexOf('~');
			var ch = price.charAt(co + 1);
			var pront = price.substring(0, co);
			var back = price.substring(co + 1);
			
			if ( price.indexOf('~') == -1 ) {
				alert('~ 기호를 추가해서 검색해주세요.');
				$( ".input[name='searchKeyword']").focus();
				event.preventDefault();
			} 
			else if ( price.indexOf('~') < 1 || (price.match(/~/g) || []).length != 1 || ch == null || ch == "undefined" || ch == "" ) {
				alert('정확한 범위를 입력해주세요.');
				$( "input[name='searchKeyword']").focus();
				event.preventDefault();
			}
			else if ( isNaN(pront) || isNaN(back) ) {
				alert('숫자를 입력해주세요.');
				$( "input[name='searchKeyword']").focus();
				event.preventDefault();
			}
			
			else {
				alert(currentPage)
				$( "input[name='currentPage']" ).val(currentPage);
				$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();
			}
		}
		else if ( condition == '2' || condition == '3'  ) {
			var price = $("input[name='searchKeyword']").val();
			
			if ( isNaN(price) ) {
				alert('숫자를 입력해주세요.');
				$("input[name='searchKeyword']").focus();
				event.preventDefault();	
			}
			else {
				$( "input[name='currentPage']" ).val(currentPage)
				$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();
			}
		}
		else if ( condition == '0' ) {
			var prodNo = $("input[name='searchKeyword']").val();
			
			if ( isNaN(prodNo) ) {
				alert('숫자를 입력해주세요.');
				$("input[name='searchKeyword']").focus();
				event.preventDefault();	
			}
			else {
				$( "input[name='currentPage']" ).val(currentPage);
				$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();
			}
		}
		else {
			$( "input[name='currentPage']" ).val(currentPage);
			$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();	
		}
	}
	
	function fndAlertCheck() {
		alert('상품정보를 수정할 수 없는 상태입니다.');
	}
	
	$(function() {
		
		$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
		
		$("input[name='searchKeyword']").on("keydown", function(key){
			if ( key.keyCode == 13 ) {
				fncGetList(1);
			}
		});
		
		$(".btn-default:contains('검색')").on("click", function() {
			fncGetList(1);
		});
		
		$("select[name='searchPrice']").on("change", function(){
			fncGetList(1);
		});
		
		$("h7").css("color", "red").css({"font-size":"13px"});
		
		$("span[name='page']").on("click", function() {
			var currentPage = $(this).text().trim();
			
			fncGetList(currentPage);
		})
		
		$( "span" ).on("mouseenter", function() {
		 	$(this).stop().animate({ }, 1000 ).css("font-weight", "bold")
		 })
		 	
		$( "span" ).on("mouseleave", function() {
		 	$(this).stop().animate({ }, 1000 ).css("font-weight", "normal")
		})
		
		$("span[name='before']").on("click", function() {
			var currentPage = ${ resultPage.beginUnitPage - 1};
			
			fncGetList(currentPage);
		})
		
		$("span[name='after']").on("click", function() {
			var currentPage = ${resultPage.endUnitPage + 1};
			
			fncGetList(currentPage);
		})
		
		$(".ct_list_pop td:nth-child(3)").on("click", function() {
			var prodNo = $(this).children("input[name='prodNo']").val();
			
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
							var displayValue = 	"<h3>" + 
												"상품명 : " + JSONData.product.prodName + "<br/>" + 
												"상세설명 : " + JSONData.product.prodDetail + "<br/>" + 
												"<br/><br/>" + "<span name='saw'>상세보기</span></h3>"
					
							$("h3").remove();
							$("#"+prodNo+"").html(displayValue);
							
							$("span[name='saw']").on("click", function() {
								self.location = "/product/getProduct?prodNo="+JSONData.product.prodNo+"&menu=dcCheck";
							})						
						}
					}
			)
		
		});
		
		$("select[name='searchCondition']").on("change", function(){
			if ( $("select[name='searchCondition']").val() == '1' || $("select[name='searchCondition']").val() == '0'  ) {
				$("input[name='searchKeyword']").autocomplete( "enable" );
			}
			
			if ( $("select[name='searchCondition']").val() != '1' && $("select[name='searchCondition']").val() != '0'  ) {
				$("input[name='searchKeyword']").autocomplete( "disable" );
			}
	
		})
		
		
		$("input[name='searchKeyword']").autocomplete({
			
			source : function( request , response ) {
				var searchCondition = $("select[name='searchCondition']").val();
				var type = '';
				var restUrl = "/product/json/enterProduct";
				
				
				if ( searchCondition == '1' ) {
					type = "prodName";
				}
				if ( searchCondition == '0' ) {
					type = "prodNo";
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
		
	});
	
	</script>
	
    <script type="text/javascript">
    var delta = 50;
	var timer = null;
	var currentPage = 2;
    
	function getProduct(){
		var prodNo = $(this).children("input[name='prodNo']").val();
		self.location = "/product/getProduct?prodNo=" + prodNo + "&menu=search";
	}
	
	function getFormatDate(date){
	    var year = date.getFullYear();              
	    var month = (1 + date.getMonth());         
	    month = month >= 10 ? month : '0' + month;  
	    var day = date.getDate();                   
	    day = day >= 10 ? day : '0' + day;          
	    return  year + '' + month + '' + day;
	}
	
	$( function() {
		
		
		$(window).scroll(function(){
			clearTimeout( timer );
		    timer = setTimeout( scrollProduct, delta );
		})
		
		$(".btn-default:contains('상세보기')").on("click", function(){
			var prodNo = $(this).children("input[name='prodNo']").val();
			console.log("prodNo : " + prodNo);
			self.location = "/product/getProduct?prodNo=" + prodNo + "&menu=search";
		})
	
	});
	
	function scrollProduct() {

 		if( $(document).height() <= $(window).scrollTop() + $(window).height() ){
 			
 			
 			if ( ${resultPage.maxPage} >= currentPage ) {
 				$.ajax(  
   
 	 					{
 	 						url : "/product/json/listDiscount/" + currentPage , 
 	 						method : "get" , 
 	 						dataType : "json" , 
 	 						headers : {
 	 							"Accept" : "application/json" , 
 	 							"Content-Type" : "application/json"
 	 						} , 
 	 						success : function( JSONData, status ) {
 	 							currentPage = currentPage + 1;
 	 							var display = "";
 	 							var count = 0;
 	 							display += "<div class='row'>";
 	 							for ( count = 0; count < JSONData.list.length; count++) { 
 	 								display += "<div class='col-xs-4 col-md-4'>";
 	 								display += "<div class='thumbnail'>";
 	 								display += "<img class='img-rounded' src='../images/uploadFiles/" + JSONData.list[count].product.fileName.split("/")[0] + "' width='200' height='200' />";
 	 								display += "<div class='caption'>";
 	 								display += "<h1 class='text-primary'><span class='glyphicon glyphicon-shopping-cart'></span>&nbsp;&nbsp;&nbsp;" + JSONData.list[count].product.prodName + "</h1>";
 	 								display += "<br/>";
 	 								display += "<br/>"; 
 	 								display += "<h4><p><span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;&nbsp;" + JSONData.list[count].startDate + " ~ " + JSONData.list[count].endDate + "</p></h4>"; 
 	 								display += "<h4><p><span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;&nbsp;상품번호 : " + JSONData.list[count].product.prodNo + "</p></h4>";
 	 								display += "<h4><p><span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;&nbsp;원가 : " + JSONData.list[count].product.costPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</p></h4>";
 	 								display += "<h4><p><span class='glyphicon glyphicon-asterisk'></span>&nbsp;&nbsp;&nbsp;할인가 : " + JSONData.list[count].product.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</p></h4>";

 	 								display += "<br/>";
 	 								
 	 								display += "<h4 name='saleCheck'>";
 	 								display += "<input type='hidden' id='prodNo' name='prodNo' value='"+JSONData.list[count].product.prodNo+"'/>";
 	 								display += "현재 ";
 	 								if ( JSONData.list[count].eventType == '1') {
 	 									var date = new Date();
 	 	 								var today = getFormatDate(date);
 	 	 								var startDate = JSONData.list[count].startDate.toString().substring(0, 4) + JSONData.list[count].startDate.toString().substring(5, 7) + JSONData.list[count].startDate.toString().substring(8, 10);
 	 	 								var endDate = JSONData.list[count].endDate.toString().substring(0, 4) + JSONData.list[count].endDate.toString().substring(5, 7) + JSONData.list[count].endDate.toString().substring(8, 10);

 	 	 								if( eval(today) >= eval(startDate) ) {
 	 	 									display += "할인 진행중 ";
 	 	 								}
 	 	 								else {
 	 	 									display += "할인 예정된 ";
 	 	 								}	
									}
 	 								else if ( JSONData.list[count].eventType == '2') {
										display += "할인 취소된 ";
									}
 	 								display += "상품 입니다.";
 	 								display += "</h4>";	
 	 								display += "<br/>";
 	 								display += "<br/>";
 	 								
 	 								display += "<p><a class='btn btn-default' href='#' role='button'><span class='glyphicon glyphicon-search'></span>";
 	 								display += "<input type='hidden' name='prodNo' value='"+JSONData.list[count].product.prodNo+"'/>";
 	 								display += "&nbsp;&nbsp;&nbsp; 상세보기 &raquo;</a></p>";
 	 								 
									display += "</div>";
									display += "</div>";
									display += "</div>";
 	 							}
 	 							display += "</div>";
 	 							display += "<span></span>";
 
 	 							$("span:last").append(display);
 	 							
 	 							$(".btn-default:contains('상세보기')").on("click", function(){
 	 								var prodNo = $(this).children("input[name='prodNo']").val();
 	 								console.log("prodNo : " + prodNo);
 	 								self.location = "/product/getProduct?prodNo=" + prodNo + "&menu=search";
 	 							})
 	 						}
 	 					}
 	 			)
 			}
 						
 		}
 	}
	</script>	
		
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="page-header text-info">
		<h3>할인현황</h3>
		<h6>전체 ${resultPage.totalCount } 건수 </h6>
	</div>
	
	<div class="container">
	<br/><br/>
		<div class="row">
		<c:forEach var="event" items="${list }" >
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
			<fmt:parseDate  value="${event.startDate}" pattern="yyyy-MM-dd" var="startDate" />	
			<fmt:parseDate  value="${event.endDate}" pattern="yyyy-MM-dd" var="endDate" />	
					
			<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" var="start"/>
			<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" var="end"/>
				<div class="col-xs-4 col-md-4">
					<div class="thumbnail">
						<img class="img-rounded" src="../images/uploadFiles/${event.product.fileName}" width="200" height="200" />
						<div class="caption">
							<h1 class="text-primary"><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;&nbsp;&nbsp;${event.product.prodName}</h1>
							<br/>
							<br/>
							<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp;${event.startDate} ~ ${event.endDate }</p></h4>
							<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp;상품번호 : ${event.product.prodNo }</p></h4>
							<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp;원가 : <fmt:formatNumber value="${event.product.costPrice }" pattern="#,###" /></p></h4>
							<h4><p><span class="glyphicon glyphicon-asterisk"></span>&nbsp;&nbsp;&nbsp;할인가 : <fmt:formatNumber value="${event.product.price }" pattern="#,###" /></p></h4>
							<fmt:parseDate var="dateString" value="${event.product.manuDate }" pattern="yyyyMMdd" />
							<br/>
							<h4><p>현재		
							<c:if test="${event.eventType == '1' && start <= today && today <= end }" >
								할인 진행중 
							</c:if>
							
							<c:if test="${event.eventType == '1' && end < today }" >
								할인 종료된
							</c:if>
							
							<c:if test="${event.eventType == '1' && start > today }" >
								할인 예정된
							</c:if>
			
							<c:if test="${event.eventType == '2' }">
								할인 취소된
							</c:if>
							
							상품 입니다.</p></h4>
							<br/>
							<br/>
							<p><a class="btn btn-default" href="#" role="button"><span class="glyphicon glyphicon-search"></span>
							<input type="hidden" name="prodNo" value="${event.product.prodNo }"/>&nbsp;&nbsp;&nbsp; 상세보기 &raquo;</a></p>
						</div>
					</div>
				</div>
			
		</c:forEach>
		
		
		</div>
		<span></span>
	</div>
	
	
		
		
</body>
</html>