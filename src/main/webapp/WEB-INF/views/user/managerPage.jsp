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
			$(function(){
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
		
			var div2 = document.getElementsByClassName("b");
		
			function handleClick(event) {
				console.log(event.target);
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
				$('#m').click(function(){
					alert("m");
				});
				$('#u').click(function(){
					alert("u");
				});
				$('#da').click(function(){
					alert("r");
				});
			});
			
			function delUser(element){
				//선택한 radio의 name 속성의 이름에서 userid 분리 추출함. "loginok_달러중괄호 m.userid " 으로 받아서 8번 인덱스부터 userid 이고 8만쓰면 맨뒤까지 자동추출
				var userid = element.name.substring(8);
				console.log("changeLogin : " + userid);
				if(element.checked == true && element.value == "false"){
					//로그인 제한을 체크했다면
					console.log("로그인 제한 체크함");
					location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userid=" + userid + "&login_ok=N"; // userid, login_ok : 멤버클래스의 변수명 씀 = 자동으로 get, set이 됨
				}else{
					console.log("로그인 제한 해제함");
					location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userid=" + userid + "&login_ok=Y";
				}
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
							<table width="800" class="main" style="border-collapse: separate; border-spacing: 0 1rem;">
								<tbody>
								  <tr>
								    <td style="padding : 1em;">
								    	<div>
											<div style="font-size:20px;">오늘 분석된 쓰레기 수</div>
											<div style="font-size:80pt; font-weight:1000; color:darkgray;">100</div>
										</div>
									</td>
								    <td rowspan='2' style="padding:1em;">
								    	<div>
											<div style="font-size:20px;">정확도</div>
											<div style="font-size:80pt; font-weight:1000; color:skyblue;">80%</div>
										</div>
									</td>
								  </tr>
								  <tr>
								    <td style="padding : 1em;">
										<div>
											<div style="font-size: 20px;">오늘 신고된 쓰레기 수</div>
											<div style="font-size: 80pt; font-weight: 1000; color: darkgray;">20</div>
										</div>
									</td>
								  </tr>
							  </tbody>
							</table>
							<div class="user">
								<div class="col-lg-8">
									<table align="center" cellspacing="0" cellpadding="3" width="800">
										<tr>
											<th>회원번호</th>
											<th>닉네임</th>
											<th>이메일</th>
											<th>가입일</th>
											<th>관리자유무</th>
											<th></th>
										</tr>
										<c:forEach items="${ requestScope.ulist }" var="u">
											<tr>
												<td>${ u.user_no }</td>
												<td>${ u.user_name }</td>
												<td>${ u.user_email }</td>
												<td>${ u.user_date }</td>
												<td>${ u.user_admin }</td>
												<td>
													<c:url var="du" value="udel.do">
														<c:param name="user_email" value="${ u.user_email }"></c:param>
													</c:url>
													<a id="da" href="" style="color: white; text-decoration: none;">
													<div style="float:right; border-radius:5px 5px; background-color:orange; font-size:15px; width:80px;">
														탈퇴
													</div>
													</a>
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
										<td><a href="${ bdt }">
												<div class="photobox">
													<img class="photo" src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${r.trash_path}" />
												</div>
										</a></td>
										<c:if test="${ status.count eq 4 or status.count eq 8 }">
											<tr align="center">
											</tr>
										</c:if>
									</c:forEach>
									</tr>
								</table>
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