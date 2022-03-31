<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Page Title -->
<c:set var="page_title" value="Pricing" />

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
            <section class="bg-light py-5">
                <div class="container px-5 my-5">
                    <div class="text-center mb-5">
                        <h1 class="fw-bolder">Pay as you grow</h1>
                        <p class="lead fw-normal text-muted mb-0">With our no hassle pricing plans</p>
                    </div>
                    <div class="row gx-5 justify-content-center">
                        <!-- Pricing card free-->
                        <c:forEach items="${ requestScope.list }" var="c">
                        <div class="col-lg-6 col-xl-4">
                            <div class="card mb-5 mb-xl-0">
                                <div class="card-body p-5">
                                    <div class="small text-uppercase fw-bold text-muted">${ c.category_no }</div>
                                    <div class="mb-3">
                                        <span class="display-4 fw-bold">${ c.category_name }</span> 	
                                    </div>
                                    <ul class="list-unstyled mb-4">
                                        <li class="mb-2">
                                            <i class="bi bi-check text-primary"></i>
                                            <strong>${ c.category_content }</strong>
                                        </li>
                                        <li class="mb-2">
                                            <i class="bi bi-check text-primary"></i>
                                            ${ c.category_tip }
                                        </li>
                                    </ul>
                                    <div class="d-grid"><a class="btn btn-outline-primary" href="#!">Choose plan</a></div>
                                </div>
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
