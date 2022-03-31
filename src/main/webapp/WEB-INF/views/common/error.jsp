<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<!-- jstl의 절대경로 표기 : / == /context-root명 == /first
	 => first/src/main/webapp (context-root)을 의미함
	 context : application을 의미함
	 root에서 출발시키는 경로를 웹에서 절대경로라고 함
 -->
<h1>에러 페이지</h1>
<hr>
<c:set var="e" value="<%= exception %>" />
<c:if test="${ !empty e }">
<h3>jsp 페이지 오류 발생 : ${ message }</h3>
</c:if>
<c:if test="${ empty e }">
	<h3>컨트롤러 요청 실패 메세지 : ${ message }</h3>
</c:if>
<c:url var="movemain" value="/main.do" />
<a href="${ movemain }">시작페이지로 이동</a>
<hr>
<!-- 상대경로 : 현재 문서를 기준으로 대상 파일까지의 경로
	 같은 폴더 안의 파일이나 폴더 지정 시 : 파일명.확장자, 폴더명/파일명.확장자
	 다른 폴더 안의 파일이나 폴더 지정 시 : ./(현재폴더), ../(한단계위로)
	 예, 현재 위치(common/error.jsp)에서
	 views/member/loginPage.jsp를 지정한다면
	 "../member/loginPage.jsp"
	 또는 webapp/resources/images/d7.jpg를 지정한다면
	 "../../../resources/images/d7.jpg"
 -->
<c:import url="footer.jsp" />
</body>
</html>