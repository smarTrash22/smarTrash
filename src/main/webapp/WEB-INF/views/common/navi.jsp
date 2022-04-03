<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/smartrash/">SmarTrash</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="/smartrash/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${ pageContext.servletContext.contextPath }/nlist.do?page=1">공지 게시판</a></li>
                <li class="nav-item"><a class="nav-link" href="boardlist.do">검사 갤러리</a></li>
                <li class="nav-item"><a class="nav-link" href="category.do">분리수거 정보</a></li>
                <c:if test="${ empty sessionScope.sessionId }">
                	<li class="nav-item"><a class="nav-link" href="login.do">로그인</a></li>
                </c:if>
                <c:if test="${ !empty sessionScope.loginUser }">
                	<c:url var="callMyInfo" value="mypage.do"> <!-- MemberControll 의 메소드 실행 myinfo.do 찾아서 -->
						<c:param name="user" value="${ sessionScope.logunUser }" />
					</c:url>
					<li class="nav-item"><a class="nav-link" href="${ callMyInfo }">마이페이지</a></li>
                	<li class="nav-item"><a class="nav-link" href="logout.do">로그아웃</a></li>
                </c:if>
                <li class="nav-item"><a class="nav-link" href="trashMenubar.do">쓰레기 관리</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- 

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
        <a class="navbar-brand" href="/smartrash/">SmarTrash</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="/smartrash/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.do">공지 게시판</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.do">검사 갤러리</a></li>
                <li class="nav-item"><a class="nav-link" href="pricing.do">분리수거 정보</a></li>
                <li class="nav-item"><a class="nav-link" href="faq.do">로그인</a></li>
=======
                <li class="nav-item"><a class="nav-link" href="about.do">About</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.do">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="pricing.do">Pricing</a></li>
                <li class="nav-item"><a class="nav-link" href="${ pageContext.servletContext.contextPath }/nlist.do">FAQ</a></li>
>>>>>>> refs/remotes/origin/sws2
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Blog</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                        <li><a class="dropdown-item" href="blog-home.do">Blog Home</a></li>
                        <li><a class="dropdown-item" href="blog-post.do">Blog Post</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Portfolio</a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
                        <li><a class="dropdown-item" href="portfolio-overview.do">Portfolio Overview</a></li>
                        <li><a class="dropdown-item" href="portfolio-item.do">Portfolio Item</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

 -->