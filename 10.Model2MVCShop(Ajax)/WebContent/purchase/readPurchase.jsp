<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>���Ż���ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

function fndAlertCheck() {
	alert('���������� ������ �� ���� �����Դϴ�.');
}

$(function() {
	$(".ct_btn01:contains('����')").on("click", function(){
		var tranNo = ${purchase.tranNo};
		var tranCode = $.trim(${purchase.tranCode});
		
		if ( tranCode == '1' ) {
			self.location = "/purchase/updatePurchase?tranNo="+tranNo;
		}
		
		if ( tranCode != '1' ) {
			fndAlertCheck();
		}
			
	})
	
	$(".ct_btn01:contains('Ȯ��')").on("click", function(){
		history.go(-1);
	})
		
});

</script>
<script>
$( function() {
	
		var userId = "${purchase.buyer.userId }";
		var prodNo = "${purchase.purchaseProd.prodNo }";
		
		$.ajax(
				{
					url : "/user/json/getUser/"+userId , 
					method : "get" , 
					dataType : "json" , 
					headers : {
						"Accept" : "application/json" , 
						"Content-Type" : "application/json"
					} , 
					success : function( JSONData, statau ) {
						var displayValue = 	"<h7>" + 
											"���̵� : " + JSONData.userId + "<br/>" + 
											"�� �� : " + JSONData.userName + "<br/>" + 
											"�� �� : " + JSONData.role + "</h7>";
											
						$("#user").attr("title", displayValue);
					}
				}
			);	
		
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
										"��ǰ�� : " + JSONData.product.prodName + "<br/>" + 
										"�󼼼��� : " + JSONData.product.prodDetail + "</h3>"
			
					$("#product").attr("title", displayValue);				
				}
			}
		)

		
	$(  document  ).tooltip({
		track: true , 
		content : function(){
			return $(this).prop('title');
		}
	});
	
	$("#address").on("click", function(){
		var tranNo = ${purchase.tranNo};

		popWin 
		= window.open("/kakao/checkMap.jsp",
									"popWin", 
									"left=100, top=90, width=800, height=500, marginwidth=0, marginheight=0,"+
									"scrollbars=no, scrolling=no, menubar=no, resizable=no");
	})
	

});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif"	width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���Ż���ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105" id="product">
					${purchase.purchaseProd.prodNo }</td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			�����ھ��̵� <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" id="user" >${purchase.buyer.userId }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">���Ź��</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<c:set var="tranCode" value="${fn:trim(purchase.paymentOption) }" />
			<c:if test="${tranCode == '1' }">
				���ݱ���
			</c:if>
			<c:if test="${tranCode == '2' }">
				�ſ뱸��
			</c:if>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������̸�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.receiverName }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�����ڿ���ó</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.receiverPhone }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" id="address" >${purchase.divyAddr }</td>
		<input type="hidden" name="divyAddr" value="${purchase.divyAddr }" />
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ſ�û����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.divyRequest }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		
		<fmt:parseDate value="${purchase.divyDate }" var="noticePostDate" pattern="yyyy-MM-dd"/>
		<fmt:formatDate value="${noticePostDate}" var="divyDate" pattern="yyyy-MM-dd"/>
		${divyDate }
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">�ֹ���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${purchase.orderDate }</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">��ۻ���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<c:set var="tranCode" value="${fn:trim(purchase.tranCode) }" />
		
		���� 		
		<c:if test="${tranCode == 1 }" >
			���ſϷ�	 
		</c:if>
		<c:if test="${tranCode == 2 }" >
			����� 
		</c:if>
		<c:if test="${tranCode == 3 }" >
			��ۿϷ� 	
		</c:if>
 		�����Դϴ�.
		
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	
	
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<c:if test="${user.role != 'admin' }" >
 						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
							����
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
						</td>
					</c:if>
					
					<td width="30"></td>
				
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						Ȯ��
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>