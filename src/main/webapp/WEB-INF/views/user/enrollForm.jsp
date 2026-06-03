<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/dist/css/common.css">

<script src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	let isIdChecked = false;

	// 중복확인 버튼
	$("#idChkBtn").click(function(){
		$("#error").css("display", "none");

		let loginId = $("#loginId").val().trim();

		if (loginId === "") {
			$("#error").html("아이디를 입력해주세요.")
			           .css({color: "red", display: "inline"});
			$("#loginId").focus();
			return;
		}
		
		  $("#loginId").on("input", function(){
		      if (isIdChecked) {
		          isIdChecked = false;
		      }
		  });		

		$.ajax({
			type: "POST",
			url: "${pageContext.request.contextPath}/user/id-check",
			data: { loginId: loginId },
			success: function(result){
				if (result === "OK") {
					$("#error").html("사용 가능한 아이디입니다.")
					           .css({color: "blue", display: "inline"});
					isIdChecked = true;
				} else {
					$("#error").html("이미 사용 중인 아이디입니다.")
					           .css({color: "red", display: "inline"});
					$("#loginId").val("").focus();
				}
			},
			error: function(){
				$("#error").html("오류가 발생했습니다.")
				           .css({color: "red", display: "inline"});
			}
		});
	});

	// 회원가입 버튼
	$("#signUpBtn").click(function(){
		$("#error").css("display", "none");

		if (!isIdChecked) {
			$("#error").html("아이디 중복 확인은 필수입니다.")
			           .css({color: "red", display: "inline"});
			$("#idChkBtn").focus();
			return;
		}
		$("#signUpForm").submit();
	});
});
</script>
</head>
<body>

<div class="container my-5" style="max-width: 560px;">

	<a href="${pageContext.request.contextPath}/" class="d-block text-center mb-4 text-decoration-none">
		<strong style="font-size: 28px;">Noexit</strong>
	</a>

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">회원가입</div>

		<form action="${pageContext.request.contextPath}/user/enroll" method="post" id="signUpForm">

			<div class="mb-3">
				<label for="loginId" class="form-label">아이디<span class="form-required">*</span></label>
				<div class="input-group">
					<input type="text" id="loginId" name="loginId" class="form-control" placeholder="6~15자 영문/숫자">
					<button type="button" id="idChkBtn" class="btn btn-outline-primary">중복확인</button>
				</div>
				<span id="error" class="small" style="display: none;"></span>
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">비밀번호<span class="form-required">*</span></label>
				<input type="password" id="password" name="password" class="form-control" placeholder="8자 이상">
			</div>

			<div class="mb-3">
				<label for="nickName" class="form-label">닉네임<span class="form-required">*</span></label>
				<input type="text" id="nickName" name="nickName" class="form-control" placeholder="2~10자">
			</div>

			<div class="mb-3">
				<label for="name" class="form-label">이름<span class="form-required">*</span></label>
				<input type="text" id="name" name="name" class="form-control">
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">이메일<span class="form-required">*</span></label>
				<input type="email" id="email" name="email" class="form-control">
			</div>

			<div class="mb-3">
				<label for="phone" class="form-label">연락처<span class="form-required">*</span></label>
				<input type="text" id="phone" name="phone" class="form-control" maxlength="11" placeholder="하이픈 없이 11자리">
			</div>

			<div class="mb-3">
				<label class="form-label">성별</label>
				<div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="gender" value="M" id="genderM">
						<label class="form-check-label" for="genderM">남</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="gender" value="F" id="genderF">
						<label class="form-check-label" for="genderF">여</label>
					</div>
				</div>
			</div>

			<div class="mb-3">
				<label for="birthDate" class="form-label">생년월일</label>
				<input type="date" id="birthDate" name="birthDate" class="form-control">
			</div>

			<div class="text-end mt-4">
			    <button type="button" id="signUpBtn" class="btn btn-primary">가입하기</button>
				<button type="button" class="btn btn-outline-primary" onclick="history.back()">취소</button>
				
			</div>

		</form>
	</div>


</div>

</body>
</html>
