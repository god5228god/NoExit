<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">

<script src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(function(){

	$("#findIdBtn").click(function(){
		let name = $("#name").val().trim();
		let email = $("#email").val().trim();

		if (name == "" || email == "") {
			$("#resultMsg").html("이름과 이메일을 모두 입력해주세요.").css("color", "red");
			return;
		}

		$.post("${pageContext.request.contextPath}/user/findId", {
			name : name,
			email : email
		}, function(data) {
			if (data == "SUCCESS") {
				$("#resultMsg").html("입력하신 이메일로 아이디를 보내드렸습니다.").css("color", "blue");
			} else {
				$("#resultMsg").html("일치하는 회원 정보가 없습니다.").css("color", "red");
			}
		}).fail(function() {
			$("#resultMsg").html("서버 통신 중 오류가 발생했습니다.").css("color", "red");
		});
	});
});
</script>
</head>
<body>

<div class="container my-5" style="max-width: 480px;">

	<a href="${pageContext.request.contextPath}/" class="d-block text-center mb-4 text-decoration-none">
		<strong style="font-size: 28px;">Noexit</strong>
	</a>

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">아이디 찾기</div>
		<p class="ne-hint mb-3">가입하신 이름과 이메일을 입력해주세요.</p>

		<form id="findIdForm">

			<div class="mb-3">
				<label for="name" class="form-label">이름</label>
				<input type="text" id="name" name="name" class="form-control" placeholder="이름 입력">
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">이메일</label>
				<input type="email" id="email" name="email" class="form-control" placeholder="가입한 이메일">
			</div>

			<button type="button" id="findIdBtn" class="btn btn-primary w-100">아이디 찾기</button>

			<div class="mt-2 text-center">
				<span id="resultMsg" class="small fw-bold"></span>
			</div>
		</form>
	</div>

	<div class="text-center mt-3 small">
		<a href="${pageContext.request.contextPath}/user/login" class="text-decoration-none text-secondary">로그인</a>
		<span class="mx-2 text-muted">|</span>
		<a href="${pageContext.request.contextPath}/user/enroll" class="text-decoration-none text-secondary">회원가입</a>
		<span class="mx-2 text-muted">|</span>
		<a href="${pageContext.request.contextPath}/user/findPw" class="text-decoration-none text-secondary">비밀번호 찾기</a>
	</div>

</div>

</body>
</html>
