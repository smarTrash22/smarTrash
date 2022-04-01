<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Page Title -->
<c:set var="page_title" value="분리수거 정보" />

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
                        <h1 class="fw-bolder">분리수거 정보</h1>
                    </div>
                    <div class="row gx-5 justify-content-center">
                        <!-- Pricing card free-->
                        <c:forEach items="${ requestScope.list }" var="c">
							<div style="width:200px;" class="mx-auto pb-5 justify-content-center">
								<div class="align-items-center d-flex justify-content-center">
									<c:url var="cdt" value="categoryDetail.do">
										<c:param name="category_no" value="${ c.category_no }" />
									</c:url>
									<a href="${ cdt }"><img style="width:100%;" class="rounded-circle" src="${ pageContext.servletContext.contextPath }/resources/images/category/${ c.category_name }.png"/></a>
								</div>
								<div class="mt-1">
									<h5 align="center">${ c.category_name_kor }</h5>
								</div>
							</div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>
