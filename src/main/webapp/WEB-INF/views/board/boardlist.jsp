<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />
<!-- Page Title -->


<!DOCTYPE html>
<html>
<head>
<title>SmarTrash - ${ page_title }</title>
<c:import url="/WEB-INF/views/common/head.jsp" />
<style>
div table {
	border: 1px solid #444444;
	border-collapse: collapse;
}

div td {
	border: 0px solid #444444;
	padding: 7px;
}

div.photo {
	height: 180px;
	width: 180px;
	background-color: lightgray;
	color: white;
}

input[type=text] {
	padding: 5px;
	position: relative;
	top: 3px;
}

#title {
	font-size: 50px;
	opacity: 0.5;
}

.search input {
	width: 400px;
	height: 30px;
	border: 2px solid rgb(209, 207, 207);
	border-radius: 15px;
}

input::placeholder {
	text-align: center;
	font-size: 14px;
	opacity: 0.7;
}

#btn1 {
	width: 70px;
	padding: 2px;
	border-radius: 20px;
}

#pg {
	width: 240px;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body class="d-flex flex-column">
	<main class="flex-shrink-0">
		<!-- Navigation-->
		<c:import url="/WEB-INF/views/common/navi.jsp" />
		<div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-8">
				<div class="text-center my-5">
					<h1 id="title" class="fw-bolder mb-3">Gallery</h1>
				</div>
			</div>
		</div>
		<div align="center">
			<form action="해쉬태그검색용.do" method="post">
				<div class="search">
					<input type="text" size="30" placeholder="search hashtag..."
						onfocus="this.placeholder=''"
						onblur="this.placeholder='search hashtag...'" name="hashtag">
					<button id="btn1" class="btn btn-primary" btn type="submit">search</button>
				</div>

			</form>
		</div>
		<br>
		<div>
			<table align="center" border="1" cellspacing="0" cellpadding="1">
				<tr align="center">
					<td>board_no</td>
					<td>trash_no</td>
				</tr>
				<c:forEach items="${ requestScope.list }" var="b">
					<tr align="center">
						<td>${ b.board_no }</td>
						<td>${ b.trash_no }</td>
					</tr>
				</c:forEach>


			</table>
		</div>
		<br>
		<div id="pg">
			<ul class="pagination">
			<!-- 1페이지로 이동처리 -->
			<c:if test="${ currentPage eq 1 }">
				<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
			</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:url var="blf" value="/boardlist.do">
					<c:param name="page" value="1" />
				</c:url>
				<li class="page-item"><a class="page-link" href="${ blf }">&laquo;</a></li>
			</c:if>
			<!--  이전페이지 그룹으로 이동처리  -->
			<c:if
				test="${ (currentPage -10) < startPage and (currentPage - 10) > 1 }">
				<c:url var="blf2" value="/boardlist.do">
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
				<li class="page-item"><a class="page-link" href="${ blf2 }">@</a></li>
			</c:if>
			<c:if
				test="${ !((currentPage -10) < startPage and (currentPage - 10) > 1) }">
				<li class="page-item disabled"><a class="page-link" href="${ blf2 }">@</a></li>
			</c:if>
			<li class="page-item active"><a class="page-link" href="#">1</a></li>
			</ul>
			</div>
		<div style="text-align: center;">
			<!-- 1페이지로 이동처리 -->
			<!--  이전페이지 그룹으로 이동처리  -->
			<c:if
				test="${ (currentPage -10) < startPage and (currentPage - 10) > 1 }">
				<c:url var="blf2" value="/boardlist.do">
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
				<a href="${ blf2 }">[이전그룹]</a>
			</c:if>
		
			<!-- 현재 페이지가 속한 페이지 그룹 출력 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" color="red">[${ p }]</font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:url var="blf5" value="/boardlist.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ blf5 }">${ p }</a>
				</c:if>
			</c:forEach>
			<!--  다음페이지 그룹으로 이동처리  -->
			<c:if
				test="${ (currentPage +10) > endPage and (currentPage + 10) < maxPage }">
				<c:url var="blf3" value="/boardlist.do">
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
				<a href="${ blf3 }">[이전그룹]</a>
			</c:if>
			<c:if
				test="${ !((currentPage +10) > endPage and (currentPage + 10) < maxPage) }">
	[다음그룹] &nbsp;
</c:if>
			<!-- 끝페이지로 이동처리 -->
			<c:if test="${ currentPage eq maxPage }">
	[맨끝] &nbsp;
</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="blf4" value="/boardlist.do">
					<c:param name="page" value="${ maxPage }" />
				</c:url>
				<a href="${ blf4 }">[맨끝]</a>
			</c:if>
		</div>
		<div id="pg">
			<ul class="pagination">
				<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
				<li class="page-item active"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">4</a></li>
				<li class="page-item"><a class="page-link" href="#">5</a></li>
				<li class="page-item"><a class="page-link" href="#">&raquo;</a>
				</li>
			</ul>
		</div>
	</main>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>