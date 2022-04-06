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
				document.getElementById('comment').className = 'collapse show';
				document.getElementById('comment2').className = 'collapse';
			}
		
			function button2() {
				document.getElementById('comment').className = 'collapse show';
				document.getElementById('comment2').className = 'collapse';
			}
		</script>

		<%-- 쓰레기 파일 : ${ trash_path }
		<br> 카테고리 : [${ category.category_no }, ${ category.category_name },
		${ category.category_content }, ${ category.category_tip }]
		<br> 카테고리 리스트
		<br> --%>
		<%-- <c:forEach items="${ requestScope.category_list }" var="cl">
		${ cl.category_no }, ${ cl.category_name }, ${ cl.category_content }, ${ cl.category_tip }] <br>
		</c:forEach> --%>
		<%-- 유저 : [${ sessionScope.loginUser.user_no }, ${ sessionScope.loginUser.user_email },
		${ sessionScope.loginUser.user_name }, ${ sessionScope.loginUser.user_admin },
		${ sessionScope.loginUser.user_date }] --%>
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
							<div class="row mt-5">
								<div class="col d-flex flex-column position-static text-md-end">
									<div>
										<button type="button" class="btn btn-lg btn-primary"
											onclick="button1();" style="height: 50px; width: 300px">
											<b>검사 갤러리에 공유하기</b>
										</button>
									</div>
									<br>
								</div>
								<div class="col d-flex flex-column position-static text-md-start">
									<div>
										<button type="button" class="btn btn-lg btn-danger"
											onclick="button2();" style="height: 50px; width: 300px">
											<b>잘못된 분류로 신고하기</b>
										</button>
									</div>
						        </div>
							</div>
						</div>
					</div>
				</div>
			</section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>