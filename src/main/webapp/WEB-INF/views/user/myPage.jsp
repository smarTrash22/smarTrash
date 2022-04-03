<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
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
                        <h1 class="fw-bolder" align="left">마이 페이지</h1>
                    </div>
                    <hr>
                    <div class="row gx-5">
                        <!-- Pricing card free-->
 						<div class="pb-5">
	 						<h5 class="fw-bolder" align="left">닉네임 &nbsp; &nbsp; ${ loginUser.user_name } <button>닉네임수정</button></h5>
							<h4>작성 갤러리 목록</h4>
							<h4>조회한 쓰레기</h4>
							<button align="right">회원탈퇴</button>
						</div>
                    </div>
                </div>
            </section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>