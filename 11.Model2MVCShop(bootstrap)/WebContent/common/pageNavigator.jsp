<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
		<span name="before">
			◀ 이전
		</span>
	</c:if>
	
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<span name="page">
			<input type="hidden" id="curr" name="curr" value="${i }"/>
			${ i }
		</span>
	</c:forEach>
	
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<span name="after">
			이후 ▶
		</span>
	</c:if>