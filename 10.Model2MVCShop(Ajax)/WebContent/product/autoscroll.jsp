<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
var delta = 50;
var timer = null;
var currentPage = ${search.currentPage} + 1;

function scrollProduct() {
	if( $(window).scrollTop() == $(document).height() - $(window).height() ){
		if ( ${resultPage.maxPage} >= currentPage ) {
			$.ajax(
					{
						url : "/product/json/listProduct/" + currentPage , 
						method : "get" , 
						dataType : "json" , 
						headers : {
							"Accept" : "application/json" , 
							"Content-Type" : "application/json"
						} , 
						success : function( JSONData, status ) {
							alert("list length : " + JSONData.list.length);
							
							var i = 0;
							for (i = 0; i < JSONData.list.length; i++){
								alert(JSONData.list[i].product.prodNo);
							}
							
							alert("total : " + JSONData.total);
							alert("currentPage : " + JSONData.resultPage.currentPage);
							currentPage = currentPage + 1;
							
							var display = 	"<table>" + 
											"<tr>" + 
											"<td><h1>Page : " + (currentPage - 1) + " / total : ${resultPage.totalCount } / all : ${resultPage.maxPage }</h1></td>" + 
											"</tr>" + 
											"<tr><td> </td></tr>" + 
											"<tr>";
											
							var j = 0;
							for ( j = 0; j < JSONData.list.length; j++ ) {
								alert("JSONData : " + JSONData.list[j].product.prodName);
								display += "<td><table>";
								display += "<tr><td><h1>" + JSONData.list[j].product.prodName + " / " + JSONData.list[j].product.prodNo + "</h1></td></tr>";
								display += "</tr>";
								display += "</table></td>"
							}
							display += "</tr></table>";
							display += "<span></span>";
							
							$("span:last").append(display);
						}
					}
			)
		}
		else {
			alert("더 이상의 검색결과가 없습니다.");
		}
	}
} 

	$(function(){
		$("#scroll${search.currentPage}").on("click", function(){
			alert("abcd");
		})
		
			
		$(window).scroll(function(){
			clearTimeout( timer );
		    timer = setTimeout( scrollProduct, delta );
		
			
		})
		
	})
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >
	<table>
		<tr>
			<td>
				<h1>Page : ${search.currentPage } / total : ${resultPage.totalCount } / all : ${resultPage.maxPage }</h1>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<c:forEach var="event" items="${list }" >
				<td>
					<table>
						<tr>
							<td><h1>${event.product.prodName }</h1></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
						<c:set var="images" value="${fn:split(event.product.fileName , '/') }" />
							<td align="left">
								<c:forEach var="image" items="${images }" >
									<img src="../images/uploadFiles/${image}" width="500" height="500" />
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td><h1>${event.product.prodNo }</h1></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td><h1>${event.product.prodDetail }</h1></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
	<span></span>
</form>
</div>

</body>
</html>