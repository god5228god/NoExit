<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<%@ taglib prefix = "fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 및 변경</title>
<style type="text/css">


</style>


<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	/*
	$(function(){
		
		// 인증번호 발송 요청
		$("#authBtn").click(function(){
			let name = $("#name").val().trim();
			let userId = $("#userId").val().trim();
					
			if (name == "" || userId == "") {
				alert("이름과 아이디를 모두 입력해주세요.");
				return;
			}
			
			// 서버로 인증번호 발송 요청 (이름과 아이디로 가입된 회원의 이메일로 발송)
			$.post("findPwAuth.action", {
				name : name,
				userId : userId
			}, function(data) {
				$("#resultMsg").html("인증번호가 발송되었습니다.").css("color", "blue");
				$("#authCodeArea").show(); // 인증번호 입력란 표시
				$("#authBtn").text("재발송");
			}).fail(function() {
				alert("인증번호 발송에 실패했습니다. 입력 정보를 확인해주세요.");
			});
		});
		
		// 인증번호 확인 버튼 클릭 (비밀번호 변경 창 열기)
		$("#verifyBtn").click(function(){
			let name = $("#name").val().trim();
			let userId = $("#userId").val().trim();
			let authCode = $("#authCode").val().trim();
			
			if (authCode == "") {
				alert("인증번호를 입력해주세요.");
				return;
			}
			
			// 인증번호 검증 요청
			$.post("${pageContext.request.contextPath}/user/verifyPwAuthAjax", {
				name : name,
				userId : userId,
				authCode : authCode
			}, function(data) {
				
					$("#resultMsg").html("인증에 성공했습니다. 새 비밀번호를 입력해주세요.").css("color", "green");
					
					// 기존 입력창 및 인증창은 읽기전용(또는 숨김) 처리하고, 비밀번호 변경창 표시
					$("#name").attr("readonly", true);
					$("#userId").attr("readonly", true);
					$("#authCodeArea").hide();
					$("#authBtn").hide();
					
					$("#resetPwArea").show(); // 비밀번호 변경 영역 표시
				} else {
					$("#resultMsg").html(data.message).css("color", "red");
				}
			}, "json").fail(function() {
				alert("인증 확인 중 오류가 발생했습니다.");
			});
		});
		
		// 3. 새 비밀번호 저장 버튼 클릭
		$("#changePwBtn").click(function(){
			let userId = $("#userId").val().trim();
			let newPw = $("#newPw").val().trim();
			let newPwCheck = $("#newPwCheck").val().trim();
			
			if(newPw == "" || newPwCheck == "") {
				alert("비밀번호를 입력해주세요.");
				return;
			}
			
			if(newPw !== newPwCheck) {
				alert("비밀번호가 서로 일치하지 않습니다.");
				return;
			}
			
			// 최종 비밀번호 변경 요청
			$.post("${pageContext.request.contextPath}/user/resetPasswordAjax", {
				userId : userId,
				newPw : newPw
			}, function(data) {
				// 서버 응답 예시: { "status": "success" }
				if(data.status === "success") {
					alert("비밀번호가 성공적으로 변경되었습니다. 로그인 해주세요.");
					location.href = "${pageContext.request.contextPath}/user/login"; // 로그인 페이지로 이동
				} else {
					alert("비밀번호 변경에 실패했습니다: " + data.message);
				}
			}, "json").fail(function() {
				alert("서버 통신 중 오류가 발생했습니다.");
			});
		});
			
	}); 
	*/
</script>
</head>
<body>

<div> 
    <h2>비밀번호 찾기 / 변경</h2>
    <p>가입하신 이름과 아이디를 입력해주세요.</p>

	<form id="findPwForm">
		<div>
			<label for="name">이름</label><br>
			<input type="text" id="name" name="name">
		</div>
		
		<div>
			<label for="userId">아이디</label><br>
			<input type="text" id="userId" name="userId">
			<button type="button" id="authBtn">인증요청</button>
		</div>
		
		<div>
			<label for="authCode">인증번호 입력</label><br>
			<input type="text" id="authCode">
			<button type="button" id="verifyBtn">인증확인</button>
		</div>
		
		<div>
			<div>
				<label for="newPw">새 비밀번호</label><br>
				<input type="password" id="newPw" name="newPw">
			</div>
			<div style="margin-top:10px;">
				<label for="newPwCheck">새 비밀번호 확인</label><br>
				<input type="password" id="newPwCheck">
			</div>
			<div>
				<button type="button" id="changePwBtn" >비밀번호 변경하기</button>
			</div>
		</div>
		
		<div id="resultMsg"></div>
	</form>
</div>

</body>
</html>