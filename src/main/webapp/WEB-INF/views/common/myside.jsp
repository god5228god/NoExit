<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">

<link rel="stylesheet" type="text/css"
	href='${pageContext.request.contextPath }/dist/css/common.css'>

<style type="text/css">
nav {
	margin-top: 120px;
	width: 300px;
	text-align: center;
	margin-bottom: 300px;
}

nav li {
	text-align: center;
	padding-bottom: 30px;
}

#nickName {
	font-size: 25px;
}

body{
	height: 101vh;

}

</style>
</head>
<body>

	<!-- 마이페이지에 들어갈 사이드바 -->
	<nav class="ne-side-nav">

		<img src="${pageContex.request.contextPath }/dist/images/zazaz.jpg"><br>
		<div id="nickName">미쿠쨩다이스키데스스</div>
		<div>
			<h5>
				어서와!<br>
			</h5>
			<h6>오늘도 좋은 추억 만들자.</h6>
		</div>
		<br><br>
		<ul>
			<li><a href="/mypage/reservations" id="record" class="active"
				style="text-align: center;">개인 기록</a></li>
			<li>매칭 목록</li>
			<li>예약 내역</li>
			<li><a href="/" id="home" class="" style="text-align: center;">홈으로</a></li>
		</ul>
	</nav>

</body>
</html>