<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 생성하기</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=06b2fb2ec173631c635bc48f1c7729ac&libraries=services"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">
  function searchDetailAddrFromCoords(coords, callback) {
      geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
  }
 	
 	$(function(){
 		var addr = opener.$("input[name='divyAddr']").val();
 		
 		$("input[name='receiverAddr']").val(addr);
 		
		$("input[name='receiverAddr']").focus();
 		
 		$("input[name='receiverAddr']").on("keydown" , function(event) {	
 			if(event.keyCode == '13'){
 				var inputAddr = $("input[name='receiverAddr']").val();
 				
 				$("input[name='receiverAddr']").val(inputAddr);
 				runMap();
 			}
 		})
 		
 		$("span:contains('확인')").on("click" , function() {
 			window.close();
 		});
 		
 		
 	})
 	
 	function runMap() {
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
 		
 		var address = $("input[name='receiverAddr']").val();
 		
 		geocoder.addressSearch(address, function(result, status) {
 		
 		     if (status === kakao.maps.services.Status.OK) {
 		
 		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
 		     
 		        var returnAddr = result[0].road_address.address_name;
 				var addressAddr = result[0].address.address_name;
 				
 				
 				
 				$("input[name='witch']").val(addressAddr);
 				
 		        var detailAddr = 
 		        		!!result[0].road_address ? '<div>도로명주소 : ' + returnAddr + 
 		        				'</div>' : ''; 
 		        		detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
 		        
 		       	var content = 	'<div class="bAddr">' +
 		                		'<span class="title">주소정보</span>' + 
 		                		detailAddr + 
 		            			'</div>';		
 		
 		        var marker = new kakao.maps.Marker({
 		            map: map,
 		            position: coords
 		        });
 		
 		        var infowindow = new kakao.maps.InfoWindow({
 		            content: content 
 		        });
 		        
 		        infowindow.open(map, marker);
 		
 		        map.setCenter(coords);
 		    } 
 		});
 	}
</script>
    
</head>
<body>
<input type="hidden" id="witch" name="witch" value="서울특별시 강남구 역삼동 819-4"/>

주소를 검색해주세요 : 
<input type="text" name="receiverAddr" value="" width="350" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>확인</span>
<br/><hr/><br/>

<div id="map" style="width:500px;height:350px;"></div>

<script>
$(function(){
	runMap();
})


</script>

</body>
</html>