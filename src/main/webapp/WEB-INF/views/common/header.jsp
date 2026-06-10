<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
	header{
		width: 100%;
		height: 100px;
	}
</style>
</head>
<body>
	<header class="ne-header d-flex justify-content-around align-items-center bg-white shadow-sm">
		<div class="nav-left">
			<ul class="d-flex m-0 gap-3">
				<li><a href="${pageContext.request.contextPath }/party/list" >파티</a></li>
				<li><a href="${pageContext.request.contextPath }/theme/list">테마</a></li>
			</ul>
		</div>
		<div class="logo">
			<h1 class="m-0">
				<a href="${pageContext.request.contextPath }/" class="no-hover">
					<img src="${pageContext.request.contextPath }/dist/images/logo.png" alt="로고이미지" style="height: 40px;" />
				</a>
			</h1>
		</div>
		<div class="nav-right">
			<ul class="d-flex m-0 gap-3">
				<c:if test="${role == 'OWNER'}">
					<li><a href="${pageContext.request.contextPath }/owner/openRes">테마관리</a></li>
				</c:if>
				<c:if test="${role == 'MANAGER'}">
					<li><a href="${pageContext.request.contextPath }/owner/attendance">출석체크</a></li>
				</c:if>
				
				<c:choose>
					<c:when test="${not empty sessionScope.loginAdmin}">
						<li><span>${sessionScope.loginAdmin.loginId}(관리자)</span></li>
						<li><a href="${pageContext.request.contextPath}/admin/dashboard">관리</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/logout">로그아웃</a></li>
					</c:when>
					<c:when test="${not empty sessionScope.loginUser}">
						<li><a href="${pageContext.request.contextPath }/mypage/record">마이페이지</a></li>
						<li><span>${sessionScope.loginUser.nickname}님</span></li>
						<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
						<li><a href="${pageContext.request.contextPath}/user/enroll">회원가입</a></li>
					</c:otherwise>
				</c:choose>								
			</ul>
		</div>
	</header>



</body>
</html>