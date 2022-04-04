<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js" ></script>
		<script type="text/javascript">
			
		</script>
		<meta charset="UTF-8">
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
		<style type="text/css">
			div.n{
				font-size:25px;
			}
		</style>
	</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Pricing section-->
            <section class="bg-light py-4">
                <div class="container px-5">
                    <div class="text-center mb-5">
                        <h1 class="fw-bolder">관리자 페이지</h1>
                    </div>
                    <hr>
                    <div class="gx-5">
                        <!-- Pricing card free-->
 						<div class="pb-5">
 							<div>
		 						<div class="n" id="nick_title" style="float:left; width:150px; font-weight:bold;">
		 							<div style="float:right; border-radius:5px 5px; background-color:darkgray; font-size:18px;"><a class="nav-link" href="udel.do" style="color:white" >MAIN</a>
		 						</div>
		 						<div class="n" id="nick" style="float:left; width:100px;">${ user.user_name }</div>
		 						<div style="float:right; border-radius:5px 5px; background-color:skyblue; font-size:18px;"><a class="nav-link" href="nickname.do" style="color:white" 
									onclick="window.open('${ pageContext.servletContext.contextPath }/nickname.do', '_blank', 'width=400, height=100, toolbars=no, scrollbars=yes'); return false;">닉네임수정</a>
								</div>
							</div>
						</div>
						<hr>
						<div class="pb-5">
								<div class="n" style="float:left; width:150px; font-weight:bold;">작성글 목록</div>
						</div>
						<div class="pb-5" border="1">
							<%-- <table id="mygal" border="1" cellspacing="0">
								<tr>
									<th>번호</th>
									<th>내용</th>
								</tr>
								<c:forEach items="${ blist }" var="b">
									<tr>
										<td>${ b.board_no }</td>
										<td>${ b.board_content }</td>
									</tr>
								</c:forEach>
							</table> --%>
							<c:forEach items="${ blist }" var="b">
								<div class="pb-4">
									<div style="float:left; width:80px; font-weight:bold; text-align:center">${ b.board_no }</div>
									<div style="float:left;"><a href="" style="text-decoration:none; color:inherit;">${ b.board_content }</a></div>
								</div>
							</c:forEach>
						</div>
						<hr>
						<div class="pb-5">
								<div class="n" style="float:left; width:200px; font-weight:bold;">조회한 쓰레기</div>
						</div>
						<div class="pb-5" border="1">
							<c:forEach items="${ tlist }" var="t">
								<div>
									<div style="float:left;"><a href="" style="text-decoration:none; color:inherit; margin:30px;">
										<img src=${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }></a>
									</div>
								</div>
							</c:forEach>
						</div>
						<hr>
						<div class="pb-5">
							<div style="float:right; border-radius:5px 5px; background-color:orange; font-size:18px;"><a class="nav-link" href="udel.do" style="color:white" >회원탈퇴</a>
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