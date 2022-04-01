<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  jstl의 절대경로 표기 : / == /context-root명 == /first
	=> first/src/main/webapp (context-root)을 의미
	context : application 을 의미함
	root 에서 출발시키는 경로를 웹에서 절대경로라고 함
 -->
<c:import url="/WEB-INF/views/common/pricing.jsp" /><!-- / = root에서 시작한다! -->
<hr>
<h1>에러 페이지</h1>
<!--  위에 isErrorPage= true 가 되야 사용할수 있음 -->
<c:set var= "e" value="<%= exception  %>" />
<c:if test="${ !empty e }">
	<h3>jsp 페이지 오류 발생 : ${ message }</h3>
</c:if>
<c:if test="${ empty e }">
		<h3>컨트롤러 오청 실패 메세지 : ${ message } </h3>
</c:if>
<!--  모든 컨트롤러의 호출은 루트에서 실행시키도록 한다 -->
<c:url var="movemain" value="/main.do"/><!--  루트에서 main.do 실행 -->
<a href="${ movemain }">시작페이지로 이동</a>
<hr>
<!--  상대경로 : 현재 문서를 기준으로 대상 파일까지의 경로
	같은 폴더 안의 파일이나 폴더 지정시 : 파일명.확장자, 폴더명/파일명.확장자
	다른폴더 안의 파일이나 폴더 지정시 : ./(현재폴더),../(한단계위로)
	
	예) 현재위치(common/error.jsp)에서 views/member/loginPage.jsp를 지정한다면
	"../member/loginPage.jsp"
	또는 webapp/resources/images/d7.jpg 를 지정한다면
	"../../../resources/images/d7.jpg"
	
 -->
</body>
</html>