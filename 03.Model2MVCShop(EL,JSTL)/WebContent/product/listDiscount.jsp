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
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">



function fncGetList(currentPage){
	document.getElementById("currentPage").value = currentPage;
	document.detailForm.submit();	
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listSale.do?menu=${param.menu }" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� ��Ȳ</td>
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
		<td>
			��������  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="searchPrice" id="searchPrice" class="ct_input_g" style="width:100px" onchange="javascript:fncGetList(1)">
				<option value="0" ${ ! empty search.searchPrice && search.searchPrice == 0 ? "selected" : "" }>���þ���</option>
				<option value="1" ${ ! empty search.searchPrice && search.searchPrice == 1 ? "selected" : "" }>��������</option>
				<option value="2" ${ ! empty search.searchPrice && search.searchPrice == 2 ? "selected" : "" }>��������</option>
			</select>
		</td>

		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:150px" >
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
		<td colspan="17" >��ü ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage } ������</td>
	</tr>
	
	<tr>
		<td class="ct_list_b" width="80">��ǰ��ȣ</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="130">��ǰ��</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100">����</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >����</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >���ΰ�</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >������</td>	
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="50" >���αⰣ</td>	
		<td class="ct_line02"></td>

		<td class="ct_list_b" width="250" >����</td>	
		<td class="ct_line02"></td>
	</tr>
	
	<c:set var="i" value="0" />
		<c:forEach var="event" items="${list }" >
			<c:set var="i" value="${i + 1 }" />
	
			<tr class="ct_list_pop">
				<td>${event.product.prodNo}</td>
				<td></td>
				
				<td>${event.product.prodName}</td>
				<td></td>
				
				<td><img src="images/uploadFiles/${event.product.fileName}" width="100" height="100" /></td>
				<td></td>
				
				<td><fmt:formatNumber value="${event.product.costPrice }" type="currency" /></td>
				<td></td>
				
				<td><fmt:formatNumber value="${event.product.price }" type="currency" /></td>
				<td></td>
				
				<td>${event.dcPersent * 100 } [%]</td>
				<td></td>
				
				<td>
					<fmt:parseDate var="start" value="${event.startDate}" pattern="yyyy-MM-dd" />
					<fmt:parseDate var="end" value="${event.endDate}" pattern="yyyy-MM-dd" />
					<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" /> ~ 
					<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />
				</td>
				<td></td>
				
				<td>
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
					<fmt:parseDate var="endDate" value="${event.endDate}" pattern="yyyy-MM-dd" />	

					����		
					<c:if test="${event.product.checkDC == '1' && sysdate >= today }" >
						���� ������ 
					</c:if>
					
					<c:if test="${event.product.checkDC == '1' && sysdate < today }" >
						���� �����
					</c:if>
	
					<c:if test="${event.product.checkDC == '2' }">
						���� ��ҵ�
					</c:if>
					
					��ǰ �Դϴ�.
				</td>
				<td></td>
			</tr>
			
			<tr>
				<td colspan="17" bgcolor="D6D7D6" height="1"></td>
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