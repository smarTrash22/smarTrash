<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="listCount" value="${ listCount }" />
<c:set var="startPage" value="${ startPage }" />
<c:set var="endPage" value="${ endPage }" />
<c:set var="maxPage" value="${ maxPage }" />
<c:set var="currentPage" value="${ currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SmarTrash - ${ page_title }</title>
<script type="text/javascript">
/* function showWriteForm(){
	location.href = "${ pageContext.servletContext.contextPath }/nwform.do";
} */
</script>
<c:import url="/WEB-INF/views/common/head.jsp" />
<style type="text/css">
	ul {
	  text-align: center;
	}
	a { 
		text-align: center; text-decoration: none; color: inherit;
	}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/navi.jsp" />
<br>
<h2 align="center">공지사항</h2>
<c:if test="${ !empty sessionScope.loginMember }">
	<div>
		<button onclick="showWriteForm();">글쓰기</button>
	</div>
</c:if>
<div style="padding-left: 10%; padding-right: 10%; padding-bottom: 10px;">
<table class="table table-striped table-hover">
    <thead>
      <tr>
        <th scope="col">번호</th>
        <th scope="col" colspan="3">제목</th>
        <th scope="col"></th>
        <th scope="col"></th>
        <th scope="col">작성자</th>
        <th scope="col">첨부파일</th>
        <th scope="col">작성일</th>
      </tr>
    </thead>
<tbody>
	<c:forEach items="${ requestScope.list }" var="n">
	<tr align="center">
		<td align="left">${ n.notice_no }</td>
			<c:url var="ndt" value="/ndetail.do">
				<c:param name="notice_no" value="${ n.notice_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
		<td colspan="3" align="left"><a href="${ ndt }">${ n.notice_title }</a></td>
		<td align="left"></td>
		<td align="left"></td>
		<td align="left">${ n.notice_writer }</td>
		<td align="left">
			<c:if test="${ !empty n.notice_original_filename }">O</c:if>
			<c:if test="${ empty n.notice_original_filename }">&nbsp;</c:if>
		</td>
		<td align="left"><fmt:formatDate value="${ n.notice_date}" type="date" pattern="yyyy-MM-dd" /></td>
		<td align="left">${ n.notice_readcount }</td>
	</tr>
</c:forEach>
</tbody>
</table>
<!-- 페이징 -->
</div>
<div class="d-flex justify-content-center" >
	<nav aria-label="Page navigation example">
	  <ul class="pagination">
<!-- 맨처음 페이지 -->
	  <c:if test="${ currentPage eq 1 }">
		<li class="page-item">맨처음</li>
	  </c:if>
	  <c:if test="${ currentPage > 1 }">
	  	<c:url var="nlf" value="/nlist.do">
	  		<c:param name="page" value="1"></c:param>
	  	</c:url>
		<li class="page-item"><a class="page-link" href="${ nlf }">맨처음</a></li>
	  </c:if>
<!-- 맨끝 페이지 -->
	  <c:if test="${ currentPage eq maxPage }">
		<li class="page-item">맨끝</li>
	  </c:if>
	  <c:if test="${ currentPage < maxPage }">
	  	<c:url var="nlf2" value="/nlist.do">
	  		<c:param name="page" value="${ maxPage }"></c:param>
	  	</c:url>
		<li class="page-item"><a class="page-link" href="${ nlf2 }">맨끝</a></li>
	  </c:if>
<!-- 이전 페이지 -->
	  <c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
	  	<li class="page-item">이전</li>
	  </c:if>
	  <c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
	  	<c:url var="nlf3" value="/nlist.do">
	  		<c:param name="page" value="${ startPage - 10 }" />
	  	</c:url>
		<li class="page-item"><a class="page-link" href="${ nlf3 }">이전</a></li>
	  </c:if>
<!-- 다음 페이지 -->
	  <c:if test="${ !((currentPage + 10) > endPage and (currentPage - 10) < maxPage) }">
	  	<li class="page-item">다음</li>
	  </c:if>
	  <c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
	  	<c:url var="nlf4" value="/nlist.do">
	  		<c:param name="page" value="${ endPage + 10 }" />
	  	</c:url>
		<li class="page-item"><a class="page-link" href="${ nlf4 }">다음</a></li>
	  </c:if>
<!-- 현재 페이지가 속한 페이지그룹 출력 -->
<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
	<c:if test="${ p eq currentPage }">
		<li class="page-item">${ p }</li>
	</c:if>
	<c:if test="${ p ne currentPage }">
	<c:url var="nlf5" value="/nlist.do">
		<c:param name="page" value="${ p }"/>
	</c:url>
	<li class="page-item"><a class="page-link" href="${ nlf5 }">${ p }</a></li>
	</c:if>
</c:forEach>	  
	  </ul>
	</nav>
</div>
<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>
