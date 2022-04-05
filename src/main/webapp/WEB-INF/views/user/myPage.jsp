<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js" ></script>
		<script type="text/javascript">
			function nickChange(){
				window.name = "mypage.do";
				
				window.open('${ pageContext.servletContext.contextPath }/nickname.do', 'upnick',  'width: 240px, height: 400px')
			}
			$(function(){
				$.ajax({
					url: "latest5.do",
					type: "post",
					dataType: "json",
					success: function(data){
						console.log("success : " + data);
						
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						
						var values = "";
						for(var i in json.list){
							values += "<tr><td>" + json.list[i].trash_no
									+ "</td><td><img src='${ pageContext.servletContext.contextPath }/resources/images/" + json.list[i].trash_path + "'>"
									+ "</td></tr>"
						} //for in
						
						$("#mytrash").html($("mytrash").html() + values);
					},
					error: function(jqXHR, textstatus, errorthrown){
						console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
					}
				}); //ajax
				
				$.ajax({
					url: "mygal5.do",
					type: "post",
					dataType: "json",
					success: function(data){
						console.log("success : " + data);
						
						var jsonStr = JSON.stringify(data);
						var json = JSON.parse(jsonStr);
						
						var values = "";
						for(var i in json.list){
							values += "<tr><td>" + json.list[i].board_no
									+ "</td><td>" + json.list[i].board_content
									+ "</td></tr>"
						} //for in
						
						$("#mygallery").html($("#mygallery").html() + values);
					},
					error: function(jqXHR, textstatus, errorthrown){
						console.log("error : " + jqXHR + ", " + textstatus + ", " + errorthrown);
					}
				}); //ajax
			}); //doc ready
		</script>
		<meta charset="UTF-8">
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
		<style type="text/css">
			div#delForm{
				border : 1px solid gray;
				width : 100px;
				float: right;
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
                        <h1 class="fw-bolder" align="left">마이 페이지</h1>
                    </div>
                    <hr>
                    <div class="gx-5">
                        <!-- Pricing card free-->
 						<div class="pb-5">
	 						<div class="fw-bolder" align="left" style="font-size:x-large; width:15%; float:left">닉네임</div>
	 						<div style="width:70%; float:left; font-size:x-large;"> ${ loginUser.user_name }</div>
	 						<div align="right" style="width:14%; float:left; border:1px; solid gray; text-align:center;">
								<a class="nav-link" href="nickname.do" style="color:#343a40" 
								onclick="window.open('${ pageContext.servletContext.contextPath }/nickname.do', '_blank', 'width=400, height=100, toolbars=no, scrollbars=yes'); return false;">닉네임수정</a>
							</div>
	 						<br><br><br>
							<h4>작성 갤러리 목록</h4>
							<div class="fw-bolder" align="left" style="font-size:x-large; width:15%; float:left">
								<table id="mygallery" border="1" cellspacing="0">
									<tr>
										<th>번호</th>
										<th>갤러리</th>
									</tr>
								</table>
							</div>
							<br>
							<h4>조회한 쓰레기</h4>
							<br>
							<div>
								<table id="mytrash" border="1" cellspacing="0">
									<tr>
										<th>번호</th>
										<th>쓰레기</th>
									</tr>
								</table>
							</div>
							<div align="right" id="delForm">
								<c:url var="udel" value="udel.do">
									<c:param name="${ loginUser.user_no }"/>
								</c:url>
								<a class="nav-link" href="udel.do" style="color:#343a40">회원탈퇴</a>
							</div>
							<iframe name="f4" style="display:none;"/>
						</div>
                    </div>
                </div>
            </section>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
    </body>
</html> --%>


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
                        <h1 class="fw-bolder" align="left">마이 페이지</h1>
                    </div>
                    <hr>
                    <div class="gx-5">
                        <!-- Pricing card free-->
 						<div class="pb-5">
 							<div>
		 						<div class="n" id="nick_title" style="float:left; width:150px; font-weight:bold;">
		 							<a style="text-decoration:none; color:inherit;" 
		 							onclick="window.open('${ pageContext.servletContext.contextPath }/popManager.do', '_blank', 'width=500, height=100, toolbars=no, scrollbars=yes'); return false;">닉네임</a>
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
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th scope="col">No</th>
									<th scope="col" colspan="3">Content</th>
									<th scope="col"></th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ blist }" var="b">
									<tr align="center">
										<td align="left">${ b.board_no }</td>
										<c:url var="bd" value="bdetail.do">
											<c:param name="board_no" value="${ b.board_no }" />
											<c:param name="page" value="${ currentPage }" />
										</c:url>
										<td colspan="3" align="left"><a href="${ bd }" style="text-align: center; text-decoration: none; color: inherit;">${ b.board_content }</a></td>
										<td align="left"></td>
										<td align="left"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
<%-- 						<div class="pb-5" border="1">
							<table id="mygal" border="1" cellspacing="0">
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
							</table>
							<c:forEach items="${ blist }" var="b">
								<div class="pb-4">
									<div style="float:left; width:80px; font-weight:bold; text-align:center">${ b.board_no }</div>
									<div style="float:left;"><a href="" style="text-decoration:none; color:inherit;">${ b.board_content }</a></div>
								</div>
							</c:forEach>
						</div> --%>
						<hr>
						<div class="pb-5">
								<div class="n" style="float:left; width:200px; font-weight:bold;">조회한 쓰레기</div>
						</div>
						<div class="pb-5" border="1">
							<c:forEach items="${ tlist }" var="t">
								<div>
									<div style="float:left;">
										<a href="" style="text-decoration:none; color:inherit; margin:40px;">
											<img src=${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }>
										</a>
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