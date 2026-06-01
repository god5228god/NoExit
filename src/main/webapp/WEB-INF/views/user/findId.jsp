<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<%@ taglib prefix = "fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		//인증번호 발송 요청
		$("#emailBtn").click(function(){
			let name = $("#name").val().trim();
			let email = $("#email").val().trim();
					
			if (name == "" || email == "") {
				alert("이름과 이메일을 먼저 입력해주세요.");
				return;
			}
			
			$.post("findIdAuth.action", {
				name : name,
				email : email
			}, function(data) {
				// 성공 시 인증번호 입력란 노출
				$("#resultMsg").html("인증번호가 발송되었습니다.").css("color", "blue");
				$("#authCodeArea").show(); 
				$("#emailBtn").text("재발송");
			}).fail(function() {
				alert("인증번호 발송 실패. 다시 시도해주세요.");
			});
		});
		
		//인증번호 확인 버튼 클릭 (여기서 바로 아이디 조회)
		$("#verifyBtn").click(function(){
			let name = $("#name").val().trim();
			let email = $("#email").val().trim();
			let authCode = $("#authCode").val().trim();
			
			if (authCode == "") {
				alert("인증번호를 입력해주세요.");
				return;
			}
			
			// 인증번호 확인 및 아이디 조회
			$.post("${pageContext.request.contextPath}/user/findByIdAjax", {
				name : name,
				email : email,
				authCode : authCode
			}, function(data) {
				
				//{ "status": "success", "userId": "user1234" }				
				if(data.status === "success") {
					let resultHtml = "<div style='border:1px solid #ccc; padding:15px; margin-top:20px; text-align:center;'>";
					resultHtml += "고객님의 아이디는 <strong>" + data.userId + "</strong> 입니다.";
					resultHtml += "</div>";
					// 폼은 숨기고
					$("#findIdForm").hide();
					// 결과 보여주기
					$("#finalResult").html(resultHtml).show(); 
				} else {
					$("#resultMsg").html(data.message).css("color", "red");
				}
			}, "json").fail(function() {
				alert("조회 중 오류가 발생했습니다.");
			});
		});
			
	}); 

</script>
</head>
<body>

<div style="width: 400px; margin: 0 auto;"> 
    <h2>아이디 찾기</h2>
    <p>가입 시 등록한 이름과 이메일을 입력해주세요.</p>

    <!-- 결과가 출력될 영역 -->
    <div id="finalResult" style="display:none;"></div>

	<form id="findIdForm">
		<div class="input-group">
			<label for="name">이름</label><br>
			<input type="text" id="name" name="name" placeholder="이름 입력">
		</div>
		
		<div class="input-group" style="margin-top:10px;">
			<label for="email">이메일</label><br>
			<input type="email" id="email" name="email" placeholder="이메일 입력">
			<button type="button" id="emailBtn">인증요청</button>
		</div>
		
		<!-- 인증번호 입력란 (평소에는 숨김) -->
		<div id="authCodeArea" style="display: none;">
			<label for="authCode">인증번호 확인</label><br>
			<input type="text" id="authCode" placeholder="6자리 숫자">
			<button type="button" id="verifyBtn">아이디 조회</button>
		</div>
		
		<div id="resultMsg" style="margin-top: 10px;"></div>
	</form>
</div>

</body>
</html>