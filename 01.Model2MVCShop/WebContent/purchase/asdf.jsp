<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="com.model2.mvc.service.purchase.vo.*" %>

<%
	PurchaseVO purchaseVO = (PurchaseVO)request.getAttribute("purchaseVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ų���</title>
</head>
<body>
		������ ���� ���Ű� �Ǿ����ϴ�.
		
		<table border=1>
			<tr>
				<td>��ǰ��ȣ</td>
				<td><%=purchaseVO.getPurchaseProd().getProdNo() %></td>
				<td></td>
			</tr>
			<tr>
				<td>�����ھ��̵�</td>
				<td><%=purchaseVO.getBuyer().getUserId() %></td>
				<td></td>
			</tr>
			<tr>
				<td>���Ź��</td>
				<td>
				<% if (purchaseVO.getPaymentOption().equals("1")) { %>
					���ݱ���
				<% } else { %>
					�ſ뱸��
				<% } %>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>�������̸�</td>
				<td><%=purchaseVO.getReceiverName() %></td>
				<td></td>
			</tr>
			<tr>
				<td>�����ڿ���ó</td>
				<td><%=purchaseVO.getReceiverPhone() %></td>
				<td></td>
			</tr>
			<tr>
				<td>�������ּ�</td>
				<td><%=purchaseVO.getDivyAddr() %></td>
				<td></td>
			</tr>
				<tr>
				<td>���ſ�û����</td>
				<td><%=purchaseVO.getDivyRequest() %></td>
				<td></td>
			</tr>
			<tr>
				<td>����������</td>
				<td><%=purchaseVO.getDivyDate() %></td>
				<td></td>
			</tr>
		</table>
</body>
</html>