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
		var pwdValue = document.getElementById("managerPwd").value;
		var managerPwd = "st";
		
		if(pwdValue !== managerPwd){
			alert("관리자 비밀번호가 틀렸습니다.\n다시 입력하세요.")
			document.getElementById("managerPwd").select(); //.select() = 포커싱
			return false; //전송 취소함
		}
		
		document.getElementById('f').target="f4";
		document.getElementById('f').submit();
		alert("변경완료되었습니다.")
		opener.parent.location.reload();
		window.open('', '_self').close();
	})
})
/* function validate(){
		//입력과 관리자비번이 같은 값인지 확인
		var pwdValue = document.getElementById("managerPwd").value;
		var managerPwd = "st";
		
		if(pwdValue !== managerPwd){
			alert("관리자 비밀번호가 틀렸습니다.\n다시 입력하세요.")
			document.getElementById("managerPwd").select(); //.select() = 포커싱
			return false; //전송 취소함
		}

		return true; //전송함
	} */
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
<form id="f" action="admin.do" method="post">
 	<input type="hidden" name="user_admin" value="Y">
	<table align="center" width="400" border="1" cellspacing="0" cellpadding="5">
		<tr><th>관리자 비밀번호 입력 </th><td><input type="password" id="managerPwd"></td></tr> 
		<tr><td colspan="2">
			<input id ="s1" class="btn" type="submit" value="확인" style="float:left">
			<input class="btn" type="reset" value="닫기" onclick="window.close();" style="float:right">
			</td>
	</table>
	</form>
</body>
</html> 