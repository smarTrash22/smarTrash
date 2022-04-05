<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="username" value="${ requestScope.user_name }" />
<!DOCTYPE html>
<html>
<head>
<script>
/* function writeform(){
	 location.href = "${ pageContext.servletContext.contextPath }/ninsert.do";
} */

</script>
<script type="text/javascript">
function cancle() {
	if(confirm("글작성을 취소하시겠습니까?")){
		javascript:history.go(-1);
	}else{
		return false;
	}
}
</script>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<c:import url="../common/navi.jsp" />
<br>
<form action="ninsert.do" method="post" enctype="multipart/form-data">
    <fieldset>
      <div style="padding-left: 20%; padding-right: 20%; padding-bottom: 10px;">
      	<hr>
      	<input style="width: 200px;" class="form-control" name="notice_writer" type="text" value="${ loginUser.user_name }" aria-label="readonly input example" readonly><br>
        <input style="width: 450px;" type="text" class="form-control" name="notice_title" placeholder="Insert title here">
      <br>
        <textarea class="form-control" name="notice_content" rows="5"></textarea>
      <br>
        <input style="width: 300px;" class="form-control" type="file" name="upfile">
      <br>
      <div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-top: 10px;">
        <!-- <button class="btn btn-primary" type="reset" onclick="del();">Reset</button> -->
        <button class="btn btn-primary" type="submit">Submit</button>
        <button onclick="cancle();" class="btn btn-primary" type="button">Cancle</button>
      </div>
      <hr>
    </div>
    </fieldset>
</form>
<c:import url="../common/foot.jsp" />
</body>
</html>