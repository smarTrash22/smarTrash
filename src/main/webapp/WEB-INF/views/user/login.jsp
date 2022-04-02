<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>SmarTrash - Login</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
	</head>
	<body class="d-flex flex-column">
		<main class="flex-shrink-0">
			<!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
			<!-- Pricing section-->
			<section class="py-4">
				<div class="container px-5">
					<div class="text-center mb-5">
						<h1 class="fw-bolder">Smartrash 로그인</h1>
					</div>
					<div class="row gx-5 justify-content-center">
						<div id="naver_id_login" style="text-align:center">
						<a href="${naverUrl}"> <img width="245" src="${ pageContext.servletContext.contextPath }/resources/userImages/btnG_완성형.png" /></a>
						</div>
						<br>
						<%-- <a href="https://kauth.kakao.com/oauth/authorize?client_id=deb4c9afa0906ffd568af7df8f8a4567&redirect_uri=http://127.0.0.1:8888/smartrash/&response_type=code">
						<img width="250" src="${ pageContext.servletContext.contextPath }/resources/userImages/kakao_login_medium_narrow.png"> --%>
 					</div>
               </div>
			</section>
		</main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>