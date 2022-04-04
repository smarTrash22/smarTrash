<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#s1').click(function(){
				document.getElementById('f').target="f4";
				document.getElementById('f').submit();
				alert("변경완료되었습니다.")
				opener.parent.location.reload();
				window.open('', '_self').close();
			})
})

</script>
<style type="text/css">
input.btn {
	border:none;
	box-shadow: none;
	color:#343a40; 
	text-align:center;
	background: none;
}

input:focus,
input:active,
button:focus,
button:active {
  outline: none;
  box-shadow: none;
}
</style>
<meta charset="UTF-8">
<title>닉네임 수정</title>
</head>
<body>
<form id="f" action="upnick.do" method="post">
	<table align="center" width="300" border="1" cellspacing="0" cellpadding="5">
		<tr><th>닉네임</th><td><input type="text" name="user_name" value="${ loginUser.user_name }"></td></tr> 
		<tr><td colspan="2">
			<input id ="s1" class="btn" type="submit" value="수정하기" style="float:left">
			<input class="btn" type="reset" value="수정취소" onclick="window.close();" style="float:right">
			</td>
	</table>
	</form>
</body>
</html> 