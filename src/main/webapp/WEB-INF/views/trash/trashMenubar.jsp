<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
	<c:import url="/WEB-INF/views/common/head.jsp" />
	</head>
</head>
<c:import url="/WEB-INF/views/common/navi.jsp" />

<body>
	<!-- 로그인 안 한 경우 -->
	<c:if test="${ empty sessionScope.loginMember }">
		<ul id="menubar">
			<li><a href="${ pageContext.servletContext.contextPath }/trashListView.do">전체 쓰레기 조회</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/trashInsert.do">쓰레기 추가</a></li>
		</ul>
	</c:if>
	<!-- 로그인 한 경우 : 관리자인 경우 -->
	<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'Y' }">
		<ul id="menubar">
			<li><a href="${ pageContext.servletContext.contextPath }/trashListView.do">전체 쓰레기 조회</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/trashInsert.do">쓰레기 추가</a></li>
		</ul>
	</c:if>
	<!-- el 에서의 절대경로 표기 : 
	    "${ pageContext.servletContext.contextPath }/대상이름.do" -->
	<!-- 로그인 한 경우 : 일반회원인 경우 -->
	<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'N' }">
		<ul id="menubar">
			<li><a href="${ pageContext.servletContext.contextPath }/trashListView.do">전체 쓰레기 조회</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/trashInsert.do">쓰레기 추가</a></li>
		</ul>
	</c:if>
<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>