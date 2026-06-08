<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
/* 왼쪽 사이드바 고정틀 유지 */
.left-sidebar-wrapper {
	width: 280px;
	flex-shrink: 0;
}
.ne-side-profile {
	text-align: center;
	padding: 1.5rem 1rem;
}
.ne-side-profile img {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 1rem;
}
</style>
<script type="text/javascript">

	// 상호평가 모달 오픈 함수
	function openEvalModal() {
	    let evalModal = new bootstrap.Modal(document.getElementById('evaluationModal'));
	    evalModal.show();
	}
	
	
	
	function submitEvaluation() {
			
		// form 데이터 가져오기		
		const form = document.getElementById('evaluationForm');
		const formData = new FormData(form);
		
		// ※ 실제 서비스 시 평가 대상자(targetUserNo) 등도 같이 보낼 수 있도록 구조화합니다.
		const evaluationData = {
			q1Answer: formData.get('answer1'),
			q2Answer: formData.get('answer2')
		};
		
		// /mypage/evaluation/write 로 요청 전송
		fetch(`${pageContext.request.contextPath}/mypage/evaluation/write`, {
			
			method: 'POST',                     // POST 방식 명시
			headers: {
				'Content-Type': 'application/json' // 보낼 데이터 형태(json) 명시
			},
			
			body: JSON.stringify(evaluationData)   // key value 객체 evaluationData
		})
		.then(response => {
			
			// 예외 처리
			if(!response.ok) throw new Error("서버 처리 실패");
			
			return response.text(); // 컨트롤러에서 return String 예정
		})
		.then(result => {
			
			// DB INSERT 성공 후 처리
			alert("상호 평가가 정상적으로 등록되었습니다.");
			
			// 모달 창 닫기
			let evalModalEl = document.getElementById('evaluationModal');
			let evalModal = bootstrap.Modal.getInstance(evalModalEl);
			evalModal.hide();
			
			// 상호 평가 후 페이지 새로고침
			location.reload();
		})
		.catch(error => {
			console.error("평가 등록 에러:", error);
			alert("평가 등록 중 오류가 발생했습니다.");
		});
	}

</script>
</head>
<body>

<div class="left-sidebar-wrapper">
	<nav class="ne-side-nav">
		<div class="ne-side-profile">
			<img src="${pageContext.request.contextPath}/dist/images/zazaz.jpg" alt="프로필">
			<div id="nickName" class="fw-bold mb-2" style="font-size: 20px;">닉네임 바인딩</div>
			<div class="text-muted small">
			</div>
		</div>
		
		<div class="ne-side-nav-section">마이 메뉴</div>
		<a href="/mypage/record" id="record" class="${fn:contains(pageContext.request.requestURI, '/record') ? 'active' : ''}">개인 기록</a>
		<a href="/mypage/party" id="party" class="${fn:contains(pageContext.request.requestURI, '/party') ? 'active' : ''}">매칭 목록</a>
		<a href="/mypage/reservations" id="reservations" class="${fn:contains(pageContext.request.requestURI, '/reservations') ? 'active' : ''}">예약 내역</a>
		<a href="/mypage/cafe/enroll" id="reservations" class="${fn:contains(pageContext.request.requestURI, '/enroll') ? 'active' : ''}">카페 등록</a>
	</nav>
	
	<!-- 상호평가 섹션 -->
	<div class="ne-sc m-0">
		<div class="ne-sc-title">현재 미진행 상호평가</div>
		<div class="d-flex flex-column gap-3 mt-2">
			<div class="d-flex justify-content-between align-items-center">
				<div>
					<span class="fw-bold d-block" style="font-size: 14px;">파티원 닉네임 바인딩</span>
					<span class="text-muted text-xs">매장이름 바인딩</span>
					<div>
						<span class="text-muted text-xxs">테마 바인딩</span>
					</div>
					
				</div>
				<button class="btn btn-sm btn-outline-primary" onclick="openEvalModal();"style="font-size: 12px; padding: 4px 10px;">
					 평가하기
        		</button>
        		
			</div>
		</div>
	</div>
	
		
	<!-- 상호 평가 모달 (DB INSERT 후 TEST) -->
	<div class="modal fade" id="evaluationModal">
		<div class="modal-dialog modal-dialog-centered"> 
			<div class="modal-content">
				<div class="modal-header py-2">
					<h6 class="modal-title fw-bold" id="evaluationModalLabel">파티원 상호 평가</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" style="font-size: 12px;"></button>
				</div>
				
				<!-- 모달 -->
				<div class="modal-body" style="font-size: 13px;">
					<div class="mb-3">
						<span>평가 대상 파티원: </span><strong>파티원 닉네임 바인딩</strong>
						<br>
						<span>매장 / 테마: </span><strong>매장바인딩 - 테마바인딩</strong>
					</div>
	
					<form id="evaluationForm">
						<div class="mb-3">
							<p class="fw-bold mb-2">1. 평가항목 바인딩</p>
							<div class="d-flex gap-4">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="answer1" id="a1good" value="1" checked>
									<label class="form-check-label" for="a1good">평가요소 바인딩</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="answer1" id="a1bad" value="2">
									<label class="form-check-label" for="a1bad">평가요소 바인딩</label>
								</div>
							</div>
						</div>
	
						<div class="mb-3">
							<p class="fw-bold mb-2">2. 평가항목 바인딩</p>
							<div class="d-flex gap-4">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="answer2" id="a2good" value="1" checked>
									<label class="form-check-label" for="a2good">평가요소 바인딩</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="answer2" id="a2bad" value="2">
									<label class="form-check-label" for="a2bad">평가요소 바인딩</label>
								</div>
							</div>
						</div>
	
					</form>
				</div>
				
				<!-- 모달 하단 버튼 -->
				<div class="modal-footer py-2">
					<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-sm btn-primary" onclick="submitEvaluation()">평가 완료</button>
				</div>
				
			</div>
		</div>
	</div><!-- 상호 평가 모달 -->
	
	
</div>
</body>
</html>