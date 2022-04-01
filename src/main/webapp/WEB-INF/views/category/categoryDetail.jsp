<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Page Title -->
<c:set var="page_title" value="${ category.category_name } 정보" />

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
                    <div class="text-center mb-5">
                        <h1 class="fw-bolder">${ category.category_name } 정보</h1>
                    </div>
                    <div class="row gx-5 justify-content-center">
                        <!-- Pricing card free-->
						<div style="width:200px;" class="mx-auto pb-5 justify-content-center">
							<div class="align-items-center d-flex justify-content-center">
								<img style="width:100%;" class="rounded-circle" src="${ pageContext.servletContext.contextPath }/resources/images/category/${ category.category_name }.png"/></a>
							</div>
							<div class="text-center">
								<h5>${ category.category_name }</h5>
								<p>${ category.category_content }</p>
								<p>${ category.category_tip }</p>
								<button class="btn btn-outline-secondary" onclick="javascript:location.href='category.do';">뒤로 가기</button>
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
