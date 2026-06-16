<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container my-5" style="max-width: 480px;">

	<a href="${pageContext.request.contextPath}/" class="d-block text-center mb-4 text-decoration-none">
		<strong style="font-size: 28px;">Noexit</strong>
	</a>

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">회원탈퇴</div>

		<p class="text-muted small mt-2 mb-3">
			탈퇴를 진행하시려면 비밀번호를 입력해주세요.<br>
			탈퇴 후에는 복구할 수 없습니다.
		</p>

		<form action="${pageContext.request.contextPath}/user/withdraw" method="post"
			onsubmit="return confirm('정말 탈퇴하시겠습니까?');">

			<div class="mb-3">
				<label for="password" class="form-label">비밀번호</label>
				<input type="password" id="password" name="password" class="form-control">
				<c:if test="${not empty errorMessage}">
					<div class="text-danger">${errorMessage}</div>
				</c:if>
			</div>

			<button type="submit" class="btn btn-danger w-100">회원탈퇴</button>
		</form>
	</div>

</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
