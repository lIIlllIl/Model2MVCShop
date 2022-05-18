<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>

<%
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");

	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	
	String check = request.getParameter("menu");
	System.out.println(">>>>>>>>>>>>>>>>>>>"+check+"<<<<<<<<<<<<<<<<<<<<<");
	String title = "";
	
	if (request.getParameter("menu").equals("manage")) {
		title = "��ǰ����";
	}
	else {
		title = "��ǰ �����ȸ";
	}
	
	
%>
--%>

<html>
<head>
<title>��ǰ �����ȸ-Manage</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">



function fncGetList(currentPage){
	
	var condition = document.detailForm.searchCondition.value;

	if ( condition == '4' && document.detailForm.searchKeyword.value != ""  ) {
		var price = document.detailForm.searchKeyword.value;
		var co = price.indexOf('~');
		var ch = price.charAt(co + 1);
		var pront = price.substring(0, co);
		var back = price.substring(co + 1);
		
		if ( price.indexOf('~') == -1 ) {
			alert('~ ��ȣ�� �߰��ؼ� �˻����ּ���.');
			document.getElementById("searchKeyword").focus();
			event.preventDefault();
		} 
		else if ( price.indexOf('~') < 1 || (price.match(/~/g) || []).length != 1 || ch == null || ch == "undefined" || ch == "" ) {
			alert('��Ȯ�� ������ �Է����ּ���.');
			document.getElementById("searchKeyword").focus();
			event.preventDefault();
		}
		else if ( isNaN(pront) || isNaN(back) ) {
			alert('���ڸ� �Է����ּ���.');
			document.getElementById("searchKeyword").focus();
			event.preventDefault();
		}
		
		else {
			document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.submit();
		}
	}
	else if ( condition == '2' || condition == '3'  ) {
		var price = document.detailForm.searchKeyword.value;
		
		if ( isNaN(price) ) {
			alert('���ڸ� �Է����ּ���.');
			document.getElementById("searchKeyword").focus();
			event.preventDefault();	
		}
		else {
			document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.submit();
		}
	}
	else if ( condition == '0' ) {
		var prodNo = document.detailForm.searchKeyword.value;
		
		if ( isNaN(prodNo) ) {
			alert('���ڸ� �Է����ּ���.');
			document.getElementById("searchKeyword").focus();
			event.preventDefault();	
		}
		else {
			document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.submit();
		}
	}
	else {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();	
	}
}

function fndAlertCheck() {
	alert('��ǰ������ ������ �� ���� �����Դϴ�.');
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do?menu=${param.menu }" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">${param.menu == "search" ? "��ǰ �����ȸ" : "��ǰ����"  }</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	
		<c:if test="${param.menu == 'search' }" >
			<td>
				��������  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select name="searchPrice" id="searchPrice" class="ct_input_g" style="width:100px" onchange="javascript:fncGetList(1)">
					<option value="0" ${ ! empty search.searchPrice && search.searchPrice == 0 ? "selected" : "" }>���þ���</option>
					<option value="1" ${ ! empty search.searchPrice && search.searchPrice == 1 ? "selected" : "" }>��������</option>
					<option value="2" ${ ! empty search.searchPrice && search.searchPrice == 2 ? "selected" : "" }>��������</option>
				</select>
			</td>
		</c:if>
	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:150px" >
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>��ǰ����-����</option>
				<option value="3" ${ ! empty search.searchCondition && search.searchCondition == 3 ? "selected" : "" }>��ǰ����-�̻�</option>
				<option value="4" ${ ! empty search.searchCondition && search.searchCondition == 4 ? "selected" : "" }>��ǰ����-����</option>
			</select>
					<input 	type="text" name="searchKeyword" id="searchKeyword"
							value="${! empty search.searchKeyword ? search.searchKeyword : ""}" class="ct_input_g" 
							style="width:200px; height:20px" 
							onkeydown = "javascript:if ( event.keyCode == 13 ) { fncGetList(1); }" />		
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="15" >��ü ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage } ������</td>
	</tr>
	
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="130">��ǰ��</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100">����</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="50" >�����</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >��������</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="20" >����</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="50" >�����Ȳ</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="350">���ο���</td>
		<td class="ct_line02"></td>
		
	</tr>
	
	<tr>
		<td colspan="15" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
		<c:forEach var="product" items="${list }" >
			<c:set var="i" value="${i + 1 }" />
			
			<tr class="ct_list_pop">
			
				<td align="center">${product.prodNo }
				<td></td>
				
				<td align="left">
					<a href="/getProduct.do?prodNo=${product.prodNo }&menu=${param.menu}">${product.prodName }</a>
				</td>
				<td></td>
				
				<td align="left">
					<fmt:formatNumber value="${product.price }" type="currency" />
				</td>
				<td></td>
				
				<td align="left">${product.regDate }</td>
				<td></td>
				
				<td align="left">
					<fmt:parseDate var="dateString" value="${product.manuDate }" pattern="yyyyMMdd" />
					<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
				</td>
				
				<td align="left">
					<c:if test="${ empty product.fileName  }">
							�������� 
					</c:if>
					<c:if test="${ ! empty product.fileName  }">
							<td align="left"><img src="images/uploadFiles/${product.fileName}" width="100" height="100" /></td>
					</c:if>
				</td>
				<td></td>
				
				<td align="left">
					<c:choose>
						<c:when test="${product.prodCount == 0 }" >
							�������
						</c:when>
						<c:otherwise>
							�Ǹ��� ��� : ${product.prodCount } ��
						</c:otherwise>
					</c:choose>
					
				</td>
				<td></td>
				<td align="left">
					<c:if test="${product.checkDC == 0 }" >
						���ξ���&nbsp;&nbsp;&nbsp;
						<a href="/getProduct.do?prodNo=${product.prodNo }&menu=discount">��������</a>
					</c:if>
					<c:if test="${product.checkDC == 1 }" >	
						������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
						<a href="/getProduct.do?prodNo=${product.prodNo }&menu=discount">�������</a>
					</c:if>
					</td>
				</td>
			</tr>

			<tr>
				<td colspan="15" bgcolor="D6D7D6" height="1"></td>
			</tr>
			
			</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
</table>
</form>
</div>

</body>
</html>