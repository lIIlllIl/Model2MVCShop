<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="EUC-KR">
	
	<title>Model2 MVC Shop</title>

	<link href="/css/left.css" rel="stylesheet" type="text/css">
	
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
	
		//==> jQuery ���� �߰��� �κ�
		 $(function() {
			 $( ".Depth03:contains('�ֱ� �� ��ǰ')").on("click", function() {
				 window.open("/product/history",
							"popWin",
							"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
			 })
			 
		 	$( ".Depth03:contains('����������ȸ')" ).on("click" , function() {
				$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
			});
			
		 	$( ".Depth03:contains('ȸ��������ȸ')" ).on("click" , function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
			}); 
		 	
		 	$( ".Depth03:contains('�ǸŻ�ǰ���')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/addProduct");
		 	})
		 	
		 	$( ".Depth03:contains('�� ǰ �� ��')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct?menu=search")
		 	})
		 	
		 	$( ".Depth03:contains('�ǸŻ�ǰ����')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct?menu=manage")
		 	})
		 	
		 	$( ".Depth03:contains('�Ǹ���Ȳ')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listSale")
		 	})
		 	
		 	$( ".Depth03:contains('������Ȳ')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listDiscount")
		 	})
		 	
		 	$( ".Depth03:contains('�����̷���ȸ')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listPurchase")
		 	})
		 	
		 	$( ".Depth03:contains('��ٱ���')").on("click", function() {
		 		$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listWishPurchase")
		 	})
		 	
		 	$( ".Depth03").on("mouseenter", function() {
		 		$(this).stop().animate({
		 			fontSize:"130%",
		 			
		 		}, 1000 ).css("font-weight", "bold")
		 	})
		 	
		 	$( ".Depth03").on("mouseleave", function() {
		 		$(this).stop().animate({
		 			fontSize:"100%"
		 		}, 1000 ).css("font-weight", "normal")
		 	})
		 	
		});	
		 
	</script>
	
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">
							����������ȸ
						</td>
					</tr>
				</c:if>
			
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03" >
							ȸ��������ȸ
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
<c:if test="${user.role == 'admin'}">
	<tr>
		<td valign="top"> 
			<table  border="0" cellspacing="0" cellpadding="0" width="159">
				<tr>
					<td class="Depth03">
						�ǸŻ�ǰ���
					</td>
				</tr>
				<tr>
					<td class="Depth03">
						�ǸŻ�ǰ����
					</td>
				</tr>
				<tr>
					<td class="Depth03">
						�Ǹ���Ȳ
					</td>
				</tr>
				<tr>
					<td class="Depth03">
						������Ȳ
					</td>
				</tr>
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					�� ǰ �� ��
				</td>
			</tr>
			
			<c:if test="${ !empty user && user.role == 'user'}">
			<tr>
				<td class="Depth03">
					�����̷���ȸ
				</td>
			</tr>
			<tr>
				<td class="Depth03">
					��ٱ���
				</td>
			</tr>
			</c:if>
			
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			<tr>
				<td class="Depth03">�ֱ� �� ��ǰ</a></td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>

</html>