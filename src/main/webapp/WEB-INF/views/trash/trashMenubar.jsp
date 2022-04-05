<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!DOCTYPE html>
<html>

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>

<!--
<script type="text/javascript">
	$(function() {
		/* 주기적으로 자동 실행되게 하려면 자바스크립트 내장함수 
		setInterval(실행시킬 함수명, 시간간격밀리초(1초가 1000이됨)) 사용하면 됨*/
		/* setInterval(function(){
			console.log("setInterval() 에 의해 자동 실행 확인.");
		}, 100); */

		// 최근 등록한 공지글 3개 출력되게 함
		$.ajax({
			url : "selectRecentList.do",
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log("success : " + data); //Object 로 받아짐

				// object => string 으로 바꿈
				var jsonStr = JSON.stringify(data);
				// string => json 객체로 바꿈 ->son안에 string이 들어있다.
				var json = JSON.parse(jsonStr);

				var values = "";
				for ( var i in json.list) { // i(index) 변수가 자동으로 1씩 증가 처리됨 
					values += "<tr><td>"
							+ json.list[i].trash_no
							// 한글 안깨지게 처리	
							+ decodeURIComponent(json.list[i].trash_path)
									.replace(/\+/gi, " ") + "</a></td><td>"
				} // for in

				$("#recentTrash").html($("#recentTrash").html() + values);
			},
			error : function(jqXHR, textstatus, errorthrown) {
				console.log("error : " + jqXHR + ", " + textstatus + ", "
						+ errorthrown);
			}
		}); // ajax 끝

	});
	-->
</script>
<head>
<c:import url="/WEB-INF/views/common/head.jsp" />
</head>
</head>
<c:import url="/WEB-INF/views/common/navi.jsp" />

<body>

	<%-- <h2 align="center">오늘의 쓰레기 : 총 ${ listCount } 개</h2> --%>
	<!-- 로그인 안 한 경우 -->
	<c:if test="${ empty sessionScope.loginMember }">
		<ul id="menubar">
			<li><a
				href="${ pageContext.servletContext.contextPath }/tlist.do">전체
					쓰레기 조회</a></li>
			<li><a
				href="${ pageContext.servletContext.contextPath }/moveDescPage.do">업로드파일
					분류정보</a></li>
		</ul>
	</c:if>
	<!-- 로그인 한 경우 : 관리자인 경우 -->
	<c:if
		test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'Y' }">
		<ul id="menubar">
			<li><a
				href="${ pageContext.servletContext.contextPath }/tlist.do">전체
					쓰레기 조회</a></li>
			<li><a
				href="${ pageContext.servletContext.contextPath }/moveDescPage.do">업로드파일
					분류정보</a></li>
		</ul>
	</c:if>
	<!-- el 에서의 절대경로 표기 : 
       "${ pageContext.servletContext.contextPath }/대상이름.do" -->
	<!-- 로그인 한 경우 : 일반회원인 경우 -->
	<c:if
		test="${ !empty sessionScope.loginMember and sessionScope.loginMember.admin eq 'N' }">
		<ul id="menubar">
			<li><a
				href="${ pageContext.servletContext.contextPath }/tlist.do">전체
					쓰레기 조회</a></li>
			<li><a
				href="${ pageContext.servletContext.contextPath }/moveDescPage.do">업로드파일
					분류정보</a></li>
		</ul>
	</c:if>





	<!-- 	<section>
		최근 업로드 쓰레기 출력
		<div
			style="float: left, border: 1px solid navy; padding: 5px; margin: 5px;">
			<h4>최근 업로드된 쓰레기</h4>
			<table id="recentTrash" border="1" cellspacing="0">
				<tr>
					<th>번호</th>
					<th>이미지</th>
				</tr>
			</table>
		</div>
	</section>	 -->



	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>