<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js" ></script>

<style type="text/css">
h1 {
	font-size : 48pt;
	color : navy;
}
div#loginForm {
	width : 500px;
	height : 200px;
	border : 2px solid navy;
	position : relative; /* 본래 표시될 위치 기준 상대위치로 지정한다는 설정임 */
	left : 400px;
}

div form {
	font-size : 16pt;
	color : navy;
	font-weigth : bold;
	margin : 10px;
	padding : 10px;
}

div#loginForm form input.pos {
	position : absolute;  /*절대좌표로 위치 지정한다는 설정임 */
	left : 120px;
	width : 300px;
	height : 25px;	
}
div#loginForm form input[type=submit] {
	margin : 10px;
	width : 250px;
	height : 40px;
	position : absolute;
	left : 120px;
	background : navy;
	color : white;
	font-size : 16pt;
	font-weight : bold;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1 align="center">first 로그인</h1>
<div id="loginForm">
<form action="login.do" method="post"> 
<label>아 이 디 : <input type="text" name="userid" id="uid" class="pos"></label> <br>
<label>비밀번호 : <input type="password" name="userpwd" id="upwd" class="pos"></label> <br>
<input type="submit" value="로그인">
</form>
</div>

<div id="kakaoLoginForm">
<form action="kakaologin.do"> 
<a id="kakaoLoginBtn" href="https://kauth.kakao.com/oauth/authorize?client_id=deb4c9afa0906ffd568af7df8f8a4567&redirect_uri=http://127.0.0.1:8888/smartrash/&response_type=code">
	<img src="${ pageContext.servletContext.contextPath }/resources/userImages/kakao_login_medium_narrow.png">
</a>
</form>
</div>
<div>
</div>
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
			<form action="login.userdo" method="post" name="frm" style="width:470px;">
				<h2>로그인</h2>
				<input type="text" name="id" id="id" class="w3-input w3-border" placeholder="아이디" value="${id}"> 
				<br> 
				<input type="password" id="pwd" name="pwd" class="w3-input w3-border" placeholder="비밀번호"> 
				<br> 
				<input type="submit" value="로그인" onclick="#"> 
				<br>
			</form>
			<br>
			<!-- 네이버 로그인 창으로 이동 -->
			<div id="naver_id_login" style="text-align:center">
				<a href="${url}">
					<img width="223" src="${ pageContext.servletContext.contextPath }/resources/userImages/btnG_완성형.png" />
				</a>
			</div>
			<br>
		</c:otherwise>
	</c:choose>
</center>

</body>
</html>



















