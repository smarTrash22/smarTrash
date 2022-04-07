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

<c:set var="listCount" value="${ listCount }" />
<c:set var="startPage" value="${ startPage }" />
<c:set var="endPage" value="${ endPage }" />
<c:set var="maxPage" value="${ maxPage }" />
<c:set var="currentPage" value="${ currentPage }" />

<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js" ></script>
		<script type="text/javascript">
		$(document).ready(function () {
		    var itemsMainDiv = ('.MultiCarousel');
		    var itemsDiv = ('.MultiCarousel-inner');
		    var itemWidth = "";

		    $('.leftLst, .rightLst').click(function () {
		        var condition = $(this).hasClass("leftLst");
		        if (condition)
		            click(0, this);
		        else
		            click(1, this)
		    });

		    ResCarouselSize();




		    $(window).resize(function () {
		        ResCarouselSize();
		    });

		    //this function define the size of the items
		    function ResCarouselSize() {
		        var incno = 0;
		        var dataItems = ("data-items");
		        var itemClass = ('.item');
		        var id = 0;
		        var btnParentSb = '';
		        var itemsSplit = '';
		        var sampwidth = $(itemsMainDiv).width();
		        var bodyWidth = $('body').width();
		        $(itemsDiv).each(function () {
		            id = id + 1;
		            var itemNumbers = $(this).find(itemClass).length;
		            btnParentSb = $(this).parent().attr(dataItems);
		            itemsSplit = btnParentSb.split(',');
		            $(this).parent().attr("id", "MultiCarousel" + id);


		            if (bodyWidth >= 1200) {
		                incno = itemsSplit[3];
		                itemWidth = sampwidth / incno;
		            }
		            else if (bodyWidth >= 992) {
		                incno = itemsSplit[2];
		                itemWidth = sampwidth / incno;
		            }
		            else if (bodyWidth >= 768) {
		                incno = itemsSplit[1];
		                itemWidth = sampwidth / incno;
		            }
		            else {
		                incno = itemsSplit[0];
		                itemWidth = sampwidth / incno;
		            }
		            $(this).css({ 'transform': 'translateX(0px)', 'width': itemWidth * itemNumbers });
		            $(this).find(itemClass).each(function () {
		                $(this).outerWidth(itemWidth);
		            });

		            $(".leftLst").addClass("over");
		            $(".rightLst").removeClass("over");

		        });
		    }


		    //this function used to move the items
		    function ResCarousel(e, el, s) {
		        var leftBtn = ('.leftLst');
		        var rightBtn = ('.rightLst');
		        var translateXval = '';
		        var divStyle = $(el + ' ' + itemsDiv).css('transform');
		        var values = divStyle.match(/-?[\d\.]+/g);
		        var xds = Math.abs(values[4]);
		        if (e == 0) {
		            translateXval = parseInt(xds) - parseInt(itemWidth * s);
		            $(el + ' ' + rightBtn).removeClass("over");

		            if (translateXval <= itemWidth / 2) {
		                translateXval = 0;
		                $(el + ' ' + leftBtn).addClass("over");
		            }
		        }
		        else if (e == 1) {
		            var itemsCondition = $(el).find(itemsDiv).width() - $(el).width();
		            translateXval = parseInt(xds) + parseInt(itemWidth * s);
		            $(el + ' ' + leftBtn).removeClass("over");

		            if (translateXval >= itemsCondition - itemWidth / 2) {
		                translateXval = itemsCondition;
		                $(el + ' ' + rightBtn).addClass("over");
		            }
		        }
		        $(el + ' ' + itemsDiv).css('transform', 'translateX(' + -translateXval + 'px)');
		    }

		    //It is used to get some elements from btn
		    function click(ell, ee) {
		        var Parent = "#" + $(ee).parent().attr("id");
		        var slide = $(Parent).attr("data-slide");
		        ResCarousel(ell, Parent, slide);
		    }

		});
		</script>
		<meta charset="UTF-8">
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
		<style type="text/css">
			div.n{
				font-size:25px;
			}

			.MultiCarousel { float: left; overflow: hidden; padding: 15px; width: 100%; position:relative; }
		    .MultiCarousel .MultiCarousel-inner { transition: 1s ease all; float: left; }
		        .MultiCarousel .MultiCarousel-inner .item { float: left;}
		        .MultiCarousel .MultiCarousel-inner .item > div { text-align: center; padding:10px; margin:10px; background:#f1f1f1; color:#666;}
		    .MultiCarousel .leftLst, .MultiCarousel .rightLst { position:absolute; border-radius:50%;top:calc(50% - 20px); }
		    .MultiCarousel .leftLst { left:0; }
		    .MultiCarousel .rightLst { right:0; }
		    
		        .MultiCarousel .leftLst.over, .MultiCarousel .rightLst.over { pointer-events: none; background:#ccc; }
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
									<th scope="col" colspan="3">Hashtag</th>
									<th scope="col"></th>
									<th scope="col"></th>
									<th scope="col">Date of creation</th>
									<th scope="col">Hits</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${ blist }" var="b">
									<tr align="center">
										<td align="left">${ b.board_no }</td>
										<%-- <c:url var="bd" value="bdetail.do"> --%> <%-- 자기글 조회시 조회수 증가 되도록함 --%>
										<c:url var="bd" value="mbdetail.do"> <%-- 자기글 조회시 조회수 증가 안되도록함 --%>
											<c:param name="board_no" value="${ b.board_no }" />
										</c:url>
										<td colspan="3" align="left"><a href="${ bd }" style="text-align: center; text-decoration: none; color: inherit;">${ b.board_content }</a></td>
										<td align="left"></td>
										<td align="left"></td>
										<td colspan="3" align="left"><a href="${ bd }" style="text-align: center; text-decoration: none; color: inherit;">${ b.hashtag }</a></td>
										<td align="left"></td>
										<td align="left"></td>
										<td align="left">${ b.board_date }</td>
										<td align="left">${ b.board_readcount }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<br>
						<div id="pg">
							<ul class="pagination" style="justify-content:center;">
								<!-- 1페이지로 이동처리 -->
								<c:if test="${ currentPage eq 1 }">
									<li class="page-item disabled"><a class="page-link" href="#"><i class="bi bi-chevron-double-left"></i></a></li>
								</c:if>
								<c:if test="${ currentPage > 1 }">
									<c:url var="blf" value="/mypage.do">
										<c:param name="page" value="1" />
									</c:url>
									<li class="page-item"><a class="page-link" href="${ blf }"><i class="bi bi-chevron-double-left"></i></a></li>
								</c:if>
								<!--  이전페이지 그룹으로 이동처리  -->
								<c:if
									test="${ (currentPage -10) < startPage and (currentPage - 10) > 1 }">
									<c:url var="blf2" value="/mypage.do">
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
										<c:url var="blf5" value="/mypage.do">
											<c:param name="page" value="${ p }" />
										</c:url>
										<li class="page-item"><a class="page-link" href="${ blf5 }">${ p }</a></li>
									</c:if>
								</c:forEach>
								<!--  다음페이지 그룹으로 이동처리  -->
								<c:if
									test="${ (currentPage +10) > endPage and (currentPage + 10) < maxPage }">
									<c:url var="blf3" value="/mypage.do">
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
									<c:url var="blf4" value="/mypage.do">
										<c:param name="page" value="${ maxPage }" />
									</c:url>
									<li class="page-item"><a class="page-link" href="${ blf4 }"><i class="bi bi-chevron-double-right"></i></a>
								</c:if>
							</ul>
						</div>
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
						<div class="container">
							<div class="row">
								<div class="MultiCarousel" data-items="1,3,5,6" data-slide="1" id="MultiCarousel"  data-interval="1000">
						            <div class="MultiCarousel-inner">
							            <c:forEach items="${ tlist }" var="t">
											<div class="item">
												<a href="" style="text-decoration:none; color:inherit; margin:40px;">
													<img style="width:150px; height:150px; background-size: 100% 100%;" src=${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${ t.trash_path }>
												</a>
											</div>
										</c:forEach>
						            </div>
						            <button class="btn btn-primary leftLst"><</button>
						            <button class="btn btn-primary rightLst">></button>
						        </div>
							</div>
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