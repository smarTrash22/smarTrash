<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Page Title -->
<c:set var="page_title" value="Content" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
	<head>
		<title>SmarTrash - ${ page_title }</title>
		<c:import url="/WEB-INF/views/common/head.jsp" />
		<style>
			div table {
				border: 0px solid #444444;
				border-collapse: collapse;
			}
			
			div td {
				border: 0px solid #444444;
			}
			
			#line {
				width:500px;
				height:2px;
				background-color: gray;
			}
			
			.td1 {
				padding:9px
			}
			
			div#photo {
				height: 300px;
				width: 250px;
				background-color: lightgray;
				color: white;
				margin:5px;
				background-size: contain;
				background-repeat: no-repeat;
				background-position: center;
			}
			textarea {
			width: 48%;
			height: 50px;
			padding: 10px;
			box-sizing: border-box;
			border: solid 2px #1E90FF;
			border-radius: 5px;
			font-size: 14px;
			resize: none;
			}
			#line2 {
				width:52%;
				height:2px;
				background-color: gray;
			}
			::placeholder { opacity:0.5 };
		</style>
	</head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Page content-->
            <div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-8">
				<div class="text-center my-5">
					<h1 id="title" class="fw-bolder mb-3" style="font-size:45pt; opacity:0.6"><i>No.${ board.trash_no }</i></h1>
				</div>
			</div>
		</div>
		<!-- 상단게시물 영역 -->
		<div>
			<table id="tb" align="center" border="1" cellspacing="0" >
				<tr>
					<td class="td1" rowspan="3">
						<div id="photo" style="background-image: url('${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${board.trash_path}');">
							<%-- <img src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${board.trash_path}" /> --%>
						</div>
					</td>
					<td class="td1" width="200" height="20"><b>&nbsp;${ board.trash_no }쓰레기의 유저 아이디</b></td>
					<td align="right" class="td1" width="200"><fmt:formatDate value="${ board.board_date }" type="date"
						pattern="yyyy-MM-dd kk:mm:ss" /></td>
					<td align="right" class="td1" width="100">조회수:${ board.board_readcount }</td>
				</tr>
				<tr>
					<td colspan="3"><div id="line"></div></td>
				</tr>
				<tr>
					<!-- <td></td> -->
					<td valign="top"class="td1" colspan="3">${ board.board_content }</td>
					<!-- <td></td>
					<td></td> -->
				</tr>
				<tr>
					<td class="td1" ><b>&nbsp;
						<c:forTokens  var="hash" items="${ board.hashtag }" delims=",">
						    <a href=""><c:out value="${ hash }"/></a> &nbsp;
						</c:forTokens>
						</b>
					</td>
					<td align="right" class="td1" colspan="3">
						<button type="button" class="btn btn-secondary">수정</button>&nbsp;
						<button type="button" class="btn btn-danger">삭제</button>
					</td>
					<!-- <td></td>
					<td></td> -->
				</tr>
			</table>
		</div>
		<!-- 댓글 영역 -->
		<div class="board_cmt" align="center">
			<div style="width:52%;"><div align="left">댓글 <b>n</b>개</div></div>
		</div>
		<div class="board_cmt" align="center">
			<div align="center" id="line2"></div>
			<br>
		</div>
		<div class="board_cmt" align="center">
			댓글목록 영역------------------------
			<br>
			<br>
			<form>
				<textarea maxlength="150" placeholder="댓글을입력하세요"></textarea>
				<button type="button" class="btn btn-primary" style="position: relative;
  				  top: -20px;">입력</button>&nbsp;
			</form>
		</div>
        </main>
        <!-- Footer-->
		<c:import url="/WEB-INF/views/common/foot.jsp" />
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
