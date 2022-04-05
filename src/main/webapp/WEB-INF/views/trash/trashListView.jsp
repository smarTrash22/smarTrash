<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${	 requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage}" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/common/head.jsp" />
<meta charset="UTF-8">
<title></title>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		showDiv();

		$("input[name=item]").on("change", function() {
			showDiv();
		});
	});

	function showDiv() {
		if ($("input[name=item]").eq(0).is(":checked")) {
			$("#user_no_Div").css("display", "block");
			$("#category_no_Div").css("display", "none");
			$("#trash_date_Div").css("display", "none");
			$("#report_Div").css("display", "none");
		}

		if ($("input[name=item]").eq(1).is(":checked")) {
			$("#user_no_Div").css("display", "none");
			$("#category_no_Div").css("display", "block");
			$("#trash_date_Div").css("display", "none");
			$("#report_Div").css("display", "none");
		}

		if ($("input[name=item]").eq(2).is(":checked")) {
			$("#user_no_Div").css("display", "none");
			$("#category_no_Div").css("display", "none");
			$("#trash_date_Div").css("display", "block");
			$("#report_Div").css("display", "none");
		}

		if ($("input[name=item]").eq(3).is(":checked")) {
			$("#user_no_Div").css("display", "none");
			$("#category_no_Div").css("display", "none");
			$("#trash_date_Div").css("display", "none");
			$("#report_Div").css("display", "block");
		}
	}
</script>
</head>
</head>
<c:import url="/WEB-INF/views/common/navi.jsp" />

<body>
	<hr>
	<h3 align="center">
		<b>쓰레기 목록 : 총 ${ list.size() }개</b>
	</h3>
	<br>
	<div align="center">
		<h5>
			<b>검색 항목 선택</b>
		</h5>
		<input type="radio" name="item" value="user_no" checked>유저번호&nbsp;
		&nbsp; <input type="radio" name="item" value="category_no">카테고리번호
		&nbsp; &nbsp; <input type="radio" name="item" value="trash_date">날짜&nbsp;
		&nbsp; <input type="radio" name="item" value="trash_date">신고여부
	</div>

	<div align="center" id="user_no_Div">
		<form action="searchUserNo.do" method="post">
			<label>유저 번호 입력 : <input type="search" name="keyword"></label>
			<input type="submit" value="검색">
		</form>
	</div>

	<div align="center" id="category_no_Div">
		<form action="searchCategoryNo.do" method="post">
			<label>카테고리 번호 입력 : <input type="search" name="keyword"></label>
			<input type="submit" value="검색">
		</form>
	</div>

	<div align="center" id="trash_date_Div">
		<form action="searchDate.do" method="post">
			<label>날짜 입력 : <input type="date" name="begin"> ~ <input
				type="date" name="end"></label> <input type="submit" value="검색">
		</form>
	</div>

	<div align="center" id="report_Div">
		<form action="searchReport.do" method="post">
			<label>신고 여부 : Y <input type="radio" name="keyword" value="Y">
				N <input type="radio" name="keyword" value="N"></label> <input
				type="submit" value="검색">
		</form>
	</div>
	<br>
	<br>
	<div class="button" align="center">
		<input type="button" value="목록" align="center"
			onclick="javascript:location.href='tlist.do';" />&nbsp;&nbsp;
		<div class="button" name="insertbutton" style="display: inline-block">
			<input type="button" value="쓰레기 추가"
				onclick="javascript:location.href='moveInsertPage.do';" />
		</div>
	</div>
	<br>

	<table align="center" border="1" width="900" cellspacing="0">
		<tr>
			<th>번호</th>
			<th>유저 번호</th>
			<th>카테고리 번호</th>
			<th>파일</th>
			<th>업로드 날짜</th>
			<th>신고여부</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="t">
			<tr>
				<td>${ t.trash_no }</td>
				<td>${ t.user_no }</td>
				<td>${ t.category_no }</td>
				<td>${ t.trash_path }</td>
				<td>${ t.trash_date }</td>
				<td>${ t.report }</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<!--  페이징 처리 -->
	<div style="text-align: center;">
		<!--  1페이지로 이동 처리 -->
		<c:if test="${ currentPage  eq 1 }">
		처음 &nbsp;
	</c:if>
		<!--  gt = greater than -->
		<c:if test="${ currentPage gt 1 }">
			<c:url var="tlf" value="/tlist.do">
				<c:param name="page" value="1" />
			</c:url>
			<a href="${ tlf }">처음</a>
		</c:if>
		<!--  이전 페이지 그룹으로 이동 처리 -->
		<!--  이전그룹이 있다면~ -->
		<c:if
			test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
			<c:url var="tlf2" value="/tlist.do">
				<c:param name="page" value="${ startPage - 10 }" />
			</c:url>
			<a href="${ tlf2 }"> 이전 &nbsp;</a>

		</c:if>
		<!--  이전그룹이 없다면~ -->
		<c:if
			test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
			 이전 &nbsp;
		</c:if>
		<!--  현재 페이지가 속한 페이지 그룹 출력 -->
		<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
			<c:if test="${ p eq currentPage }">
				<font size="4" color="red"><b>[${ p }]</b></font>
			</c:if>
			<c:if test="${ p ne currentPage }">
				<c:url var="tlf5" value="/tlist.do">
					<c:param name="page" value="${ p }" />
				</c:url>
				<a href="${ tlf5 }">${ p }</a>
			</c:if>
		</c:forEach>
		<!--  다음 페이지 그룹으로 이동 처리 -->
		<!--  다음그룹이 있다면~ -->
		<c:if
			test="${ (currentPage + 10) > startPage and (currentPage + 10) < maxPage }">
			<c:url var="tlf3" value="/tlist.do">
				<c:param name="page" value="${ endPage + 10 }" />
			</c:url>
			<a href="${ tlf3 }"> 다음 &nbsp;</a>

		</c:if>
		<!--  다음그룹이 없다면~ -->
		<c:if
			test="${ !((currentPage + 10) > startPage and (currentPage + 10) < maxPage) }">
			   다음 &nbsp;
		</c:if>


		<!--  끝 페이지로 이동 처리 -->
		<c:if test="${ currentPage  eq maxPage }">
		끝 &nbsp;
	</c:if>
		<!--  gt = greater than -->
		<c:if test="${ currentPage < maxPage }">
			<c:url var="tlf4" value="/tlist.do">
				<c:param name="page" value="${ maxPage }" />
			</c:url>
			<a href="${ tlf4 }">끝</a>
		</c:if>


		<hr>
		<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>