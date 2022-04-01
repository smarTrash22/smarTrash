<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
	<c:import url="/WEB-INF/views/common/head.jsp" />
	</head>
    <body class="d-flex flex-column">
<!--     <main class="flex-shrink-0"> -->
     <!-- Navigation-->
	 <c:import url="/WEB-INF/views/common/navi.jsp" />
    <hr>	
	<h2 align="center"><b>쓰레기 등록 페이지 (관리자)</b></h2>
	<br>
	<form action="trashInsert.do"  method="post" enctype="multipart/form-data">
	<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
		<!-- <tr><th>쓰레기 번호</th><td><input type="text" name="trash_no"></td></tr> -->
		<tr><th>유저 번호</th><td><input type="text" name="user_no"></td></tr>
		<tr><th>카테고리 번호</th><td><input type="text" name="category_no"></td></tr>
		<tr><th>쓰레기 첨부파일</th><td><input type="file" name="trash_path"></td></tr>
		<!-- <tr><th>쓰레기 등록날짜</th><td><input type="date" name="trash_date"></td></tr> -->
		<!-- <tr><th>신고 여부(Y/N)</th><td><input type="text" name="report"></td></tr> -->	
		<tr><td colspan="2">
		<input type="submit" value="등록하기"> &nbsp;
		<input type="reset" value="작성취소"> &nbsp;
		<button onclick="javascript:history.go(-1); return false;">목록</button></td></tr>
	</table>
	</form>
	<br>	
	<hr>
	<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>
