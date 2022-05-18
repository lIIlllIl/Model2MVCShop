<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>구매내역</title>
</head>
<body>

<form name="detailForm" action="/listUser.do" method="post">

			다음과 같이 장바구니에 추가되었습니다.

		<table border=1>
			<tr>
				<td>물품번호</td>
				<td>${purchase.purchaseProd.prodNo }</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자아이디</td>
				<td>${purchase.buyer.userId }</td>
				<td></td>
			</tr>
			<tr>
				<td>구매방법</td>
				<td>
					<c:if test="${purchase.paymentOption == '1' }" >
						현금구매 
					</c:if>
					<c:if test="${purchase.paymentOption == '2' }" > 
						신용구매
					</c:if>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>구매수량</td>
				<td>${purchase.tranCount }</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자이름</td>
				<td>${purchase.receiverName }</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자연락처</td>
				<td>${purchase.receiverPhone }</td>
				<td></td>
			</tr>
			<tr>
				<td>구매자주소</td>
				<td>${purchase.divyAddr }</td>
				<td></td>
			</tr>
				<tr>
				<td>구매요청사항</td>
				<td>${purchase.divyRequest }</td>
				<td></td>
			</tr>
			<tr>
				<td>배송희망일자</td>
				<td>${purchase.divyDate }</td>
				<td></td>
			</tr>
		</table>
		</form>
</body>
</html>