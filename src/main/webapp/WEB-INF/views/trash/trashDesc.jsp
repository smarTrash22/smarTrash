<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<style>
img#photo {
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>
<c:import url="/WEB-INF/views/common/head.jsp" />
</head>
<body>
	<!-- Navigation-->
	<c:import url="/WEB-INF/views/common/navi.jsp" />

	<!-- Headline -->
	<div class="row justify-content-center">
		<div class="col-lg-8 col-xxl-8">
			<div class="text-center my-5">
				<h1 id="title" class="fw-bolder mb-3" style="font-size: 30pt;">
					<i>업로드파일 분류정보</i>
				</h1>
			</div>
		</div>
	</div>








	<!-- 상단게시물 영역 -->
	<div>
		<table align="center" cellspacing="0" style="word-break: break-all">
			<tr>
				<c:forEach items="${ requestScope.list }" var="t">
					<td>
						<div id="photo">
							<img
								src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }" />
						</div>
					</td>
					<td><b>&nbsp; 버리는 방법 : ${ category.category_content }</b>&nbsp;&nbsp;&nbsp;</td>
					<td><b>Tip : ${ category.category_tip }</b></td>
				</c:forEach>
			</tr>
		</table>
	</div>



	<br>
	<br>

	<!--  구분선 -->
	<hr>

	<!--  중간 파트 -->
	<div>
		<h3 align="center">대표적인 쓰레기?</h3>
		<c:forEach items="${ requestScope.list }" var="t">
		<div id="photo">
			<img
				src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }" />
		</div>
		<div id="photo">
			<img
				src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }" />
		</div>
		<div id="photo">
			<img
				src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }" />
		</div>
		</c:forEach>
	</div>
	<div id="photo"></div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<!--  구분선 -->
	<hr>
	<br>

	<!--  하단 파트 -->
	<!--  버튼 -->
	<div align="center">
		<button type="button" class="btn btn-lg btn-primary"
			onclick="showPopup();">Share</button>
		&nbsp; &nbsp;
		<button type="button" class="btn btn-lg btn-danger">Report</button>
	</div>
	<br>
	<br>
	<br>

	<!-- Footer-->
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>
