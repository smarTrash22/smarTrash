<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
	<h1 align="center">Smartash Login</h1>
	<hr>
	<br>
	<center>
		<c:choose>
			<c:when test="${sessionId != null}">
				<h2>네이버 아이디 로그인 성공하셨습니다!!</h2>
				<h3>'${sessionId}' 님 환영합니다!</h3>
				<h3>
					<a href="logout">로그아웃</a>
				</h3>
			</c:when>
			<c:otherwise>
<%-- 				<form action="login.userdo" method="post" name="frm" style="width: 470px;">
					<h2>로그인</h2>
					<input type="text" name="id" id="id" class="w3-input w3-border" placeholder="아이디" value="${id}"> 
					<br> 
					<input type="password" id="pwd" name="pwd" class="w3-input w3-border" placeholder="비밀번호"> <br> <input type="submit" value="로그인" onclick="#"> 
					<br>
				</form> --%>
				<br>
				<!-- 네이버 로그인 창으로 이동 -->
				<div id="naver_id_login" style="text-align:center">
					<a href="${url}"> <img width="245" src="${ pageContext.servletContext.contextPath }/resources/userImages/btnG_완성형.png" /></a>
				</div>
				<br>
				<!-- 카카오 로그인 창으로 이동 --> <!-- 커밋 -->
				<a href="https://kauth.kakao.com/oauth/authorize?client_id=deb4c9afa0906ffd568af7df8f8a4567&redirect_uri=http://127.0.0.1:8888/smartrash/&response_type=code">
				<img width="250" src="${ pageContext.servletContext.contextPath }/resources/userImages/kakao_login_medium_narrow.png">
<%-- 				<div id="kakaoLoginForm">
				<form action="kakaologin.do">
					<a id="kakaoLoginBtn" href="https://kauth.kakao.com/oauth/authorize?client_id=deb4c9afa0906ffd568af7df8f8a4567&redirect_uri=http://127.0.0.1:8888/smartrash/&response_type=code">
						<img width="250" src="${ pageContext.servletContext.contextPath }/resources/userImages/kakao_login_medium_narrow.png">
					</a>
				</form>
				</div> --%>
			</c:otherwise>
		</c:choose>
	</center>
</body>
</html>