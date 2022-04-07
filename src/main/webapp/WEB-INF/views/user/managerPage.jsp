<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="rlistCount" value="${ requestScope.rlistCount }"/>
<c:set var="rstartPage" value="${ requestScope.rstartPage }"/>
<c:set var="rendPage" value="${ requestScope.rendPage }"/>
<c:set var="rmaxPage" value="${ requestScope.rmaxPage }"/>
<c:set var="rcurrentPage" value="${ requestScope.rcurrentPage }"/>

<c:set var="ulistCount" value="${ requestScope.ulistCount }"/>
<c:set var="ustartPage" value="${ requestScope.ustartPage }"/>
<c:set var="uendPage" value="${ requestScope.uendPage }"/>
<c:set var="umaxPage" value="${ requestScope.umaxPage }"/>
<c:set var="ucurrentPage" value="${ requestScope.ucurrentPage }"/>

<c:set var="onPage" value="${ requestScope.onPage }"/>
<c:set var="page_title" value="관리 페이지" />
<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js" ></script>
		<script type="text/javascript">		
			function changeLogin(element){
				console.log(element);
				var user_email = element.name.substring(8);
				$.ajax({
					url: "loginok.do", 
					type: "post",
					/* data: { user_email: $("#user_email").val() }, */
					data: { user_email: element.name.substring(8),
							login_ok: element.value },
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
					<c:if test="${ onPage eq 1 }">
                        <div class="col-lg-3 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0"></h2>
                        	<div id="btn_div" style="float: left; width:200px;">
                        		<c:url var="mainp" value="manager.do">
									<c:param name="inpage" value="1" />
								</c:url>
								<a class="a" id="m" href="${ mainp }" style="color: white; text-decoration: none;"><div class="b" style="background-color:#343a40;">MAIN</div></a>
								<br>
								<c:url var="userp" value="manager.do">
									<c:param name="inpage" value="2" />
								</c:url>
								<a class="a" id="u" href="${ userp }" style="color: white; text-decoration: none;"><div class="b">회원 관리</div></a>
								<br>
								<c:url var="reportp" value="manager.do">
									<c:param name="inpage" value="3" />
								</c:url>
								<a class="a" id="r" href="${ reportp }" style="color: white; text-decoration: none;"><div class="b">신고된 사진</div></a>
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
												<div style="font-size:80pt; font-weight:1000; color:darkgray;">${ tlc }</div>
											</div>
										</td>
									    <td rowspan='2' style="padding:1em;">
									    	<div>
												<div style="font-size:20px;">정확도</div>
												<div style="font-size:80pt; font-weight:1000; color:skyblue;">${ tacc }%</div>
											</div>
										</td>
									  </tr>
									  <tr>
									    <td style="padding : 1em;">
											<div>
												<div style="font-size: 20px;">오늘 신고된 쓰레기 수</div>
												<div style="font-size: 80pt; font-weight: 1000; color: darkgray;">${ trlc }</div>
											</div>
										</td>
									  </tr>
								  </tbody>
								</table>
							</div>
						</div>
					</c:if>
					<c:if test="${ onPage eq 2 }">
						<div class="col-lg-3 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0"></h2>
		                  	<div id="btn_div" style="float: left; width:200px;">
		                  		<c:url var="mainp" value="manager.do">
									<c:param name="inpage" value="1" />
								</c:url>
								<a class="a" id="m" href="${ mainp }" style="color: white; text-decoration: none;"><div class="b">MAIN</div></a>
								<br>
								<c:url var="userp" value="manager.do">
									<c:param name="inpage" value="2" />
								</c:url>
								<a class="a" id="u" href="${ userp }" style="color: white; text-decoration: none;"><div class="b" style="background-color:#343a40;">회원 관리</div></a>
								<br>
								<c:url var="reportp" value="manager.do">
									<c:param name="inpage" value="3" />
								</c:url>
								<a class="a" id="r" href="${ reportp }" style="color: white; text-decoration: none;"><div class="b">신고된 사진</div></a>
							</div>
						</div>
						<div class="user col-lg-8" id="user">
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
								<br>
								<div id="pg">
								<ul class="pagination" style="justify-content:center;">
									<!-- 1페이지로 이동처리 -->
									<c:if test="${ ucurrentPage eq 1 }">
										<li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-double-left"></i></a></li>
									</c:if>
									<c:if test="${ ucurrentPage > 1 }">
										<c:url var="u" value="/manager.do">
											<c:param name="upage" value="1" />
											<c:param name="inpage" value="2" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ u }"><i class="bi bi-chevron-double-left"></i></a></li>
									</c:if>
									<!--  이전페이지 그룹으로 이동처리  -->
									<c:if
										test="${ (ucurrentPage -10) < ustartPage and (ucurrentPage - 10) > 1 }">
										<c:url var="u2" value="/manager.do">
											<c:param name="upage" value="${ ustartPage - 10 }" />
											<c:param name="inpage" value="2" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ u2 }"><i class="bi bi-chevron-left"></i></a></li>
									</c:if>
									<c:if
										test="${ !((ucurrentPage -10) < ustartPage and (ucurrentPage - 10) > 1) }">
										<li class="page-item disabled"><a class="page-link" href="${ u2 }"><i class="bi bi-chevron-left"></i></a></li>
									</c:if>
									<!-- 현재 페이지가 속한 페이지 그룹 출력 -->
									<c:forEach var="p" begin="${ ustartPage }" end="${ uendPage }"
										step="1">
										<c:if test="${ p eq ucurrentPage }">
											<li class="page-item active"><a class="page-link" href="#">${ p }</a></li>
										</c:if>
										<c:if test="${ p ne ucurrentPage }">
											<c:url var="u3" value="/manager.do">
												<c:param name="upage" value="${ p }" />
												<c:param name="inpage" value="2" />
											</c:url>
											<li class="page-item"><a class="page-link" href="${ u3 }">${ p }</a></li>
										</c:if>
									</c:forEach>
									<!--  다음페이지 그룹으로 이동처리  -->
									<c:if test="${ (ucurrentPage + 10) > uendPage and (ucurrentPage + 10) < umaxPage }">
										<c:url var="u4" value="/manager.do">
											<c:param name="upage" value="${ uendPage + 10 }" />
											<c:param name="inpage" value="2" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ u4 }"><i class="bi bi-chevron-right"></i></a></li>
									</c:if>
									<c:if test="${ !((ucurrentPage + 10) > uendPage and (ucurrentPage + 10) < umaxPage) }">
										<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-right"></i></a></li>
									</c:if>
									<%-- <c:if test="${ ucurrentPage eq umaxPage }">
										<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-double-right"></i></a>
									</c:if> --%>
									<!-- 끝페이지로 이동처리 -->
									<c:if test="${ ucurrentPage < umaxPage }">
										<c:url var="u5" value="/manager.do">
											<c:param name="upage" value="${ umaxPage }" />
											<c:param name="inpage" value="2" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ u5 }"><i class="bi bi-chevron-double-right"></i></a>
									</c:if>
								</ul>
							</div>
							</div>
						</div>
					</c:if>
					<c:if test="${ onPage eq 3 }">
						<div class="col-lg-3 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0"></h2>
			                  	<div id="btn_div" style="float: left; width:200px;">
			                  		<c:url var="mainp" value="manager.do">
									<c:param name="inpage" value="1" />
								</c:url>
								<a class="a" id="m" href="${ mainp }" style="color: white; text-decoration: none;"><div class="b">MAIN</div></a>
								<br>
								<c:url var="userp" value="manager.do">
									<c:param name="inpage" value="2" />
								</c:url>
								<a class="a" id="u" href="${ userp }" style="color: white; text-decoration: none;"><div class="b">회원 관리</div></a>
								<br>
								<c:url var="reportp" value="manager.do">
									<c:param name="inpage" value="3" />
								</c:url>
								<a class="a" id="r" href="${ reportp }" style="color: white; text-decoration: none;"><div class="b" style="background-color:#343a40;">신고된 사진</div></a>
							</div>
						</div>
						<div class="col-lg-8 report">
							<table align="center" cellspacing="0" cellpadding="30">
								<tr align="center">
								<c:forEach items="${ requestScope.rlist }" var="r"  varStatus="status">
									<td>
									<div class="item">
										<a href="" style="text-decoration:none; color:inherit;">
											<img class="photo" style="width:150px; height:150px; background-size: 100% 100%;" src=${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ r.trash_path }>
										</a>
									</div>
									<div class="pt-1 user-select-none text-center">
									<fmt:formatDate value="${ r.trash_date }" pattern="yy-MM-dd" />
									<br>
									<fmt:formatDate value="${ r.trash_date }" pattern="HH:mm:ss" />
									</div>
									</td>
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
									<c:if test="${ rcurrentPage eq 1 }">
										<li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-double-left"></i></a></li>
									</c:if>
									<c:if test="${ rcurrentPage > 1 }">
										<c:url var="blf" value="/manager.do">
											<c:param name="rpage" value="1" />
											<c:param name="inpage" value="3" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ blf }"><i class="bi bi-chevron-double-left"></i></a></li>
									</c:if>
									<!--  이전페이지 그룹으로 이동처리  -->
									<c:if
										test="${ (rcurrentPage -10) < rstartPage and (rcurrentPage - 10) > 1 }">
										<c:url var="blf2" value="/manager.do">
											<c:param name="rpage" value="${ startPage - 10 }" />
											<c:param name="inpage" value="3" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ blf2 }"><i class="bi bi-chevron-left"></i></a></li>
									</c:if>
									<c:if
										test="${ !((rcurrentPage -10) < rstartPage and (rcurrentPage - 10) > 1) }">
										<li class="page-item disabled"><a class="page-link"
											href="${ blf2 }"><i class="bi bi-chevron-left"></i></a></li>
									</c:if>
									<!-- 현재 페이지가 속한 페이지 그룹 출력 -->
									<c:forEach var="p" begin="${ rstartPage }" end="${ rendPage }"
										step="1">
										<c:if test="${ p eq rcurrentPage }">
											<li class="page-item active"><a class="page-link" href="#">${ p }</a></li>
										</c:if>
										<c:if test="${ p ne rcurrentPage }">
											<c:url var="blf5" value="/manager.do">
												<c:param name="rpage" value="${ p }" />
												<c:param name="inpage" value="3" />
											</c:url>
											<li class="page-item"><a class="page-link" href="${ blf5 }">${ p }</a></li>
										</c:if>
									</c:forEach>
									<!--  다음페이지 그룹으로 이동처리  -->
									<c:if
										test="${ (rcurrentPage +10) > rendPage and (rcurrentPage + 10) < rmaxPage }">
										<c:url var="blf3" value="/manager.do">
											<c:param name="rpage" value="${ rendPage + 10 }" />
											<c:param name="inpage" value="3" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ blf3 }"><i class="bi bi-chevron-right"></i></a></li>
									</c:if>
									<c:if
										test="${ !((rcurrentPage +10) > rendPage and (rcurrentPage + 10) < rmaxPage) }">
										<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-right"></i></a></li>
									</c:if>
									<c:if test="${ rcurrentPage eq rmaxPage }">
										<li class="page-item disabled"><a class="page-link" href=""><i class="bi bi-chevron-double-right"></i></a>
									</c:if>
									<!-- 끝페이지로 이동처리 -->
									<c:if test="${ rcurrentPage < rmaxPage }">
										<c:url var="blf4" value="/manager.do">
											<c:param name="rpage" value="${ rmaxPage }" />
											<c:param name="inpage" value="3" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ blf4 }"><i class="bi bi-chevron-double-right"></i></a>
									</c:if>
								</ul>
							</div>
							<div style="float:right; border-radius:5px 5px; background-color:orange; font-size:15px;">
								<a class="nav-link" href="zipSet.do" style="color:white" >이미지 전체 저장</a>
							</div>
						</div>
					</c:if>
					</div>
				</div>
            </section>
		</main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html>