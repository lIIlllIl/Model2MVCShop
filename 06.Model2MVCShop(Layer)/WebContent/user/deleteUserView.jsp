<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>회원탈퇴</title>

<script type="text/javascript">

<!-- 
function fncCheckPassword(){
	var check = ${user.password};
	if ( document.getElementById("userPassword").value == check ) {
		alert('회원탈퇴 진행을 시작합니다.')
		document.detailForm.action='/updateUserState.do';
		document.detailForm.submit();
	}
	else {
		alert('잘못된 비밀번호입니다.')
	}
	document.getElementById("userId").focus(); 
}


-->

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" method="post">
<table width="580px" border="1" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6">
		회원탈퇴를 위해 비밀번호를 입력해주시기 바랍니다.
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6">
		<input 	type="password" id="userPassword" name="userPassword"
				onkeydown = "javascript:if (event.keyCode == 13 ) { fncCheckPassword(); }"
				/>
		</td>
	</tr>
	
</table>
</form>
</div>
</body>

</html>