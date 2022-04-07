<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function cancle() {
	if(confirm("글작성을 취소하시겠습니까?")){
		javascript:history.go(-1);
	}else{
		return false;
	}
}
function checkForm() {
    var title = document.getElementsByName('notice_title')[0];
    // 제목 입력 유무 체크
    if(title.value == '') {
        alert("제목을 입력하시오");
        return false;
    }
    var content = document.getElementsByName('notice_content')[0];
    // 내용 입력 유무 체크
    if(content.value == ''){
        alert('내용을 입력하세요.');
        return false;
    }
    
   form.submit();
}
</script>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<c:import url="../common/navi.jsp" />
<br>
<form action="nupdate.do" method="post" enctype="multipart/form-data" name="form">
<input type="hidden" name="notice_no" value="${ notice.notice_no }">
<c:if test="${ !empty notice.notice_original_filepath }">
	<input type="hidden" name="notice_original_filepath" value="${ notice_original_filepath }">
	<input type="hidden" name="notice_rename_filepath" value="${ notice_rename_filepath }">
</c:if>
    <fieldset>
      <div style="padding-left: 20%; padding-right: 20%; padding-bottom: 10px;">
      	<input style="width: 200px;" class="form-control" name="notice_writer" type="text" value="${ notice.notice_writer }" aria-label="readonly input example" readonly><br>
        <input style="width: 450px;" type="text" class="form-control" name="notice_title" value="${ notice.notice_title }">
      <br>
        <textarea class="form-control" name="notice_content" rows="5">${ notice.notice_content }</textarea>
      <br>
      <c:if test="${ !empty notice.notice_original_filepath }">
      	${ notice.notice_original_filepath } &nbsp;
      	<input type="checkbox" name="delFlag" value="yes"> 파일삭제<br>
      </c:if>
        <input style="width: 300px;" class="form-control" type="file" name="upfile">
      <br>
      <div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-top: 10px;">
        <!-- <button class="btn btn-primary" type="reset">Reset</button> -->
        <button onclick="checkForm();" class="btn btn-primary" type="button">등록</button>
        <button onclick="cancle();" class="btn btn-primary" type="button">취소</button>
      </div>
    </div>
    </fieldset>
</form>
<c:import url="../common/foot.jsp" />
</body>
</html>