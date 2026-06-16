<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href='${pageContext.request.contextPath }/dist/css/common.css'>
<style type="text/css">
.mainNav{
	font-size: 22px;
	font-weight: bold;
	height: 100%;
	width: 450px;
}
.subNav{
	position: relative;
	font-size: 18px;
	top: 0px;
}
.nickname{
	position: absolute;
	top: -20px;
	right: 40px;
	font-size: 14px;
	color: #333;
	width: 200px;
	text-align: right;
}
</style>
</head>
<body>
	<header>
		<div class="ne-header d-flex justify-content-between align-items-center">
			<div class="logo">
				<h1 class="m-0">
					<a href="${pageContext.request.contextPath }/" class="no-hover">
						<img src="${pageContext.request.contextPath }/dist/images/logo2.png" alt="로고이미지" style="height: 80px;" />
					</a>
				</h1>
			</div>
			<div class="nav-right d-flex mainNav justify-content-between align-items-center">
				<ul class="d-flex m-0 gap-3">
					<li><a href="${pageContext.request.contextPath }/party/list">PARTY</a></li>
					<li><a href="${pageContext.request.contextPath }/theme/list">THEME</a></li>
				</ul>
				<ul class="d-flex m-0 gap-3 subNav">
					<c:if test="${not empty sessionScope.loginUser && sessionScope.role == 'OWNER'}">
						<li><a href="${pageContext.request.contextPath }/owner/openRes">테마관리</a></li>
					</c:if>
					<c:if test="${not empty sessionScope.loginUser && sessionScope.role == 'MANAGER'}">
						<li><a href="${pageContext.request.contextPath }/owner/attendance">출석체크</a></li>
					</c:if>
					
					<c:choose>
						<c:when test="${not empty sessionScope.loginAdmin}">
							<li><span>${sessionScope.loginAdmin.loginId}(관리자)</span></li>
							<li><a href="${pageContext.request.contextPath}/admin/dashboard">관리</a></li>
							<li><a href="${pageContext.request.contextPath}/admin/logout">로그아웃</a></li>
						</c:when>
						<c:when test="${not empty sessionScope.loginUser}">
							<li><a href="${pageContext.request.contextPath }/mypage/record">MYPAGE</a></li>
							<li class="nickname" ><span>${sessionScope.loginUser.nickname}님</span></li>
						<%-- 	<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li> --%>
							<li><a href="${pageContext.request.contextPath}/user/logout">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0z"/>
  <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
</svg></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/user/login">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
								  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
								  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
								</svg>
							</a></li>
		<%-- 					<li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
							<li><a href="${pageContext.request.contextPath}/user/enroll">회원가입</a></li> --%>
						</c:otherwise>
					</c:choose>								
				</ul>
			</div>
		
		</div>
	</header>



</body>
</html>