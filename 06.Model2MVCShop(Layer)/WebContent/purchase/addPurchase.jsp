<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 
<%@ page import="com.model2.mvc.service.domain.*" %>

<%
	Purchase purchase = (Purchase)request.getAttribute("purchase");
%>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ų���</title>
</head>
<body>

<form name="detailForm" action="/listUser.do" method="post">
		<c:set var="tranCode" value="${fn:trim(param.tranCode) }" />
		<c:if test="${tranCode != '5' }" >
			������ ���� ���Ű� �Ǿ����ϴ�.
		</c:if>
		<c:if test="${tranCode == '5' }" >
			������ ���� ��ٱ��Ͽ� �߰��Ǿ����ϴ�.
		</c:if>
		<table border=1>
			<tr>
				<td>��ǰ��ȣ</td>
				<td>${purchase.purchaseProd.prodNo }</td>
				<td></td>
			</tr>
			<tr>
				<td>�����ھ��̵�</td>
				<td>${purchase.buyer.userId }</td>
				<td></td>
			</tr>
			<tr>
				<td>���Ź��</td>
				<td>
					<c:if test="${purchase.paymentOption == '1' }" >
						���ݱ��� 
					</c:if>
					<c:if test="${purchase.paymentOption == '2' }" > 
						�ſ뱸��
					</c:if>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>���ż���</td>
				<td>${purchase.tranCount }</td>
				<td></td>
			</tr>
			<tr>
				<td>�������̸�</td>
				<td>${purchase.receiverName }</td>
				<td></td>
			</tr>
			<tr>
				<td>�����ڿ���ó</td>
				<td>${purchase.receiverPhone }</td>
				<td></td>
			</tr>
			<tr>
				<td>�������ּ�</td>
				<td>${purchase.divyAddr }</td>
				<td></td>
			</tr>
				<tr>
				<td>���ſ�û����</td>
				<td>${purchase.divyRequest }</td>
				<td></td>
			</tr>
			<tr>
				<td>����������</td>
				<td>${purchase.divyDate }</td>
				<td></td>
			</tr>
		</table>
		</form>
</body>
</html>