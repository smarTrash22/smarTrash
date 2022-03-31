<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
div table {
	border: 0px solid #444444;
	border-collapse: collapse;
}

div td {
	border: 0px solid #444444;
}

#line {
	width:420px;
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
}

</style>
</head>
	<c:import url="/WEB-INF/views/common/head.jsp" />
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
			<c:import url="/WEB-INF/views/common/navi.jsp" />
            <!-- Page content-->
            <div class="row justify-content-center">
			<div class="col-lg-8 col-xxl-8">
				<div class="text-center my-5">
					<h1 id="title" class="fw-bolder mb-3" style="font-size:45pt; opacity:0.6"><i>No.01</i></h1>
				</div>
			</div>
		</div>
		<!-- 상단게시물 영역 -->
		<div>
		<table id="tb" align="center" border="1" cellspacing="0" >
			<tr>
				<td class="td1" rowspan="3"><div id="photo">사진칸</div></td>
				<td class="td1" width="200" height="20"><b>&nbsp;user01</b></td>
				<td align="right" class="td1" width="120">2020-12-25</td>
				<td align="right" class="td1" width="100">조회수:30</td>
			</tr>
			<tr>
				<td colspan="3"><div id="line"></div></td>
			</tr>
			<tr>
				<!-- <td></td> -->
				<td valign="top"class="td1" colspan="3">작성내용칸 가나다라마바<br><br>작성내용칸<br>작성내용칸 가나다라마바<br><br>작성내용칸</td>
				<!-- <td></td>
				<td></td> -->
			</tr>
			<tr>
				<td class="td1" ><b>&nbsp;<a href="">#플라스틱</a>, <a href="">#패트병</a></b></td>
				<td align="right" class="td1" colspan="3">수정 삭제 버튼 위치영역</td>
				<!-- <td></td>
				<td></td> -->
			</tr>
		</table>
		<!-- 댓글 영역 -->
		<div id="rep" align="center">
		<br>
		-------댓글영역------
		
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
