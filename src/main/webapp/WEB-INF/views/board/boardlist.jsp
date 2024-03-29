<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="list" value="${ requestScope.list }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />
<c:set var="hashtag" value="${ requestScope.hashtag }"/>
<!-- Page Title -->

<c:set var="page_title" value="검사 갤러리" />

<!DOCTYPE html>
<html>
<head>
<title>SmarTrash - ${ page_title }</title>
<c:import url="/WEB-INF/views/common/head.jsp" />
<style>
div table {
	border: 0px solid #444444;
	border-collapse: collapse;
}

div td {
	border: 0px solid #444444;
	padding: 7px;
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

.pagination {
	width: 200px;
	margin: 0px auto;
}

div.photobox {
	height: 300px;
	width: 250px;
	overflow:hidden;
	margin: 0 auto;
}
img.photo{
	width:100%;
	height:100%;
	object-fit:cover;
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
		</form>
			<form action="searchHash.do" method="get">
				<div class="search">
					<input type="text" size="30" placeholder="search hashtag..."
						onfocus="this.placeholder=''"
						onblur="this.placeholder='search hashtag...'" name="hashtag"/>
					<button id="btn1" class="btn btn-primary" type="submit">search</button>
				</div>
			</form>
		</div>
		<br>
		<c:if test="${ empty list }">
		<br>
		<div align="center" style="color:red"><h5>-검색결과가 없습니다-</h1></div>
		</c:if>
		<c:if test="${ !empty list }">
		<div>
			<table align="center" border="1" cellspacing="0" cellpadding="1">
				<tr align="center">
				<c:forEach items="${ requestScope.list }" var="b"  varStatus="status">
					<c:url var="bdt" value="bdetail.do">
					<c:param name="board_no" value="${ b.board_no }" />
					<c:param name="page" value="${ currentPage }" />
					</c:url>
					<td><a href="${ bdt }">
							<div class="photobox">
								<img class="photo" src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${b.trash_path}" />
							</div>
						</a>
					</td>
					<c:if test="${ status.count eq 3 or status.count eq 6 }">
						</tr>
						<tr align="center">
					</c:if>
				</c:forEach>
				</tr>
			</table>
		</div>
		
		<c:if test="${ empty hashtag }">
		<br>
		<div id="pg">
			<ul class="pagination">
				<!-- 1페이지로 이동처리 -->
				<c:if test="${ currentPage eq 1 }">
					<li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
				<c:if test="${ currentPage > 1 }">
					<c:url var="blf" value="/boardlist.do">
						<c:param name="page" value="1" />
					</c:url>
					<li class="page-item"><a class="page-link" href="${ blf }"><i class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
				<!--  이전페이지 그룹으로 이동처리  -->
				<c:if
					test="${ (currentPage -10) < startPage and (currentPage - 10) > 1 }">
					<c:url var="blf2" value="/boardlist.do">
						<c:param name="page" value="${ startPage - 10 }" />
					</c:url>
					<li class="page-item"><a class="page-link" href="${ blf2 }"><i class="bi bi-chevron-left"></i></a></li>
				</c:if>
				<c:if
					test="${ !((currentPage -10) < startPage and (currentPage - 10) > 1) }">
					<li class="page-item disabled"><a class="page-link"
						href="${ blf2 }"><i class="bi bi-chevron-left"></i></a></li>
				</c:if>
				<!-- 현재 페이지가 속한 페이지 그룹 출력 -->
				<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
					step="1">
					<c:if test="${ p eq currentPage }">
						<li class="page-item active"><a class="page-link" href="#">${ p }</a></li>
					</c:if>
					<c:if test="${ p ne currentPage }">
						<c:url var="blf5" value="/boardlist.do">
							<c:param name="page" value="${ p }" />
						</c:url>
						<li class="page-item"><a class="page-link" href="${ blf5 }">${ p }</a></li>
					</c:if>
				</c:forEach>
				<!--  다음페이지 그룹으로 이동처리  -->
				<c:if
					test="${ (currentPage +10) > endPage and (currentPage + 10) < maxPage }">
					<c:url var="blf3" value="/boardlist.do">
						<c:param name="page" value="${ endPage + 10 }" />
					</c:url>
					<li class="page-item"><a class="page-link" href="${ blf3 }"><i class="bi bi-chevron-right"></i></a></li>
				</c:if>
				<c:if
					test="${ !((currentPage +10) > endPage and (currentPage + 10) < maxPage) }">
					<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-right"></i></a></li>
				</c:if>
				<c:if test="${ currentPage eq maxPage }">
					<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-double-right"></i></a>
				</c:if>
				<!-- 끝페이지로 이동처리 -->
				<c:if test="${ currentPage < maxPage }">
					<c:url var="blf4" value="/boardlist.do">
						<c:param name="page" value="${ maxPage }" />
					</c:url>
					<li class="page-item"><a class="page-link" href="${ blf4 }"><i class="bi bi-chevron-double-right"></i></a>
				</c:if>
			</ul>
		</div>
		</c:if>
		<!-- 검색한 페이지의 경우-------------------------------------------------------- -->
		<c:if test="${ !empty hashtag }">
		<br>
		<div id="pg">
			<ul class="pagination">
				<!-- 1페이지로 이동처리 -->
				<c:if test="${ currentPage eq 1 }">
					<li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
				<c:if test="${ currentPage > 1 }">
					<c:url var="hblf" value="searchHash.do">
						<c:param name="page" value="1" />
						<c:param name="hashtag" value="${ hashtag }"/>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ hblf }"><i class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
				<!--  이전페이지 그룹으로 이동처리  -->
				<c:if
					test="${ (currentPage -10) < startPage and (currentPage - 10) > 1 }">
					<c:url var="hblf2" value="searchHash.do">
						<c:param name="page" value="${ startPage - 10 }" />
						<c:param name="hashtag" value="${ hashtag }"/>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ hblf2 }"><i class="bi bi-chevron-left"></i></a></li>
				</c:if>
				<c:if
					test="${ !((currentPage -10) < startPage and (currentPage - 10) > 1) }">
					<li class="page-item disabled"><a class="page-link"
						href="${ hblf2 }"><i class="bi bi-chevron-left"></i></a></li>
				</c:if>
				<!-- 현재 페이지가 속한 페이지 그룹 출력 -->
				<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
					step="1">
					<c:if test="${ p eq currentPage }">
						<li class="page-item active"><a class="page-link" href="#">${ p }</a></li>
					</c:if>
					<c:if test="${ p ne currentPage }">
						<c:url var="hblf5" value="searchHash.do">
							<c:param name="page" value="${ p }" />
							<c:param name="hashtag" value="${ hashtag }"/>
						</c:url>
						<li class="page-item"><a class="page-link" href="${ hblf5 }">${ p }</a></li>
					</c:if>
				</c:forEach>
				<!--  다음페이지 그룹으로 이동처리  -->
				<c:if
					test="${ (currentPage +10) > endPage and (currentPage + 10) < maxPage }">
					<c:url var="hblf3" value="searchHash.do">
						<c:param name="page" value="${ endPage + 10 }" />
						<c:param name="hashtag" value="${ hashtag }"/>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ hblf3 }"><i class="bi bi-chevron-right"></i></a></li>
				</c:if>
				<c:if
					test="${ !((currentPage +10) > endPage and (currentPage + 10) < maxPage) }">
					<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-right"></i></a></li>
				</c:if>
				<c:if test="${ currentPage eq maxPage }">
					<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-double-right"></i></a>
				</c:if>
				<!-- 끝페이지로 이동처리 -->
				<c:if test="${ currentPage < maxPage }">
					<c:url var="hblf4" value="searchHash.do">
						<c:param name="page" value="${ maxPage }" />
						<c:param name="hashtag" value="${ hashtag }"/>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ hblf4 }"><i class="bi bi-chevron-double-right"></i></a>
				</c:if>
			</ul>
		</div>
		</c:if>
		</c:if>
		<br>
	</main>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>