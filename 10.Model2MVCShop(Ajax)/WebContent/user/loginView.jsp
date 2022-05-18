<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">

<title>로그인 화면</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript">

	$( function() {

		$("#userId").focus();

		$("img[src='/images/btn_login.gif']").on("click" , function() {

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
							$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
							$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
							$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
						}
						else {
							alert("아이디, 패스워드를 다시 입력해주세요.");
						}
					}
				}		
			)
			
			
		});
	});
	
	

	$( function() {
		$("img[src='/images/btn_add.gif']").on("click" , function() {
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
							success : function(JSONData , status ) {
								if ( JSONData != null ) {
									window.parent.document.location.reload();
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

<body bgcolor="#ffffff" text="#000000" >

<form>

<div align="center" >

<TABLE WITH="100%" HEIGHT="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<TR>
<TD ALIGN="CENTER" VALIGN="MIDDLE">

<table width="650" height="390" border="5" cellpadding="0" cellspacing="0" bordercolor="#D6CDB7">
  <tr> 
    <td width="10" height="5" align="left" valign="top" bordercolor="#D6CDB7">
    	<table width="650" height="390" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="305">
            <img src="/images/logo-spring.png" width="305" height="390"/>
          </td>
          <td width="345" align="left" valign="top" background="/images/login02.gif">
          	<table width="100%" height="220" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="30" height="100">&nbsp;</td>
                <td width="100" height="100">&nbsp;</td>
                <td height="100">&nbsp;</td>
                <td width="20" height="100">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="50">&nbsp;</td>
                <td width="100" height="50">
                	<img src="/images/text_login.gif" width="91" height="32"/>
                </td>
                <td height="50">&nbsp;</td>
                <td width="20" height="50">&nbsp;</td>
              </tr>
              <tr> 
                <td width="200" height="50" colspan="4"></td>
              </tr>              
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="/images/text_id.gif" width="100" height="30"/>
                </td>
                <td height="30">
                  <input 	type="text" name="userId"  id="userId"  class="ct_input_g" 
                  				style="width:180px; height:19px"  maxLength='50'/>          
          		</td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="/images/text_pas.gif" width="100" height="30"/>
                </td>
                <td height="30">                    
                    <input 	type="password" name="password" class="ct_input_g" 
                    				style="width:180px; height:19px"  maxLength="50" />
                </td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="20">&nbsp;</td>
                <td width="100" height="20">&nbsp;</td>
                <td height="20" align="center">
   				    <table width="136" height="20" border="0" cellpadding="0" cellspacing="0">
                       <tr> 
                         <td width="56">
                         	<img src="/images/btn_login.gif" width="56" height="20" border="0"/>
                         </td>
                         <td width="10">&nbsp;</td>
                         <td width="70">
                       		<img src="/images/btn_add.gif" width="70" height="20" border="0">
                         </td>
                       </tr>
                       <tr>
                       	<td width="10">&nbsp;</td>
                       </tr>
                       <table>
                       <tr>
                       	<td>
                       	<a id="kakao-login-btn"></a>
                       	
						<script type='text/javascript'>
							var id = '';
						    Kakao.init('06b2fb2ec173631c635bc48f1c7729ac');
						    Kakao.Auth.createLoginButton({
						      container: '#kakao-login-btn',
						      success: function(authObj) {
						        Kakao.API.request({
						          url: '/v2/user/me',
						          success: function(res) {
						            var obj = new Object();
						            obj.id = res['id'];
						            obj.nickname = res['properties']['nickname'];
						      
						       		$.ajax(
						       				{
						       					url : "/user/json/kakaoLogin" , 
						       					method : "post" , 
						       					dataType : "json" , 
						       					headers : {
						       						"Accept" : "application/json" , 
						       						"Content-Type" : "application/json" 
						       					} , 
						       					data : JSON.stringify({
						       						json : obj  
						       					}) , 
						       					success : function(){
						       						window.parent.document.location.reload();
						       					}
						       				} 
						       		)
						       		
						       		window.parent.document.location.reload();
						       		window.parent.document.location.reload();
						          },
						          fail: function(error) {
						            alert(JSON.stringify(error));
						            self.location = "/index.jsp";
						          }
						        });
						      },
						      fail: function(err) {
						        alert(JSON.stringify(err));
						        self.location = "/index.jsp";
						      }
						    });
						</script>
						 </td>
                       </tr>

                     </table>
                
                 <td width="20" height="20">&nbsp;</td>
                </tr>
              </table>
            </td>
      	</tr>                            
      </table>
      </td>
  </tr>
</table>
</TD>
</TR>
</TABLE>
	


</div>

</form>

</body>

</html>