<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<head>
<meta charset="EUC-KR">

<script type="text/javascript" >
	$(function(){
		$("#keyword").on("keydown", function(key){
			if ( key.keyCode == 13 ) {
				alert("엔터키 입력");
				
				var searchKeyword = $("#keyword").val();
				var incoding = escape(searchKeyword);
				
				var obj = new Object();
				obj.searchKeyword = $("#keyword").val();
				
				$.ajax(
						{
							url : "/product/json/naverSearch" , 
							method :"post" , 
							dataType : "json" , 
							headers : {
								"Accept" : "application/json" , 
								"Content-Type" : "application/json"
							} , 
							data : JSON.stringify({
								searchKeyword : searchKeyword  
							}) , 
							success : function( JSONData , status ) {
								alert("asdfasdf");
								alert(JSONData);
							}
						}
				)
			}
		})
	})
</script>

</head>
<body>

<input type="text" id="keyword" val=""> 

</body>
</html>