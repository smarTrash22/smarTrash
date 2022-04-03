<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<c:import url="../common/navi.jsp" />
<br>
<form action="ninsert.do" method="post" enctype="multipart/form-data">
    <fieldset>
      <div style="padding-left: 20%; padding-right: 20%; padding-bottom: 10px;">
      	<input style="width: 200px;" class="form-control" name="notice_writer" type="text" value="songwonseop" aria-label="readonly input example" readonly><br>
        <input style="width: 450px;" type="text" class="form-control" name="notice_title" placeholder="Insert title here">
      <br>
        <textarea class="form-control" name="notice_content" rows="5"></textarea>
      <br>
        <input style="width: 300px;" class="form-control" type="file" name="upfile">
      <br>
      <div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-top: 10px;">
        <button class="btn btn-primary me-md-2" type="reset">Cancle</button>
        <button class="btn btn-primary" type="submit">Submit</button>
      </div>
    </div>
    </fieldset>
</form>
<!-- form에서 입력된 값들과 첨부파일을 같이 전송하려면, 반드시 enctype속성을 추가해야 함
	 enctype="multipart/form-data" 값을 지정해야 함 -->
<%-- <form action="ninsert.do" method="post" enctype="multipart/form-data">
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td><input type="text" name="noticetitle" /></td></tr>
	<tr><th>작성자</th><td><input type="text" name="noticewriter" readonly value="${ loginMember.userid }" /></td></tr>
	<tr><th>첨부파일</th><td><input type="file" name="upfile" /></td></tr>
	<tr><th>내용</th><td><textarea name="noticecontent" row="5" cols="50"></textarea></td></tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="등록하기"> &nbsp;
			<input type="reset" value="작성취소"> &nbsp;
			<button onclick="javascript:history.go(-1); return false;">목록</button>
		</td>
	</tr>
</table>
</form>
<br>
<hr> --%>
<c:import url="../common/foot.jsp" />
</body>
</html>