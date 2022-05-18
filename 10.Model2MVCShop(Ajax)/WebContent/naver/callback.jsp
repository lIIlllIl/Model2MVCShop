<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("rXAFxeCHrAqZhgl5N4ZV", "http://localhost:8080/naver/callback.jsp");
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {

	var obj = new Object();
	
	obj.name = naver_id_login.getProfileData('name');
	obj.email = naver_id_login.getProfileData('email');
	
	var name = naver_id_login.getProfileData('name');
	var email = naver_id_login.getProfileData('email');
	
	$.ajax(
			{
				url : "/user/json/naverLogin" , 
				method : "post" , 
				dataType : "json" , 
				headers : {
					"Accept" : "application/json" , 
					"Content-Type" : "application/json"
				} , 
				data : JSON.stringify({
					name : name , 
					email : email 
				})
			  
			}
	)
	self.close();
	
  }
</script>
</body>
</html>