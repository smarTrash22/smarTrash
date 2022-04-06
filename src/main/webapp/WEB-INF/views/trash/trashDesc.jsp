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

div.share {
	position: absolute;
	width: 500px;
	height: 130px;
	left: 250px;
}

div.report {
	position: absolute;
	height: 130px;
	width: 500px;
	right: 25px;
}
/* .button1 {

  background-color: blue;
 width: 500px;
  border: none;

  color: white;

  padding: 15px 30px;

  text-align: center;

  text-decoration: none;

  display: inline-block;

  font-size: 16px;

  margin: 4px 2px;

  cursor: pointer;

} */
</style>
<script type="text/javascript">
	//클래스 이름 설정/변경
	function button1() {
		document.getElementById('share').className = 'collapsed show';
		document.getElementById('report').className = 'collapsed';
	}

	function button2() {
		document.getElementById('report').className = 'collapsed show';
		document.getElementById('share').className = 'collapsed';
	}
</script>
<c:import url="/WEB-INF/views/common/head.jsp" />
</head>
<body>
	<%-- 쓰레기 파일 : ${ trash_path }
	<br> 카테고리 : [${ category.category_no }, ${ category.category_name },
	${ category.category_content }, ${ category.category_tip }]
	<br> 카테고리 리스트
	<br> --%>
	<c:forEach items="${ requestScope.category_list }" var="cl">
[<%--  --%>${ cl.category_no }, ${ cl.category_name }, ${ cl.category_content }, ${ cl.category_tip }] <br>
	</c:forEach>
	<%-- 유저 : [${ sessionScope.loginUser.user_no }, ${ sessionScope.loginUser.user_email },
	${ sessionScope.loginUser.user_name }, ${ sessionScope.loginUser.user_admin },
	${ sessionScope.loginUser.user_date }] --%>

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
	<section class="bg-light py-4">
		<div class="container px-5">
			<div class="row mb-2">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-12">
							<div class="row">
								<div class="col-auto">
									<h1 class="d-inline-block my-3 text-md-center">${ category.category_name_kor }
										정보</h1>
								</div>
								<div class="col-auto">
									<button class="d-inline-block my-3 btn-sm text-md-end"
										onclick="location.href='category.do'">
										돌아가기</a>
								</div>
							</div>
						</div>
						<div
							class="col-md-12 d-flex align-items-center justify-content-center d-block d-lg-none">
							<div class="">
								<img style="width: 100%;"
									class="align-self-center rounded-circle"
									src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ trash_path }" /></a>
							</div>
						</div>
					</div>
					<div class="row">
						<div
							class="col-auto d-flex align-items-center justify-content-center d-none d-lg-block">
							<div class="align-items-center justify-content-center">
								<img style="width: 100%;" class=" rounded-circle"
									src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ trash_path }" /></a>
							</div>
						</div>
						<div class="col d-flex flex-column position-static">

							<h3 class="my-3">분리수거 방법</h3>
							<p class="mb-5 card-text mb-auto">${ category.category_content }</p>
							<h3 class="my-3">분리수거 팁</h3>
							<p class="card-text mb-auto">${ category.category_tip }</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
	<br>

	<!--  구분선 -->
	<hr>
	<br>

	<!--  하단 파트 -->

	<!--  공유 버튼 -->
	<div class="share">
		<button type="button" class="btn btn-lg btn-primary"
			onclick="button1();" style="height: 50px; width: 300px">
			<b>공유하기</b>
		</button>
		<br>
	</div>
	<!--  신고 버튼 -->
	<div class="report">
		<button type="button" class="btn btn-lg btn-danger"
			onclick="button2();" style="height: 50px; width: 300px">
			<b>신고하기</b>
		</button>
	</div>

	<!--  Share 버튼 눌렀을 시 -->
	<div class="collapse" id="comment">
		<div class="row justify-content-center">
			<div class="col-lg-6">
				<div class="card shadow-lg border-1 rounded-lg mt-3">
					<div class="card-header">
						<h4 class="text-center font-weight-light my-1">
							<b>Share to Gallary</b>
						</h4>
					</div>
					<div class="card-body">
						<form action="boardDetailView.do" method="POST">

							<!--  내용 부분 -->
							<div class="form-floating mb-3">
								<input class="form-control" id="inputComment" type="text"
									name="comment" placeholder="inputComment"
									items=${ board.board_content } /> <label for="inputComment">내용</label>
								<br>
							</div>

							<!--  태그 부분 -->
							<div class="form-floating mb-3">
								<input class="form-control" id="inputComment2" type="text"
									name="comment" placeholder="inputComment2"
									items=${ board.hashtag } /> <label for="inputComment">
									태그</label>
							</div>

							<!--  공유 내부 버튼 -->
							<div class="mt-2 mb-0">
								<div class="d-grid">
									<input class="btn btn-primary " type="submit" value="등록"><br>
									<input class="btn btn-secondary " type="reset" value="취소">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!--  Report 버튼 눌렀을 시 -->
	<div class="collapse" id="comment2">
		<div class="row justify-content-center">
			<div class="col-sm-3">
				<div class="card shadow-lg border-1 rounded-lg mt-3">
					<div class="card-header">
						<h5 class="text-center font-weight-light my-1">
							<b>정답 카테고리 선택</b>
						</h5>
					</div>
					<div class="card-body">
						<form action="categorySelect.do" method="POST">
							<div class="form-floating mb-3"></div>
							<center>
								<select><option>캔</option>
									<option>형광등</option>
									<option>유리</option>
									<option>종이</option>
									<option>플라스틱</option>
									<option>스티로폼</option>
									<option>비닐</option>
								</select>
							</center>
							<div class="mt-2 mb-0">
								<div class="d-grid">
									<input class="btn btn-danger " type="submit" value="확인"><br>
									<input class="btn btn-secondary " type="reset" value="취소">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer-->
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>