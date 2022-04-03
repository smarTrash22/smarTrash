<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	a:link { color: black; text-decoration: none;}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<!--  절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/navi.jsp" />
<!-- <table align="center" width="500" border="1" cellspacing="0" cellpadding="5"> -->
<div style="padding-left: 20%; padding-right: 20%; padding-bottom: 10px; padding-top: 10px;">
 <table class="table">
    <thead>
      <tr>
        <th scope="col">${ notice.notice_no } &nbsp; ${ notice.notice_title }<br></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="font-size: 10px;">${ notice.notice_writer } | <fmt:formatDate value="${ notice.notice_date}" type="date" pattern="yyyy-MM-dd HH:mm:ss" /></td>
      </tr>
    <tr>
        <td height="500">${ notice.notice_content }</td>
    </tr>
    <tr>
		<td class="table-secondary">
			<c:if test="${ !empty notice.notice_original_filepath }">
				<c:url var="nfd" value="/nfiledown.do">
					<c:param name="ofile" value="${ notice.notice_original_filepath }" />
					<c:param name="rfile" value="${ notice.notice_rename_filepath }" />
				</c:url>
				<div style="font-size: 10px;"><i class="bi bi-file-earmark-arrow-down"></i>&nbsp;<a href="${ nfd }">${ notice.notice_original_filepath }</a></div>
			</c:if>
			<c:if test="${ empty notice.notice_original_filepath }">
			&nbsp;
		   	<tr class="table-secondary"></tr>
		   	</c:if>
		</td>
	</tr>
    <tr>
      <td><div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-top: 10px;">
         <c:if test="${ loginMember.admin eq 'Y' }">
				<button type="button" class="btn btn-sm btn-primary" disabled onclick="javascript:location.href='movewrite.do';">Write</button>
			</c:if>
			<c:if test="${ loginMember.admin != 'Y' }">
				<button type="button" class="btn btn-sm btn-primary" disabled onclick="javascript:location.href='movewrite.do';">Write</button>
			</c:if>
			<c:if test="${ loginMember.admin eq 'Y' }">
				<button type="button" class="btn btn-sm btn-primary" disabled onclick="javascript:location.href='movedelete.do';">Delete</button>
			</c:if>
			<c:if test="${ loginMember.admin != 'Y' }">
				<button type="button" class="btn btn-sm btn-primary" disabled onclick="javascript:location.href='movedelete.do';">Delete</button>
			</c:if>
			<c:if test="${ loginMember.admin eq 'Y' }">
				<button type="button" class="btn btn-sm btn-primary" disabled onclick="javascript:location.href='moveupdate.do';">Update</button>
			</c:if>
			<c:if test="${ loginMember.admin != 'Y' }">
				<button type="button" class="btn btn-sm btn-primary" disabled onclick="javascript:location.href='moveupdate.do';">Update</button>
			</c:if>
         	<button onclick="javascript:history.go(-1);" class="btn btn-primary" type="button">List</button>
       </div></td>
    </tr>
    </tbody>
  </table>
</div>
<br>
<c:import url="../common/foot.jsp" />
</body>
</html>