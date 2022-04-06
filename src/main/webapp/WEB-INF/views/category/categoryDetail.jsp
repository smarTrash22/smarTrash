<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Page Title -->
<c:set var="page_title" value="${ category.category_name_kor } 정보" />

<!DOCTYPE html>
<html>
	<head>
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
	</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Pricing section-->
			<section class="bg-light py-4">
				<div class="container px-5">
					<div class="row mb-2">
						<div class="col-md-12">
							<div class="row">
								<div class="col-md-12">
									<div class="row">
										<div class="col-auto">
										<h1 class="d-inline-block my-3 text-md-center">${ category.category_name_kor } 정보</h1>
										</div>
										<div class="col-auto">
										<button class="d-inline-block my-3 btn-sm text-md-end" onclick="location.href='category.do'">돌아가기</a>
										</div>
									</div>
								</div>
								<div class="col-md-12 d-flex align-items-center justify-content-center d-block d-lg-none">
									<div class="">
										<img style="width:100%;" class="align-self-center rounded-circle" src="${ pageContext.servletContext.contextPath }/resources/images/category/${ category.category_name }.png"/></a>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-auto d-flex align-items-center justify-content-center d-none d-lg-block">
									<div class="align-items-center justify-content-center">
										<img style="width:100%;" class=" rounded-circle" src="${ pageContext.servletContext.contextPath }/resources/images/category/${ category.category_name }.png"/></a>
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
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>
