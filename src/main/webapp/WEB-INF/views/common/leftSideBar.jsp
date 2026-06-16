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
	function openEvalModal(btn) {
		
		// 폼에 요청할 데이터 가져오기
		const detailId = btn.getAttribute('data-detail-id');
    	const targetId = btn.getAttribute('data-target-id');
		const targetNick = btn.getAttribute('data-target-nick');
		const cafeName = btn.getAttribute('data-cafe-name');
		const roomName = btn.getAttribute('data-room-name');
		
		// 히든 button에 id 값 설정
		document.getElementById('hiddenDetailId').value = detailId;
	    document.getElementById('hiddenTargetId').value = targetId;
		
		document.getElementById('md-mutual-target').innerText = targetNick;
		document.getElementById('md-mutual-cafe').innerText = cafeName;
		document.getElementById('md-mutual-theme').innerText = roomName;
		
		
	    let evalModal = new bootstrap.Modal(document.getElementById('evaluationModal'));
	    evalModal.show();
	}
	
	
	
	function submitEvaluation() {
		
		// form 데이터 가져오기		
		const form = document.getElementById('evaluationForm');
		const formData = new FormData(form);
		

		// json 형태로 컨트롤러로 넘길 데이터
		const evaluationData = {
			detailId: document.getElementById('hiddenDetailId').value,
		    targetId: document.getElementById('hiddenTargetId').value,
		    writerId: ${USER.userId},
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
			
			return response.text(); // 컨트롤러에서 return String
		})
		.then(result => {
			
			if(result === "success"){
				
				// DB INSERT 성공 후 처리
				alert("상호 평가가 정상적으로 등록되었습니다.");
				
				// 모달 창 닫기
				let evalModalEl = document.getElementById('evaluationModal');
				let evalModal = bootstrap.Modal.getInstance(evalModalEl);
				evalModal.hide();
				
				// 상호 평가 후 페이지 새로고침
				location.reload();
			}
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

			<div class="ne-sc-title">
				마이페이지
			</div>
		</div>
		
		<div class="ne-side-nav-section">마이 메뉴</div>
		<a href="/mypage/record" id="record" class="${fn:contains(pageContext.request.requestURI, '/record') ? 'active' : ''}">개인 기록</a>
		<a href="/mypage/myparty" id="party" class="${fn:contains(pageContext.request.requestURI, '/myparty') ? 'active' : ''}">매칭 목록</a>
		<a href="/mypage/reservations" id="reservations" class="${fn:contains(pageContext.request.requestURI, '/reservations') ? 'active' : ''}">예약 내역</a>
		<a href="/mypage/cafe/enroll" id="reservations" class="${fn:contains(pageContext.request.requestURI, '/enroll') ? 'active' : ''}">카페 등록</a>
		<a href="/mypage/cafe/drop" class="${fn:contains(pageContext.request.requestURI, '/cafe/drop') ? 'active' : ''}">카페 삭제</a>
		<a href="/user/withdraw">회원 탈퇴</a>
	</nav>
	
	<!-- 상호평가 섹션 -->
	<div class="ne-sc m-0">
		<div class="ne-sc-title mb-2">현재 미진행 상호평가</div>
		
		<div class="d-flex flex-column gap-3 mt-2">
			<c:choose>
				<c:when test="${not empty mutualList}">
					<c:forEach var="mutual" items="${mutualList}">
						<div class="d-flex justify-content-between align-items-center p-2 border-bottom">
							<div>
								<span class="fw-bold d-block" style="font-size: 14px;">${mutual.targetNickName}</span>
								<span class="text-muted text-xs d-block">${mutual.cafeName}</span>
								<span class="text-muted text-xxs d-block">${mutual.roomName}</span>
							</div>
							<div>
								<button class="btn btn-sm btn-outline-primary" style="font-size: 12px; padding: 4px 10px;"
									onclick="openEvalModal(this);" 
									data-detail-id="${mutual.detailId}"
									data-target-id="${mutual.targetId}"
									data-target-nick="${mutual.targetNickName}"
									data-cafe-name="${mutual.cafeName}"
									data-room-name="${mutual.roomName}">
									평가하기
								</button>
							</div>
						</div>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<div class="text-center py-3 text-muted">
						<span class="fw-bold d-block" style="font-size: 14px;">평가할 유저가 없습니다</span>
					</div>
				</c:otherwise>
			</c:choose>	
		</div>
	</div><!-- 상호 평가 섹션 -->
	
		
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
						<span>평가 대상 파티원: </span><strong id="md-mutual-target"></strong>
						<br>
						<span>매장 / 테마: </span><strong  id="md-mutual-cafe"></strong> - <strong  id="md-mutual-theme"></strong>
					</div>
	
					<form id="evaluationForm" >
						<input type="hidden" id="hiddenDetailId" name="detailId">
    					<input type="hidden" id="hiddenTargetId" name="targetId">
							<div class="mb-3">
								<p class="fw-bold mb-2">1. ${questionList[0]}</p>
								<div class="d-flex gap-4">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="answer1" id="a1good" value="1" checked>
										<label class="form-check-label" for="a1good">네</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="answer1" id="a1bad" value="2">
										<label class="form-check-label" for="a1bad">아니요</label>
									</div>
								</div>
							</div>
	
						<div class="mb-3">
							<p class="fw-bold mb-2">2. ${questionList[1]}</p>
							<div class="d-flex gap-4">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="answer2" id="a2good" value="1" checked>
									<label class="form-check-label" for="a2good">네</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="answer2" id="a2bad" value="2">
									<label class="form-check-label" for="a2bad">아니요</label>
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