<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="/WEB-INF/views/common/head.jsp" />
</head>
</head>
<c:import url="/WEB-INF/views/common/navi.jsp" />

<body>
	<hr>
	<h2 align="center">쓰레기 목록 : 총 ${ list.size() } 개</h2>
	<br>
	<table align="center" border="1" width="900" cellspacing="0">
		<tr>
			<th>번호</th>
			<th>유저 번호</th>
			<th>카테고리 번호</th>
			<th>파일</th>
			<th>업로드 날짜</th>
			<th>신고여부</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="t">
		<tr>
			<td>${ t.trash_no }</td>
			<td>${ t.user_no }</td>
			<td>${ t.category_no }</td>
			<td>${ t.trash_path }</td>
			<td>${ t.trash_date }</td>
			<td>${ t.report }</td>
			</tr>
		</c:forEach>
	</table>
	<hr>
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>