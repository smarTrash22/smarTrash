<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
div table {
	border: 0px solid #444444;
	border-collapse: collapse;
}

div td {
	border: 0px solid #444444;
	padding: 7px;
}

div.photo {
	height: 180px;
	width: 180px;
	background-color: lightgray;
	color: white;
}

input[type=text] {
	padding: 5px;
	position: relative;
	top: 3px;
}
#title{
	font-size: 50px;
	opacity: 0.5;	
}
.search input{
  width: 400px;
  height: 30px;
  border: 2px solid rgb(209, 207, 207);
  border-radius: 15px; 
}
input::placeholder{
  text-align: center;
  font-size: 14px;
  opacity: 0.7;
}
#btn1 {
	width:70px;
	padding: 2px;
	border-radius: 20px;
	
}
</style>
</head>
<head>
	<c:import url="/WEB-INF/views/common/head.jsp" />
</head>
<body class="d-flex flex-column">
	<main class="flex-shrink-0">
		<!-- Navigation-->
		<c:import url="/WEB-INF/views/common/navi.jsp" />
		<div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-8">
				<div class="text-center my-5">
					<h1 id="title" class="fw-bolder mb-3">Gallery</h1>
				</div>
			</div>
		</div>
		<div align="center">
			<form action="해쉬태그검색용.do" method="post">
				<div class="search">
				<input type="text" size="30" placeholder="search hashtag..."
					onfocus="this.placeholder=''"
					onblur="this.placeholder='search hashtag...'" name="hashtag">
					<button id="btn1" class="btn btn-primary"btn type="submit">search</button>
				</div>
				
			</form>
		</div>
		<br>
		<div>
			<table align="center" border="1" cellspacing="0"
				cellpadding="1">

				<tr align="center">
					<td><div class="photo">사진1</div></td>
					<td><div class="photo">사진2</div></td>
					<td><div class="photo">사진3</div></td>
				</tr>
				<tr align="center">
					<td><div class="photo">사진4</div></td>
					<td><div class="photo">사진5</div></td>
					<td><div class="photo">사진6</div></td>
				</tr>
				<tr align="center">
					<td><div class="photo">사진7</div></td>
					<td><div class="photo">사진8</div></td>
					<td><div class="photo">사진9</div></td>
				</tr>

			</table>
		</div>
		<br>
		<p align="center">페이지 들어갈 자리</p>
		<br>
	</main>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>