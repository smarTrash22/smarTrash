<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
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
		</style>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
		<script type="text/javascript">
			$(function() {
				$("#button1").click(function(){
					document.getElementById('content1').style.display = "block";
					document.getElementById('content2').style.display = "none";
					console.log("1");
				});
				
				$("#button2").click(function(){
					document.getElementById('content1').style.display = "none";
					document.getElementById('content2').style.display = "block";
					console.log("2");
				});
			});
		</script>
	</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Pricing section-->
			<section class="bg-light py-3">
				<div class="container px-5">
					<div class="row mb-2">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<div class="row">
										<div class="col text-md-center">
											<h1 class="d-inline-block my-3 text-md-center">사진 AI분류 정보 : ${ category.category_name_kor }</h1>
										</div>
									</div>
								</div>
								<div
									class="col-md-12 d-flex align-items-center justify-content-center d-block d-lg-none">
									<div class="row-cols-md-3">
										<img style="width: 100%;"
											class="align-self-center rounded-circle"
											src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ trash_path }" /></a>
									</div>
								</div>
							</div>
							<div class="row">
								<div
									class="col-4 d-flex align-items-center justify-content-center d-none d-lg-block">
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
							<c:if test="${ !empty sessionScope.loginUser }">
								<div class="row mt-5">
									<div id="content" class="show">
										<div id="content1" class="hide" style="display: none;">
											<div class="text-center">
												<form action="binsert.do" method="POST">
													<div class="form-floating mb-1">
														<input class="form-control" id="board_content" type="text" name="board_content" items=${ board.board_content } />
														<label for="board_content">내용</label>
													</div>
													<div class="form-floating mb-3">
														<input class="form-control" id="hashtag" type="text" name="hashtag" value="#${ category.category_name_kor }, #${ sessionScope.loginUser.user_email }, " />
														<label for="hashtag">태그</label>
													</div>
													<div class="mb-5">
														<div class="">
															<input type="hidden" name="trash_path" value="${ trash_path }" />
															<input class="btn btn-primary " type="submit" value="등록">
															<input class="btn btn-secondary " type="reset" value="취소">
														</div>
													</div>
												</form>
											</div>
										</div>
										<div id="content2" class="hide" style="display: none;">
											<div class="text-center mb-5">
												<form action="trashReport.do" method="post">
													<input type="hidden" name="trash_path" value="${ trash_path }" />
													<input type="submit" name="submit" class="btn btn-lg btn-danger" value="신고하기 확인" />
												</form>
											</div>
										</div>
									</div>
									<div class="col d-flex flex-column position-static text-md-end">
										<div>
											<button id="button1" type="button" class="btn btn-lg btn-primary" style="height: 50px; width: 300px">
												<b>검사 갤러리에 공유하기</b>
											</button>
										</div>
										<br>
									</div>
									<div class="col d-flex flex-column position-static text-md-start">
										<div>
											<button id="button2" type="button" class="btn btn-lg btn-danger" style="height: 50px; width: 300px">
												<b>잘못된 분류로 신고하기</b>
											</button>
										</div>
							        </div>
								</div>
							</c:if>
							<c:if test="${ empty sessionScope.loginUser }">
								<div class="row mt-5">
									<div class="col d-flex flex-column position-static text-md-start">
										<div class="text-md-center">
											<button id="button2" type="button" class="btn btn-secondary btn-lg" onclick="location.href='main.do'" style="height: 50px; width: 300px">
												<b>메인으로</b>
											</button>
										</div>
							        </div>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>
