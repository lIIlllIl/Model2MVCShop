<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<title>��ǰ �����ȸ-Manage</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">



function fncGetList(currentPage){

	var condition = $("select[name='searchCondition']").val();

	if ( condition == '4' && document.detailForm.searchKeyword.value != ""  ) {
//		var price = document.detailForm.searchKeyword.value;
		var price = $("input[name='searchKeyword']").val();
		var co = price.indexOf('~');
		var ch = price.charAt(co + 1);
		var pront = price.substring(0, co);
		var back = price.substring(co + 1);
		
		if ( price.indexOf('~') == -1 ) {
			alert('~ ��ȣ�� �߰��ؼ� �˻����ּ���.');
//			document.getElementById("searchKeyword").focus();
			$( ".input[name='searchKeyword']").focus();
			event.preventDefault();
		} 
		else if ( price.indexOf('~') < 1 || (price.match(/~/g) || []).length != 1 || ch == null || ch == "undefined" || ch == "" ) {
			alert('��Ȯ�� ������ �Է����ּ���.');
//			document.getElementById("searchKeyword").focus();
			$( "input[name='searchKeyword']").focus();
			event.preventDefault();
		}
		else if ( isNaN(pront) || isNaN(back) ) {
			alert('���ڸ� �Է����ּ���.');
//			document.getElementById("searchKeyword").focus();
			$( "input[name='searchKeyword']").focus();
			event.preventDefault();
		}
		
		else {
//			document.getElementById("currentPage").value = currentPage;
//		   	document.detailForm.submit();
			alert(currentPage)
			$( "input[name='currentPage']" ).val(currentPage);
			$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();
		}
	}
	else if ( condition == '2' || condition == '3'  ) {
//		var price = document.detailForm.searchKeyword.value;
		var price = $("input[name='searchKeyword']").val();
		
		if ( isNaN(price) ) {
			alert('���ڸ� �Է����ּ���.');
//			document.getElementById("searchKeyword").focus();
			$("input[name='searchKeyword']").focus();
			event.preventDefault();	
		}
		else {
			$( "input[name='currentPage']" ).val(currentPage)
			$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();
		}
	}
	else if ( condition == '0' ) {
//		var prodNo = document.detailForm.searchKeyword.value;
		var prodNo = $("input[name='searchKeyword']").val();
		
		if ( isNaN(prodNo) ) {
			alert('���ڸ� �Է����ּ���.');
//			document.getElementById("searchKeyword").focus();
			$("input[name='searchKeyword']").focus();
			event.preventDefault();	
		}
		else {
			$( "input[name='currentPage']" ).val(currentPage);
			$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();
		}
	}
	else {
		$( "input[name='currentPage']" ).val(currentPage);
		$('form').attr("method", "post").attr("action", "/product/listProduct?menu=${param.menu}" ).submit();	
	}
}

function fndAlertCheck() {
	alert('��ǰ������ ������ �� ���� �����Դϴ�.');
}

$(function() {
	
	$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
	
	$("input[name='searchKeyword']").on("keydown", function(key){
		if ( key.keyCode == 13 ) {
			fncGetList(1);
		}
	});
	
	$(".ct_btn01:contains('�˻�')").on("click", function() {
		fncGetList(1);
	})
	
	$(".ct_list_pop td:nth-child(3)").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${param.menu}";
	})
	
	$("select[name='searchPrice']").on("change", function(){
		fncGetList(1);
	});
	
	$(".ct_list_pop td:contains('��������')").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=discount";
	})
	
	$(".ct_list_pop td:contains('���ο���')").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=discount";
	})
	
	$(".ct_list_pop td:contains('������')").on("click", function() {
		var prodNo = $(this).children("input[name='prodNo']").val();
		
		self.location = "/product/getProduct?prodNo="+prodNo+"&menu=discount";
	})
	
	$("h7").css("color", "red").css({"font-size":"13px"});
	
	$("span[name='page']").on("click", function() {
		var currentPage = $(this).text().trim();
		
		fncGetList(currentPage);
	})
	
	$( "span" ).on("mouseenter", function() {
	 	$(this).stop().animate({ }, 1000 ).css("font-weight", "bold")
	 })
	 	
	$( "span" ).on("mouseleave", function() {
	 	$(this).stop().animate({ }, 1000 ).css("font-weight", "normal")
	})
	
	$("span[name='before']").on("click", function() {
		var currentPage = ${ resultPage.beginUnitPage - 1};
		
		fncGetList(currentPage);
	})
	
	$("span[name='after']").on("click", function() {
		var currentPage = ${resultPage.endUnitPage + 1};
		
		fncGetList(currentPage);
	})

	
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" >

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
				<select name="searchPrice" id="searchPrice" class="ct_input_g" style="width:100px" >
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
							style="width:200px; height:20px" />		
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
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
		<td colspan="25" >��ü ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage } ������</td>
	</tr>
	
	<tr>
		<td class="ct_list_b" width="50">No</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="130">
		��ǰ��
		<br>
		<h7>click �� ��ǰ �󼼺���</h7>
		</td>
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
		
		<td class="ct_list_b" width="100">���ο���</td>
		<td class="ct_line02"></td>
		
		<td class="ct_list_b" width="100" >�̺�Ʈ �Ⱓ</td>	
		<td class="ct_line02"></td>
		
	</tr>
	
	<tr>
		<td colspan="25" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
		<c:forEach var="event" items="${list }" >
			<c:set var="i" value="${i + 1 }" />
			
			<tr class="ct_list_pop">
			
				<td align="center">${event.product.prodNo } </td>
				<td></td>
				
				<td align="left">
					<input type="hidden" id="prodNo" name="prodNo" value="${event.product.prodNo }"/>
					${event.product.prodName }
				</td>
				<td></td>
				
				<td align="left">
					<fmt:formatNumber value="${event.product.price }" type="currency" />
				</td>
				<td></td>
				
				<td align="left">${event.product.regDate }</td>
				<td></td>
				
				<td align="left">
					<fmt:parseDate var="dateString" value="${event.product.manuDate }" pattern="yyyyMMdd" />
					<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
				</td>
				
				<td align="left">
					<c:if test="${ empty event.product.fileName  }">
							<td>��������</td> 
					</c:if>
					<c:if test="${ ! empty event.product.fileName  }">
						<c:set var="images" value="${fn:split(event.product.fileName , '/') }" />
							<td align="left">
								<c:forEach var="image" items="${images }" >
									<img src="../images/uploadFiles/${image}" width="100" height="100" />
								</c:forEach>
							</td>
					</c:if>
				</td>
				<td></td>
				
				<td align="left">
					<c:choose>
						<c:when test="${event.product.prodCount == 0 }" >
							������
						</c:when>
						<c:otherwise>
							�Ǹ��� ��� : ${event.product.prodCount } ��
						</c:otherwise>
					</c:choose>
					
				</td>
				
				<td></td>
				
				<td align="left">
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
					<fmt:parseDate  value="${event.startDate}" pattern="yyyy-MM-dd" var="startDate" />	
					<fmt:parseDate  value="${event.endDate}" pattern="yyyy-MM-dd" var="endDate" />	
					
					<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" var="start"/>
					<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" var="end"/>
					<input type="hidden" id="prodNo" name="prodNo" value="${event.product.prodNo }"/>
					
						<c:if test="${event.product.checkDC == 0 }" >
							���ξ���&nbsp;&nbsp;&nbsp;
							��������
						</c:if>
						<c:if test="${event.product.checkDC == 1 }" >	
							<c:if test="${ start > today }" >
								���ο���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
								�������
							</c:if>
							
							<c:if test="${ start <= today }" >
								������&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
								�������
							</c:if>	
						</c:if>
					
				</td>
				
				<td></td>
				
				<td align="left">
					<c:if test="${ !empty start }" >
						${start } ~ ${end }
					</c:if>
				</td>
			</tr>

			<tr>
				<td colspan="25" bgcolor="D6D7D6" height="1"></td>
			</tr>
			
			</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center" id="Page">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <jsp:include page="../common/pageNavigator.jsp"/>	
    	</td>
	</tr>
</table>
</form>
</div>

</body>
</html>