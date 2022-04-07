<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="listCount" value="${ requestScope.listCount }"/>
<c:set var="startPage" value="${ requestScope.startPage }"/>
<c:set var="endPage" value="${ requestScope.endPage }"/>
<c:set var="maxPage" value="${ requestScope.maxPage }"/>
<c:set var="currentPage" value="${ requestScope.currentPage }"/>

<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js" ></script>
		<script type="text/javascript">
/* 			$(function(){
 				$("#m").click(function(){
					$(".main").css("display", "block");
					$(".user").css("display", "none");
					$(".report").css("display", "none");
				});
				$("#u").click(function(){
					$(".main").css("display", "none");
					$(".user").css("display", "block");
					$(".report").css("display", "none");
				});
				$("#r").click(function(){
					$(".main").css("display", "none");
					$(".user").css("display", "none");
					$(".report").css("display", "block");
				});

			});	 */
		
			var div2 = document.getElementsByClassName("b");
		
			function handleClick(event) {
				console.log("ddd" + event.target);
				// console.log(this);
				// 콘솔창을 보면 둘다 동일한 값이 나온다
		
				console.log(event.target.classList);
		
				if (event.target.classList[1] === "clicked") {
					/* event.target.classList.remove("clicked"); */
				} else {
					for (var i = 0; i < div2.length; i++) {
						div2[i].classList.remove("clicked");
					}
		
					event.target.classList.add("clicked");
				}
			}
		
			function init() {
				for (var i = 0; i < div2.length; i++) {
					div2[i].addEventListener("click", handleClick);
				}
			}
			
			$(document).ready(function(){
				init();

 				$("#m").click(function(){
					$(".main").css("display", "block");
					$(".user").css("display", "none");
					$(".report").css("display", "none");
				});
				$("#u").click(function(){
					$(".main").css("display", "none");
					$(".user").css("display", "block");
					$(".report").css("display", "none");
				});
				$("#r").click(function(){
					$(".main").css("display", "none");
					$(".user").css("display", "none");
					$(".report").css("display", "block");
				});
			});

/* 			function changeLogin(element){
				var user_email = element.name.substring(8);
				console.log("changeLogin : " + user_email);
				if(element.checked == true && element.value == "false"){
					//로그인 제한을 체크했다면
					console.log("로그인 제한 체크함");
					location.href = "${ pageContext.servletContext.contextPath }/loginok1.do?user_email=" + user_email + "&login_ok=N";
					$("#user").load(window.location.href + "#user");
				}else{
					console.log("로그인 제한 해제함");
					location.href = "${ pageContext.servletContext.contextPath }/loginok1.do?user_email=" + user_email + "&login_ok=Y";
					$("#user").load(window.location.href + "#user");
				}
			} */
			
			function changeLogin(element){
				var user_email = element.name.substring(8);
				$.ajax({
					url: "loginok1.do", 
					type: "post",
					/* data: { user_email: $("#user_email").val() }, */
					data: { user_email: element.name.substring(8) },
					success: function(data){  //성공했을때 실행될 함수
						console.log("success : " + data); 
						if(data == "ok"){
							alert("변경되었습니다.");
						}else{
							alert("관리자는 변경할 수 없습니다.");
							$('#adm').prop('checked', true);
						}
					},
					error: function(jqXHR, textstatus, errorthrown){  //실패했을때 실행될 함수
						console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
					}
				})
			}
			
			function paging(element){
				var user_email = element.name.substring(8);
				$.ajax({
					url: "loginok1.do", 
					type: "post",
					/* data: { user_email: $("#user_email").val() }, */
					data: { user_email: element.name.substring(8) },
					success: function(data){  //성공했을때 실행될 함수
						console.log("success : " + data); 
						if(data == "ok"){
							alert("변경되었습니다.");
						}else{
							alert("관리자는 변경할 수 없습니다.");
							$('#adm').prop('checked', true);
						}
					},
					error: function(jqXHR, textstatus, errorthrown){  //실패했을때 실행될 함수
						console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
					}
				})
			}

		</script>
		<meta charset="UTF-8">
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
		<style type="text/css">
			.b {
				background-color:darkgray;
				border-radius:5px 5px; 
				font-size:15px; 
				text-align: center;
				padding: 0.5rem 1rem;
				text-decoration: none;
			}
			.clicked {
	        	background-color:#343a40;
	     	}
			.user{
				display:none;
			}
			
			.report{
				display:none;
			}
			table {
			text-align:center;
			}
		</style>
	</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Pricing section-->
            <section class="py-5 bg-light" id="features">
                <div class="container px-5 my-5">
                    <div class="row gx-5">
                    <div class="text-center mb-5">
						<h1 class="fw-bolder">관리자 페이지</h1>
					</div>
					<hr>
                        <div class="col-lg-3 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0"></h2>
                        	<div id="btn_div" style="float: left; width:200px;">
								<a class="a" id="m" style="color: white; text-decoration: none;"><div class="b">MAIN</div></a>
								<br>
								<a class="a" id="u" style="color: white; text-decoration: none;"><div class="b">회원 관리</div></a>
								<br>
								<a class="a" id="r" style="color: white; text-decoration: none;"><div class="b">신고된 사진</div></a>
							</div>
                        </div>
						<div class="col-lg-8">
							<div class="col-lg-8 main">
								<table width="750" style="border-collapse: separate; border-spacing: 0 1rem;">
									<tbody>
									  <tr>
									    <td style="padding : 1em;">
									    	<div>
												<div style="font-size:20px;">오늘 분석된 쓰레기 수</div>
												<div style="font-size:80pt; font-weight:1000; color:darkgray;">${ fn:length(tlist) }</div>
											</div>
										</td>
									    <td rowspan='2' style="padding:1em;">
									    	<div>
												<div style="font-size:20px;">정확도</div>
												<div style="font-size:80pt; font-weight:1000; color:skyblue;"><fmt:formatNumber value="${ (fn:length(tlist)-fn:length(trlist))/fn:length(tlist)*100 }" pattern=".00"/>%</div>
											</div>
										</td>
									  </tr>
									  <tr>
									    <td style="padding : 1em;">
											<div>
												<div style="font-size: 20px;">오늘 신고된 쓰레기 수</div>
												<div style="font-size: 80pt; font-weight: 1000; color: darkgray;">${ fn:length(trlist) }</div>
											</div>
										</td>
									  </tr>
								  </tbody>
								</table>
							</div>
							<div class="user" id="user">
								<div class="col-lg-8">
									<table align="center" cellspacing="0" cellpadding="3" width="800">
										<tr>
											<th>회원번호</th>
											<th>닉네임</th>
											<th>이메일</th>
											<th>가입일</th>
											<th>관리자유무</th>
											<th>로그인가능/제한</th>
										</tr>
										<c:forEach items="${ requestScope.ulist }" var="u">
											<tr>
												<td>${ u.user_no }</td>
												<td>${ u.user_name }</td>
												<td>${ u.user_email }</td>
												<td>${ u.user_date }</td>
												<td>${ u.user_admin }</td>
												<td>
													<c:if test="${ u.login_ok eq 'Y' }">
														<input id="adm" type="radio" name="loginok_${ u.user_email }" onchange="changeLogin(this);" value="true" checked> 가능 &nbsp;
														<input type="radio" name="loginok_${ u.user_email }" onchange="changeLogin(this);" value="false"> 제한
													</c:if>
													<c:if test="${ u.login_ok eq 'N' }">
														<input type="radio" name="loginok_${ u.user_email }" onchange="changeLogin(this);" value="true"> 가능 &nbsp;
														<input type="radio" name="loginok_${ u.user_email }" onchange="changeLogin(this);" value="false" checked> 제한
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
							<div class="report">
								<table align="center" cellspacing="0" cellpadding="30">
									<tr align="center">
									<c:forEach items="${ requestScope.rlist }" var="r"  varStatus="status">
<%-- 										<c:url var="bdt" value="bdetail.do">
										<c:param name="board_no" value="${ r.trash_no }" />
										<c:param name="page" value="${ currentPage }" />
										</c:url> --%>
										<td><a href="">
												<div class="photobox">
													<img class="photo" src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${r.trash_path}" />
												</div>
										</a></td>
										<c:if test="${ status.count eq 4 or status.count eq 8 or status.count eq 12}">
											<tr align="center">
											</tr>
										</c:if>
									</c:forEach>
									</tr>
								</table>
								<br>
								<div id="pg">
									<ul class="pagination" style="justify-content:center;">
										<!-- 1페이지로 이동처리 -->
										<c:if test="${ currentPage eq 1 }">
											<li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-double-left"></i></a></li>
										</c:if>
										<c:if test="${ currentPage > 1 }">
											<c:url var="blf" value="/manager.do">
												<c:param name="page" value="1" />
											</c:url>
											<li class="page-item"><a class="page-link" href="${ blf }"><i class="bi bi-chevron-double-left"></i></a></li>
										</c:if>
										<!--  이전페이지 그룹으로 이동처리  -->
										<c:if
											test="${ (currentPage -10) < startPage and (currentPage - 10) > 1 }">
											<c:url var="blf2" value="/manager.do">
												<c:param name="page" value="${ startPage - 10 }" />
											</c:url>
											<li class="page-item"><a class="page-link" href="${ blf2 }"><i class="bi bi-chevron-left"></i></a></li>
										</c:if>
										<c:if
											test="${ !((currentPage -10) < startPage and (currentPage - 10) > 1) }">
											<li class="page-item disabled"><a class="page-link"
												href="${ blf2 }"><i class="bi bi-chevron-left"></i></a></li>
										</c:if>
										<!-- 현재 페이지가 속한 페이지 그룹 출력 -->
										<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
											step="1">
											<c:if test="${ p eq currentPage }">
												<li class="page-item active"><a class="page-link" href="#">${ p }</a></li>
											</c:if>
											<c:if test="${ p ne currentPage }">
												<c:url var="blf5" value="/manager.do">
													<c:param name="page" value="${ p }" />
												</c:url>
												<li class="page-item"><a class="page-link" href="${ blf5 }">${ p }</a></li>
											</c:if>
										</c:forEach>
										<!--  다음페이지 그룹으로 이동처리  -->
										<c:if
											test="${ (currentPage +10) > endPage and (currentPage + 10) < maxPage }">
											<c:url var="blf3" value="/manager.do">
												<c:param name="page" value="${ endPage + 10 }" />
											</c:url>
											<li class="page-item"><a class="page-link" href="${ blf3 }"><i class="bi bi-chevron-right"></i></a></li>
										</c:if>
										<c:if
											test="${ !((currentPage +10) > endPage and (currentPage + 10) < maxPage) }">
											<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-right"></i></a></li>
										</c:if>
										<c:if test="${ currentPage eq maxPage }">
											<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-double-right"></i></a>
										</c:if>
										<!-- 끝페이지로 이동처리 -->
										<c:if test="${ currentPage < maxPage }">
											<c:url var="blf4" value="/manager.do">
												<c:param name="page" value="${ maxPage }" />
											</c:url>
											<li class="page-item"><a class="page-link" href="${ blf4 }"><i class="bi bi-chevron-double-right"></i></a>
										</c:if>
									</ul>
								</div>
								<div style="float:right; border-radius:5px 5px; background-color:orange; font-size:15px;">
									<a class="nav-link" href="zipSet.do" style="color:white" >이미지 전체 저장</a>
								</div>
							</div>
						</div>
					</div>
				</div>
            </section>
		</main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>