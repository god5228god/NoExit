<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">
</head>
<body>

<div class="container my-5" style="max-width: 480px;">

	<a href="${pageContext.request.contextPath}/" class="d-block text-center mb-4 text-decoration-none">
		<strong style="font-size: 28px;">Noexit</strong>
	</a>

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">로그인</div>

		<form action="${pageContext.request.contextPath}/user/login" method="post">

			<div class="mb-3">
				<label for="loginId" class="form-label">아이디</label>
				<input type="text" id="loginId" name="loginId" class="form-control">
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label>
				<input type="password" id="password" name="password" class="form-control">
			</div>

			<button type="submit" class="btn btn-primary w-100">로그인</button>
		</form>
	</div>

	<div class="text-center mt-3 small">
		<a href="${pageContext.request.contextPath}/user/enroll">회원가입</a>
		<span class="mx-2 text-muted">|</span>
		<a href="${pageContext.request.contextPath}/user/findId">아이디 찾기</a>
		<span class="mx-2 text-muted">|</span>
		<a href="${pageContext.request.contextPath}/user/findPw">비밀번호 찾기</a>
	</div>

</div>

</body>
</html>
