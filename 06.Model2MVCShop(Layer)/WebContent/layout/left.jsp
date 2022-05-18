<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="com.model2.mvc.service.domain.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function history() {
	popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
}

function checkUserState() {
	var a = ${user.userState};
	if (a == '1') {
		alert('���� ȸ��Ż������� �������Դϴ�.');
	}
}
</script>

</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<script type="text/javascript">
checkUserState()
</script>

	<table width="159" border="0" cellspacing="0" cellpadding="0">
		
		<!--menu 01 line-->
		<c:if test="${user.userState == '0' }" >

		<tr>
			<td valign="top"> 
				<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
					<c:if test="${ ! empty user }" >
						<tr>
							<td class="Depth03">
								<a href="/getUser.do?userId=${user.userId }" target="rightFrame">����������ȸ</a>
							</td>
						</tr>
					</c:if>
					
					<c:if test="${user.role == 'admin' }" >
						<tr>
							<td class="Depth03" >
								<a href="/listUser.do" target="rightFrame">ȸ��������ȸ</a>
							</td>
						</tr>
					</c:if>
					
					<tr>
						<td class="DepthEnd">&nbsp;</td>
					</tr>
					
				</table>
			</td>
		</tr>
		
		<!--menu 02 line-->
		<c:if test="${ user.role == 'admin' }">
			<tr>
				<td valign="top"> 
					<table  border="0" cellspacing="0" cellpadding="0" width="159">
						<tr>
							<td class="Depth03">
								<a href="../product/addProductView.jsp;" target="rightFrame">�ǸŻ�ǰ���</a>
							</td>
						</tr>
						<tr>
							<td class="Depth03">
								<a href="/listProduct.do?menu=manage"  target="rightFrame">�ǸŻ�ǰ����</a>
							</td>
						</tr>
						<tr>
							<td class="Depth03">
								<a href="/listSale.do" target="rightFrame">�Ǹ���Ȳ</a>
							</td>
						</tr>
						<tr>
							<td class="Depth03">
								<a href="/listDiscount.do" target="rightFrame">������Ȳ</a>
							</td>
						</tr>
						<tr>
							<td class="DepthEnd">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:if>
	</c:if>	
	
	<!--menu 03 line-->
	<c:if test="${user.userState != '0' && ! empty user }">
		<tr>
			<td valign="top"> 
				<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
					<tr>
						<td class="Depth03">
							<a href="/getUser.do?userId=${user.userId }" target="rightFrame">ȸ��Ż�����</a>
						</td>
					</tr>
				</table>
	</c:if>
		<tr>
			<td valign="top"> 
				<table  border="0" cellspacing="0" cellpadding="0" width="159">
					<c:if test="${ user.userState != '1'  }" >
						<tr>
							<td class="Depth03">
								<a href="/listProduct.do?menu=search" target="rightFrame">�� ǰ �� ��</a>
							</td>
						</tr>
					</c:if>
					<c:if test="${ ! empty user }" >
						<c:if test="${ user.userState != '1' }" >
							<c:if test="${ user.role == 'user' }" >
								<tr>
									<td class="Depth03">
										<a href="/listPurchase.do"  target="rightFrame">�����̷���ȸ</a>
									</td>
								</tr>
								<tr>
									<td class="Depth03">
										<a href="/listWishPurchase.do"  target="rightFrame">��ٱ���</a>
									</td>
								</tr>
							</c:if>
						</c:if>
					</c:if>
					<tr>
						<td class="DepthEnd">&nbsp;</td>
					</tr>
					<c:if test="${! empty user }" >
					<tr>
						<td class="Depth03">
							<a href="javascript:history()">�ֱ� �� ��ǰ</a>
						</td>
					</tr>
					</c:if>
					
					<c:if test="${empty user }" >
					<tr>
						<td class="Depth03">
							<a href="/history.jsp" 
								onclick="window.open(this.href, '_blank', 'left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no'); return false">�ֱ� �� ��ǰ</a>
						</td>
					</tr>
					</c:if>
 				</table>

			</td>

		</tr>

	</table>

</body>
</html>
