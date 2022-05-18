<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
   	<script type="text/javascript" 
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=06b2fb2ec173631c635bc48f1c7729ac&libraries=services"></script>
	<script type="text/javascript">

	function searchDetailAddrFromCoords(coords, callback) {
    	geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
	
	</script>
</head>
	
<body>

	<jsp:include page="/layout/toolbar.jsp" />

   	<div class="container ">

      <div class="jumbotron">
        <h1>Model2 MVC Shop </h1>
        <p>J2SE, DBMS, JDBC, Servlet & JSP, Java Framework, HTML5, UI Framework 학습 후 Mini-Project 진행</p>
     </div>
    </div>

	<div class="container">
        <h4><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;&nbsp;현재위치</h4> 
		<hr/>
		<br/>
		<div id="map" style="width:500px;height:350px;"></div>
		
		<script>
		var mapContainer = document.getElementById('map'), 
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.499526740945925, 127.02925836185794), 
		        level: 3
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		var geocoder = new kakao.maps.services.Geocoder();
		
		var marker = new kakao.maps.Marker({
			position : map.getCenter() 
		}); 
		
		marker.setMap(map);
		
		var mapTypeControl = new kakao.maps.MapTypeControl();
		map.addControl(mapTypeControl , kakao.maps.ControlPosition.TOPRIGHT);
		
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		var infowindow = new kakao.maps.InfoWindow({zindex:1});
		
		searchDetailAddrFromCoords(map.getCenter(), function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
		        var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		        detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		        
		        var content = '<div class="bAddr">' +
		                        '<span class="title">주소정보</span>' + 
		                        detailAddr + 
		                    '</div>';
		
		        infowindow.setContent(content);
		        infowindow.open(map, marker);
		    }
		});
		
		
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		
			searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            var content = '<div class="bAddr">' +
		                            '<span class="title">주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';
		
		            marker.setPosition(mouseEvent.latLng);
		            marker.setMap(map);
		
		            infowindow.setContent(content);
		            infowindow.open(map, marker);
		        }   
		    });
		   
		});
		
		</script>
	<hr/>
  	</div>

</body>

</html>