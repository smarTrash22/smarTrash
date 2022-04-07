<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="listCount" value="${ listCount }" />
<c:set var="startPage" value="${ startPage }" />
<c:set var="endPage" value="${ endPage }" />
<c:set var="maxPage" value="${ maxPage }" />
<c:set var="currentPage" value="${ currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SmarTrash - ${ page_title }</title>
<script type="text/javascript">
	/* function showWriteForm(){
	 location.href = "${ pageContext.servletContext.contextPath }/nwform.do";
	 } */
/* function checkForm() {
    let chk_langs = document.getElementsByName('notice_no');
    let notice_no =[];	
   	for(let i = 0 ; i<chk_langs.length ; i++){
   		if(chk_langs[i].checked){
   			notice_no.push(chk_langs[i].value);
   		}
   	}
	console.log(notice_no);

} */
function checkForm() {
	 // 내용 입력 유무 체크
   var content = document.getElementsByName('keyword')[0];
   if(content.value == ''){
       alert('검색어을 입력하세요.');
       return false;
   }
   searchForm.submit();
}
</script>
<c:import url="/WEB-INF/views/common/head.jsp" />
<style type="text/css">
ul {
	text-align: center;
}

a {
	text-align: center;
	text-decoration: none;
	color: inherit;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/navi.jsp" />
	<br>
	<!-- <h2 align="center">Notice Board</h2> -->
	<%-- <c:if test="${ !empty sessionScope.loginMember }">
	<div>
		<button onclick="showWriteForm();">글쓰기</button>
	</div>
</c:if> --%>
	<div
		style="padding-left: 20%; padding-right: 20%; ">
		<hr>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th width="7%" scope="col">번호</th>
					<th width="50%" scope="col">제목</th>
					<th width="7%" scope="col">글쓴이</th>
					<th width="7%" scope="col">파일</th>
					<th width="7%" scope="col">작성일</th>
					<th width="7%" scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ requestScope.list }" var="n">
					<tr align="center">
						<td width="5%" align="left"><font size="2">${ n.notice_no }</font></td>
						<c:url var="ndt" value="/ndetail.do">
							<c:param name="notice_no" value="${ n.notice_no }" />
							<c:param name="page" value="${ currentPage }" />
						</c:url>
						<td width="55%" align="left"><a href="${ ndt }">${ n.notice_title }</a></td>
						<td width="15%" align="left"><font size="2">${ n.notice_writer }</font></td>
						<td width="5%" align="left"><c:if
								test="${ !empty n.notice_original_filepath }">
								<i class="bi bi-file-earmark-arrow-down"></i>
							</c:if> <c:if test="${ empty n.notice_original_filepath }">&nbsp;</c:if>
						</td>
						<td width="5%" align="left"><font size="2"><fmt:formatDate value="${ n.notice_date}"
								type="date" pattern="yy.MM.dd" /></font></td>
						<td width="5%" align="center"><font size="2">${ n.notice_readcount }</font></td>
						<%-- <td width="3%">
						<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.user_admin eq 'Y' }">
						<form action="ndel.do" method="post" id="form">
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" value="${ n.notice_no }" name="notice_no">
						</div>
						
						</form>
						</c:if>
						</td> --%>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${ empty requestScope.list}">
					<div align="center">검색결과가 없습니다.</div>
		</c:if>
		<div align="right">
		<button class="btn btn-primary" type="button" onclick="javascript:location.href='nlist.do';">목록</button>
			<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.user_admin eq 'Y' }">
				<button type="button" class="btn btn-primary"
					onclick="javascript:location.href='movewrite.do';">${ loginMember.user_admin } 글쓰기</button>
			</c:if>
		<%-- 	<c:if test="${ !empty sessionScope.loginUser and sessionScope.loginUser.user_admin eq 'Y' }">
				<button type="button" class="btn btn-sm btn-primary"
					onclick="checkForm();">delete</button>
			</c:if> --%>
		</div>
		<!-- 페이징 -->
	</div>
	<div class="d-flex justify-content-center">
		<nav aria-label="Page navigation example">
			<ul class="pagination pagination-sm">
				<!-- 맨처음 페이지 -->
				<c:if test="${ currentPage eq 1 }">
					<li class="page-item disabled"><a class="page-link" href="#"><i
							class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
				<c:if test="${ empty currentPage }">
				<li class="page-item disabled"><a class="page-link" href="#"><i
							class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
		
				<c:if test="${ currentPage > 1 }">
					<c:url var="nlf" value="/nsearch.do">
						<c:param name="page" value="1"></c:param>
						<c:param name="type" value="title"></c:param>
						<c:param name="keyword" value="test"></c:param>
					</c:url>
					<li class="page-item "><a class="page-link" href="${ nlf }"><i
							class="bi bi-chevron-double-left"></i></a></li>
				</c:if>
				<!-- 이전 페이지 -->
				<c:if
					test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
					<li class="page-item disabled"><a class="page-link" href="#"><i
							class="bi bi-chevron-left"></i></a></li>
				</c:if>
				<c:if
					test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
					<c:url var="nlf3" value="/nsearch.do">
						<c:param name="page" value="${ startPage - 10 }" />
						<c:param name="type" value="title"></c:param>
						<c:param name="keyword" value="test"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ nlf3 }"><i
							class="bi bi-chevron-left"></i></a></li>
				</c:if>
				<!-- 현재 페이지가 속한 페이지그룹 출력 -->
				<c:forEach var="p" begin="${ startPage }" end="${ endPage }"
					step="1">
					<c:if test="${ p eq currentPage }">
						<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
					</c:if>
					<c:if test="${ p ne currentPage }">
						<c:url var="nlf5" value="/nsearch.do">
							<c:param name="page" value="${ p }" />
							<c:param name="type" value="title"></c:param>
						<c:param name="keyword" value="test"></c:param>
						</c:url>
						<li class="page-item"><a class="page-link" href="${ nlf5 }">${ p }</a></li>
					</c:if>
				</c:forEach>
				<!-- 다음 페이지 -->
				<c:if
					test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
					<li class="page-item disabled"><a class="page-link" href="#"><i
							class="bi bi-chevron-right"></i></a></li>
				</c:if>
				<c:if
					test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
					<c:url var="nlf4" value="/nsearch.do">
						<c:param name="page" value="${ endPage + 10 }" />
						<c:param name="type" value="title"></c:param>
						<c:param name="keyword" value="test"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ nlf4 }"><i
							class="bi bi-chevron-right"></i></a></li>
				</c:if>
				<!-- 맨끝 페이지 -->
				<c:if test="${ currentPage eq maxPage }">
					<li class="page-item disabled"><a class="page-link" href="#"><i
							class="bi bi-chevron-double-right"></i></a></li>
				</c:if>
				<c:if test="${ currentPage < maxPage }">
					<c:url var="nlf2" value="/nsearch.do">
						<c:param name="page" value="${ maxPage }"></c:param>
						<c:param name="type" value="title"></c:param>
						<c:param name="keyword" value="test"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${ nlf2 }"><i
							class="bi bi-chevron-double-right"></i></a></li>
				</c:if>
			</ul>
		</nav>
	</div>
	<form action="nsearch.do" method="get">
		<div style="width: 400px;" class="input-group mb-3 container">
			<div class="input-group-text p-0 ">
				<select name="type"
					class="form-select form-select-xsm shadow-none bg-light border-0">
					<option value="title">제목</option>
					<option value="writer">글쓴이</option>
					<option value="titleOrWriter">제목+내용</option>
				</select>
			</div>
			<input style="width: 10px;" type="text" class="form-control"
				placeholder="Search Here" name="keyword">
			<button class="input-group-text shadow-none px-4 btn-secondary" type="button" onclick="checkForm()">
				<i class="bi bi-search"></i>
			</button>
		</div>
	</form>
 	<div style="padding-left: 20%; padding-right: 20%; ">
	<hr>
	</div>
	<c:import url="/WEB-INF/views/common/foot.jsp" />
</body>
</html>
