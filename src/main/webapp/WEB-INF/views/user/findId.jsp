<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">

<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(function(){

	//인증번호 발송 요청
	$("#emailBtn").click(function(){
		let name = $("#name").val().trim();
		let email = $("#email").val().trim();

		if (name == "" || email == "") {
			$("#resultMsg").html("이름과 이메일을 먼저 입력해주세요.").css("color", "red");
			return;
		}

		$.post("findIdAuth.action", {
			name : name,
			email : email
		}, function(data) {
			$("#resultMsg").html("인증번호가 발송되었습니다.").css("color", "blue");
			$("#authCodeArea").show();
			$("#emailBtn").text("재발송");
		}).fail(function() {
			$("#resultMsg").html("인증번호 발송 실패. 다시 시도해주세요.").css("color", "red");
		});
	});

	// 인증번호 확인 + 아이디 조회
	$("#verifyBtn").click(function(){
		let name = $("#name").val().trim();
		let email = $("#email").val().trim();
		let authCode = $("#authCode").val().trim();

		if (authCode == "") {
			$("#resultMsg").html("인증번호를 입력해주세요.").css("color", "red");
			return;
		}

		$.post("${pageContext.request.contextPath}/user/findByIdAjax", {
			name : name,
			email : email,
			authCode : authCode
		}, function(data) {
			if(data.status === "success") {
				
				$("#findIdForm").hide();
				$("#finalResult").html("고객님의 아이디는 <strong>" + data.userId + "</strong> 입니다.").show();
				$("#resultMsg").html(""); 
			} else {
				$("#resultMsg").html(data.message).css("color", "red");
			}
		}, "json").fail(function() {
			$("#resultMsg").html("조회 중 오류가 발생했습니다.").css("color", "red");
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
		<p class="ne-hint mb-3 text-muted small">가입 시 등록한 이름과 이메일을 입력해주세요.</p>

		<div id="finalResult" class="content-box-yellow text-center mb-3 alert alert-warning" style="display:none; padding: 15px;"></div>

		<form id="findIdForm">

			<div class="mb-3">
				<label for="name" class="form-label">이름</label>
				<input type="text" id="name" name="name" class="form-control" placeholder="이름 입력">
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">이메일</label>
				<div class="input-group">
					<input type="email" id="email" name="email" class="form-control" placeholder="이메일 입력">
					<button type="button" id="emailBtn" class="btn btn-outline-primary">인증요청</button>
				</div>
			</div>

			<div class="mb-3" id="authCodeArea" style="display:none;">
				<label for="authCode" class="form-label">인증번호 확인</label>
				<div class="input-group">
					<input type="text" id="authCode" class="form-control" placeholder="6자리 숫자">
					<button type="button" id="verifyBtn" class="btn btn-primary">아이디 조회</button>
				</div>
			</div>

			<div class="text-center mt-2">
				<span id="resultMsg" class="small fw-bold"></span>
			</div>
		</form>
	</div>

	<div class="text-center mt-4 small">
		<a href="${pageContext.request.contextPath}/user/login" class="text-decoration-none text-secondary">로그인</a>
		<span class="mx-2 text-muted">|</span>
		<a href="${pageContext.request.contextPath}/user/enroll" class="text-decoration-none text-secondary">회원가입</a>
		<span class="mx-2 text-muted">|</span>
		<a href="${pageContext.request.contextPath}/user/findPw" class="text-decoration-none text-secondary">비밀번호 찾기</a>
	</div>

</div>

</body>
</html>