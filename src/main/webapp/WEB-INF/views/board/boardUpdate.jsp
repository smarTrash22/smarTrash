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

td div a{
	text-decoration-line : none;
	font-size : 14px;
	color:orange;
}
#line {
	width: 100%;
	height: 2px;
	background-color: gray;
}

.td1 {
	padding: 9px
}

div#photobox {
	height: 300px;
	width: 250px;
	overflow: hidden;
	margin: 0 auto;
}

img#photo {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

textarea#t2 {
	width: 95%;
	height: 50%;
	padding: 10px;
	box-sizing: border-box;
	border: solid 2px #1E90FF;
	border-radius: 5px;
	font-size: 14px;
	resize: none;
}

#line2 {
	width: 100%;
	height: 2px;
	background-color: gray;
}
#line3 {
	width: 100%;
	height: 1.5px;
	background-color: gray;
}

#line4 {
	width: 100%;
	height: 1px;
	background-color: gray;
}

::placeholder {
	opacity: 0.5
}
;
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
					<h1 id="title" class="fw-bolder mb-3"
						style="font-size: 45pt; opacity: 0.6">
						<i>No.${ board.trash_no }</i>
					</h1>
				</div>
			</div>
		</div>
		<!-- 상단게시물 영역 -->
		<form action="boardupdate.do" method="post">
		<input type="hidden" name="board_no" value="${ board.board_no }"/>
		<input type="hidden" name="page" value="${ currentPage }"/>
		
			<table align="center" cellspacing="0" style = "word-break: break-all">
				<tr>
					<td class="td1" rowspan="3">
						<div id="photobox">
							<img id="photo"
								src="${ pageContext.servletContext.contextPath }/resources/trash_upfiles/${board.trash_path}" />
						</div>
					</td>
					<td class="td1" height="20">&nbsp;작성자 : <b>${ board.user_name }</b></td>
					<td align="right" class="td1" ><fmt:formatDate
							value="${ board.board_date }" type="date"
							pattern="yyyy-MM-dd kk:mm:ss" /></td>
					<td align="right" class="td1" >조회수:${ board.board_readcount }</td>
				</tr>
				<tr>
					<td colspan="3"><div id="line"></div></td>
				</tr>
				<tr>
					<td valign="top" class="td1" width="500" colspan="3"><textarea  rows="10" id="t2" name="board_content">${ board.board_content }</textarea></td>
					
				</tr>
				<tr>
					<td class="td1"><b>&nbsp; <c:forTokens var="hash"
								items="${ board.hashtag }" delims=",">
								<a href=""><c:out value="${ hash }" /></a> &nbsp;
						</c:forTokens>
					</b></td>
					<td align="right" class="td1" colspan="3">
						
						<button type="submit" class="btn btn-primary">저장</button>&nbsp;
						<button class="btn btn-secondary" type="button" onclick="location.href='bdetail.do?board_no=${ board.board_no }&page=${ currentPage }'">취소</button>
					</td>
						
				</tr>
			</table>
			</form>
		
		<!-- 댓글 영역 -->
		<br>
		 <div>
			<table align="center" border="1" cellspacing="0" style = "word-break: break-all">
				<tr>
					<td colspan="4"><span style="opacity:0.5; font-size:15px; font-weight:600;">댓글</span>
					<b style="color:orange;">${ listCount }</b>
					<span style="opacity:0.5; font-size:15px;font-weight:600;">개</span></td>
				</tr>
				<tr>
					<td colspan="4"><div align="center" id="line3"></div></td>
				</tr>
				</tr>
				<tr><td colspan="4" height="9"></td></tr>
				<tr>
				<c:forEach items="${ requestScope.list }" var="b"  varStatus="status">
					<tr>
						<td width="10"></td>
						<td colspan="3">
							<span style="font-weight:900; font-size:17px;">${b.user_name}</span>&nbsp;&nbsp;
							<span style="opacity:0.5; font-size:13px;"><fmt:formatDate
								value="${ b.board_date }" type="date"
								pattern="yyyy-MM-dd kk:mm:ss" /></span>
						</td>
					</tr>
					<tr><td colspan="4" height="10"></td></tr>
					<tr>
						<td></td><td colspan="3" width="500" style="font-size:15px">${ b.board_content }</td>
					</tr>
					<tr>
						<td width="20"></td>
						<td colspan="3"><div align="right">
						
						</div>
						</td>
					</tr>
					<tr>
						<td colspan="4"><div align="center" id="line4"></div></td>
					</tr>
				</c:forEach>
				<tr><td colspan="4" height="16"></td></tr>
				<tr>
					<td colspan="4" width="770">
					
					</td>
					
				</tr>
			</table>
		</div>
		<br>
	</main>
	<!-- Footer-->
	<c:import url="/WEB-INF/views/common/foot.jsp" />
	
</body>
</html>
