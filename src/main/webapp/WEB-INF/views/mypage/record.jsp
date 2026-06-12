<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>record.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">

<style type="text/css">
	.main-body {
		display: flex;                		
		width: 100%;
		box-sizing: border-box;
		padding-left: 2rem;
		padding-right: 2rem;
		gap: 1.5rem;
		align-items: stretch;
	}

	.main-content {
		flex-grow: 1;
		min-width: 0;
		display: flex;
    	flex-direction: column;
	}
	
	.right-sidebar {
		width: 340px;                    
		flex-shrink: 0;                  
		display: flex;
		flex-direction: column;
	}
	
	.record-item-body {
		display: flex;
		gap: 1.5rem;
		align-items: center;
	}
	
	.clickable-card {
		cursor: pointer;
		transition: transform 0.2s, box-shadow 0.2s;
	}
	.clickable-card:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(0,0,0,0.08);
	}
	
	.ne-sc-title {
		display: flex;
		justify-content: space-between;
	}
	
	.pagination-wrapper {
    margin-top: auto;
    padding-top: 2rem;
</style>

<script type="text/javascript">

	// 등록된 개인 기록 상세 보기 모달 띄우기
	function openRecordDetail(cardElement) {
		
		// 상세 보기때는 Mode를 false로 초기화
		switchRecordMode(false);
		
		// 클릭된 카드 태그에 숨겨져 있는 data- 속성 정보들 추출
		const themeTitle = cardElement.getAttribute('data-theme-title');
		const playDate = cardElement.getAttribute('data-play-date');
		const playTime = cardElement.getAttribute('data-play-time');
		const hintCount = cardElement.getAttribute('data-hint-count');
		const playerCount = cardElement.getAttribute('data-player-count');
		const isEscaped = cardElement.getAttribute('data-is-escaped');
		const recordComment = cardElement.getAttribute('data-memo');
		
		// 모달 내부 HTML 태그 ID 기준으로 데이터 바인딩
		document.getElementById('md-record-theme').innerText = themeTitle;
		document.getElementById('md-record-date').innerText = playDate;
		document.getElementById('md-record-time').innerText = playTime;
		document.getElementById('md-record-hint').innerText = hintCount + "개";
		document.getElementById('md-record-players').innerText = playerCount + "명";
		document.getElementById('md-record-memo').innerText = recordComment ? recordComment : "등록된 메모가 없습니다.";
		
		// Escaped 여부에 따른 상태 뱃지 렌더링
		const statusBadge = document.getElementById('md-record-status');
		
		if(isEscaped === "1") {
			statusBadge.innerText = "성공";
			statusBadge.className = "ne-st ne-st-amber"; 
		} else {
			statusBadge.innerText = "실패";
			statusBadge.className = "ne-st ne-st-red"; 
		}
		
		// 세팅 완료된 모달 띄우기
		let myModal = new bootstrap.Modal(document.getElementById('recordDetailModal'));
		myModal.show();
	}
	
	// 기록 추가 버튼 클릭 시 미등록 리스트 비동기 조회 후 모달 오픈
	function insertRecordModal() {
		fetch(`${pageContext.request.contextPath}/mypage/record/write`)
		.then(response => {
			if (!response.ok) {
				throw new Error("네트워크 응답 표준 에러 발생");
			}
			return response.json(); 
		})
		.then(list => {
			const selectEl = document.getElementById('unrecordedSelect');
			
			selectEl.innerHTML = '<option value="" selected disabled>기록을 등록할 플레이를 선택하세요.</option>';
			
			if (!list || list.length === 0) {
				alert("기록을 추가할 미등록 플레이 내역이 없습니다.");
				return;
			}
			
			list.forEach(item => {
				const option = document.createElement('option');
				option.value = item.detailId; 
				option.innerText = `[\${item.cafeName}] \${item.roomName} (\${item.playDate})`;
				selectEl.appendChild(option);
			});
			
			let insertModal = new bootstrap.Modal(document.getElementById('insertRecordModal'));
			insertModal.show();
		})
		.catch(error => {
			console.error("AJAX 통신 중 치명적 에러 발생:", error);
			alert("내역을 불러오는 도중 오류가 발생했습니다. 브라우저 콘솔(F12)을 확인해 주세요.");
		});
	}
	
	// 3. 모달 내에서 [기록 추가 완료] 버튼 클릭 시 데이터 서버 전송
	function submitRecordInsert() {
		const selectEl = document.getElementById('unrecordedSelect');
		if(!selectEl.value) {
			alert("기록할 플레이 내역을 선택해 주세요.");
			selectEl.focus();
			return;
		}
		
		const playTimeEl = document.getElementById('insPlayTime');
		const rawPlayTime = playTimeEl.value.trim();
		if(!rawPlayTime || isNaN(rawPlayTime)) {
			alert("소요 시간을 숫자(분) 형식으로 정확히 입력해 주세요. (예: 52)");
			playTimeEl.focus();
			return;
		}

		const form = document.getElementById('recordInsertForm');
		const formData = new FormData(form);
		
		const recordData = {
			detailId: parseInt(formData.get('detailId'), 10),
			isEscaped: parseInt(formData.get('isEscaped'), 10),
			playTime: parseInt(rawPlayTime, 10),
			hintCount: parseInt(formData.get('hintCount'), 10),
			peopleCount: parseInt(formData.get('peopleCount'), 10),
			recordComment: formData.get('recordComment')
		};
		
		fetch(`${pageContext.request.contextPath}/mypage/record/write`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(recordData)
		})
		.then(response => {
			if(!response.ok) throw new Error("서버 처리 실패");
			return response.text();
		})
		.then(result => {
			if(result === "success") {
				alert("새로운 플레이 기록이 정상적으로 등록되었습니다.");
				
				let insertModalEl = document.getElementById('insertRecordModal');
				let insertModal = bootstrap.Modal.getInstance(insertModalEl);
				insertModal.hide();
				
				location.href = "${pageContext.request.contextPath}/mypage/record?page=1";
			} else {
				alert("기록 등록에 실패했습니다. 입력값을 확인해주세요.");
			}
		})
		.catch(error => {
			console.error("기록 등록 에러:", error);
			alert("기록 등록 중 오류가 발생했습니다.");
		});
	}
	
	// 1. [수정하기] 버튼 누르면 바로 수정 폼 모달 열기
	function updateRecordModal(event, cardElement) {
		// 부모 카드가 같이 클릭되어 상세 모달이 열리는 현상(버블링) 차단
		if(event) event.stopPropagation();
		
		// 카드에 숨겨진 기존 데이터들 싹 추출하기
		const detailId = cardElement.getAttribute('data-detail-id') || "0"; 
		const themeTitle = cardElement.getAttribute('data-theme-title');
		const playDate = cardElement.getAttribute('data-play-date');
		const playTime = cardElement.getAttribute('data-play-time');
		const hintCount = cardElement.getAttribute('data-hint-count');
		const playerCount = cardElement.getAttribute('data-player-count');
		const isEscaped = cardElement.getAttribute('data-is-escaped');
		const recordComment = cardElement.getAttribute('data-memo');
		
		// 모달의 input, textarea 태그들에 기존 값 대입하기
		document.getElementById('md-record-detailId').value = detailId;
		document.getElementById('md-record-theme').innerText = themeTitle;
		document.getElementById('md-record-date').innerText = playDate;
		
		document.getElementById('mdEditPlayTime').value = playTime;
		document.getElementById('mdEditHintCount').value = hintCount;
		document.getElementById('mdEditPlayerCount').value = playerCount;
		document.getElementById('mdEditRecordComment').value = recordComment ? recordComment : "";
		
		// 성공/실패 라디오 버튼 체크
		if(isEscaped === "1") {
			document.getElementById('mdEditEscape').checked = true;
		} else {
			document.getElementById('mdEditFail').checked = true;
		}
		
		// 모달이 열릴 때 무조건 '수정 폼(true)'이 보이도록 설정
		switchRecordMode(true);
		
		// 모달 띄우기
		let myModal = new bootstrap.Modal(document.getElementById('recordDetailModal'));
		myModal.show();
	}
	
	// 2. 모달 안의 UI를 조회 모드(false) / 수정 모드(true)로 스위칭하는 함수
	function switchRecordMode(isEditMode) {
		if(isEditMode) {
			document.getElementById('md-view-form').classList.add('d-none');
			document.getElementById('md-edit-form').classList.remove('d-none');
			document.getElementById('md-view-footer').classList.add('d-none');
			document.getElementById('md-edit-footer').classList.remove('d-none');
		} else {
			document.getElementById('md-view-form').classList.remove('d-none');
			document.getElementById('md-edit-form').classList.add('d-none');
			document.getElementById('md-view-footer').classList.remove('d-none');
			document.getElementById('md-edit-footer').classList.add('d-none');
		}
	}

	// 3. 수정 완료 버튼 누르면 서버(컨트롤러)로 비동기 전송할 함수
	function submitRecordUpdate() {
		const playTimeEl = document.getElementById('mdEditPlayTime');
		const rawPlayTime = playTimeEl.value.trim();
		
		// 유효성 검사 (분 단위 숫자만)
		if(!rawPlayTime || isNaN(rawPlayTime)) {
			alert("소요 시간을 숫자(분) 형식으로 정확히 입력해 주세요. (예: 52)");
			playTimeEl.focus();
			return;
		}

		// 서버로 보낼 JSON 데이터 묶기
		const updateData = {
			detailId: parseInt(document.getElementById('md-record-detailId').value, 10),
			isEscaped: parseInt(document.querySelector('input[name="mdIsEscaped"]:checked').value, 10),
			playTime: parseInt(rawPlayTime, 10),
			hintCount: parseInt(document.getElementById('mdEditHintCount').value, 10),
			peopleCount: parseInt(document.getElementById('mdEditPlayerCount').value, 10),
			recordComment: document.getElementById('mdEditRecordComment').value
		};

		// Fetch를 이용한 비동기 통신
		fetch(`${pageContext.request.contextPath}/mypage/record/update`, {
			method: 'POST', // 프로젝트 컨벤션에 맞춰 PUT 대신 POST 사용
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(updateData)
		})
		.then(response => {
			if(!response.ok) throw new Error("서버 처리 실패");
			return response.text();
		})
		.then(result => {
			if(result === "success") {
				alert("플레이 기록이 성공적으로 수정되었습니다.");
				location.reload(); // 화면 새로고침하여 반영
			} else {
				alert("기록 수정에 실패했습니다. 입력값을 확인해주세요.");
			}
		})
		.catch(error => {
			console.error("기록 수정 에러:", error);
			alert("기록 수정 중 오류가 발생했습니다.");
		});
	}
	
	
	
	
	
</script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="main-body ne-body-offset">
	
	<%@ include file="/WEB-INF/views/common/leftSideBar.jsp" %>

	<div class="main-content">
	
		<div class="ne-sc">
			<div class="ne-sc-title" style="font-size: 24px;">
				<span>개인 기록</span>
			 	<span class="btn btn-outline-primary" onclick="insertRecordModal()">기록 추가</span>
			 </div>
			
			
			<!-- 더미 기록 카드 데이터 -->
			 
			<div class="ne-card ne-card-accent p-4 mb-3 clickable-card" onclick="openRecordDetail(this)"
				 data-theme-title="비밀의 숲"
				 data-play-date="2024.05.17 (금) 14:00"
				 data-play-time="52:18"
				 data-hint-count="2"
				 data-player-count="3"
				 data-is-escaped="1"
				 data-memo="방탈출 친구들과 갔는데 인테리어가 정말 대박이었음!">
				 
				<div class="record-item-body justify-content-between">
					<div class="d-flex align-items-center gap-3">
						<div class="ne-room-img" style="width: 80px; height: 80px; flex-shrink: 0; border-radius: var(--ne-radius-md);">
							<img src="/dist/images/miku.jpg" style="width: 100%; height: 100%; object-fit : contain">
						</div>
						<div>
							<h4 class="m-0 mb-1 fw-bold" style="font-size: 18px;">비밀의 숲</h4>
							<p class="m-0 text-secondary small">2024.05.17 (금) 14:00</p>
						</div>
					</div>
					
					<div class="d-flex align-items-center gap-3">
						<div>
							<span class="ne-st ne-st-amber">성공</span>
						</div>
					</div>
				</div>
			</div>
			
			<c:choose>
				<c:when test="${not empty recordList}">
					<c:forEach var="record" items="${recordList}">
						
						<div class="ne-card ne-card-accent .clickable-card p-4 mb-3 " 
							 onclick="openRecordDetail(this)"
							 data-theme-title="${record.roomName}"
							 data-play-date="${record.playDate}"
							 data-play-time="${record.playTime}"
							 data-hint-count="${record.hintCount}"
							 data-player-count="${record.peopleCount}"
							 data-is-escaped="${record.isEscaped}"
							 data-memo="${record.recordComment}">
							 
							<div class="record-item-body justify-content-between">
							
								<div class="d-flex align-items-center gap-3">
									<div class="ne-room-img" style="width: 80px; height: 80px; flex-shrink: 0; border-radius: var(--ne-radius-md);">
									</div>
									<div>
										<h4 class="m-0 mb-1 fw-bold" style="font-size: 18px;">${record.roomName}</h4>
										<p class="m-0 text-secondary small">${record.playDate}</p>
									</div>
								</div>
								
								<div class="d-flex align-items-center gap-3">
									<c:choose>
										<c:when test="${empty record.isEscaped}">
											<div>
												<button type="button" class="btn btn-sm btn-outline-primary px-3 fw-semibold" onclick="insertRecordModal()">기록하기</button>
											</div>
										</c:when>
										
										
										<c:otherwise>
											<div>
												<c:choose>
													<c:when test="${empty review.reviewId}">
														<button type="button" class="btn btn-sm btn-outline-primary px-3 fw-semibold me-2" 
														onclick="updateRecordModal(event, this.closest('.clickable-card'))"
														
														>수정하기</button>
													</c:when>
												</c:choose>
																			
												<c:choose>
													<c:when test="${record.isEscaped == 1}">
														<span class="ne-st ne-st-amber">성공</span>
													</c:when>
													<c:otherwise>
														<span class="ne-st ne-st-red">실패</span>
													</c:otherwise>
												</c:choose>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<div class="text-center py-5 text-secondary">
						현재 플레이 기록이 존재하지 않습니다.
					</div>
				</c:otherwise>
			</c:choose>
			<!-- 여기 -->

			
			<!-- 여기 -->
		</div>
		<div class="d-flex justify-content-center align-items-center gap-3 mt-4">
				
				<c:choose>
					<c:when test="${hasPrev}">
						<a href="${pageContext.request.contextPath}/mypage/record?page=${currentPage - 1}" 
						   class="btn btn-sm btn-outline-secondary px-3 fw-semibold">
							&lt; 이전
						</a>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-sm btn-outline-secondary px-3 fw-semibold" disabled>
							&lt; 이전
						</button>
					</c:otherwise>
				</c:choose>

				<span class="text-secondary small fw-medium">
					<strong class="text-dark">${currentPage}</strong> / ${totalPage}
				</span>

				<c:choose>
					<c:when test="${hasNext}">
						<a href="${pageContext.request.contextPath}/mypage/record?page=${currentPage + 1}" 
						   class="btn btn-sm btn-outline-secondary px-3 fw-semibold">
							다음 &gt;
						</a>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-sm btn-outline-secondary px-3 fw-semibold" disabled>
							다음 &gt;
						</button>
					</c:otherwise>
				</c:choose>
				
			</div>
	</div>

<%@ include file="/WEB-INF/views/common/rightSideBar.jsp" %>

</div>


<div class="modal fade" id="recordDetailModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered"> 
		<div class="modal-content">
		
			<div class="modal-header">
				<h5 class="modal-title" id="md-record-theme">테마 제목</h5>
				<span id="md-record-status" class="ms-3"></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			
			<div class="modal-body p-4" style="font-size: 14px;">
				<input type="hidden" id="md-record-detailId" value="">
				
				<div id="md-view-form">
					<div class="ne-price-box mb-4">
						<div class="ne-price-row">
							<span class="ne-text-muted">최종 소요 시간</span>
							<strong id="md-record-time" class="text-dark"></strong>
						</div>
						<div class="ne-price-row">
							<span class="ne-text-muted">사용 힌트 개수</span>
							<strong id="md-record-hint" class="text-dark"></strong>
						</div>
						<div class="ne-price-row total">
							<span>함께한 인원</span>
							<span id="md-record-players" class="ne-price-total-amount"></span>
						</div>
					</div>
					<div class="mb-3">
						<label class="form-label ne-text-muted">플레이 일시</label>
						<div id="md-record-date" class="p-2 border-bottom text-dark fw-semibold"></div>
					</div>
					<div>
						<label class="form-label ne-text-muted">기록 메모</label>
						<div id="md-record-memo" class="ne-notice ne-notice-warning p-3 text-dark" style="min-height: 80px; white-space: pre-wrap;"></div>
					</div>
				</div>

				<div id="md-edit-form" class="d-none">
					<div class="mb-4">
						<label class="ne-insert-label mb-2 d-block fw-semibold text-secondary">탈출 성공 여부</label>
						<div class="ne-status-toggle-group">
							<input type="radio" class="ne-status-toggle-btn" name="mdIsEscaped" id="mdEditEscape" value="1">
							<label class="ne-status-label" for="mdEditEscape">탈출 성공</label>
							
							<input type="radio" class="ne-status-toggle-btn" name="mdIsEscaped" id="mdEditFail" value="0">
							<label class="ne-status-label" for="mdEditFail">탈출 실패</label>
						</div>
					</div>
					
					<div class="ne-input-grid mb-4" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px;">
						<div>
							<label for="mdEditPlayTime" class="ne-insert-label mb-1 d-block text-secondary">소요 시간</label>
							<input type="text" class="form-control form-control-sm text-center" id="mdEditPlayTime" placeholder="예: 52">
						</div>
						<div>
							<label for="mdEditHintCount" class="ne-insert-label mb-1 d-block text-secondary">힌트 사용</label>
							<div class="input-group input-group-sm">
								<input type="number" class="form-control text-center" id="mdEditHintCount" min="0">
								<span class="input-group-text">개</span>
							</div>
						</div>
						<div>
							<label for="mdEditPlayerCount" class="ne-insert-label mb-1 d-block text-secondary">플레이 인원</label>
							<div class="input-group input-group-sm">
								<input type="number" class="form-control text-center" id="mdEditPlayerCount" min="1">
								<span class="input-group-text">명</span>
							</div>
						</div>
					</div>
					
					<div class="mb-2">
						<label for="mdEditRecordComment" class="ne-insert-label mb-1 d-block text-secondary">기록 메모</label>
						<textarea class="form-control" id="mdEditRecordComment" rows="3" style="font-size: 13px; resize: none;" placeholder="플레이 소감을 수정해 보세요!"></textarea>
					</div>
				</div>
			</div>
			
			<div class="modal-footer py-2" id="md-view-footer">
				<button type="button" class="btn btn-sm btn-outline-primary px-3" onclick="switchRecordMode(true)">수정하기</button>
				<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>

			<div class="modal-footer py-2 d-none" id="md-edit-footer">
				<button type="button" class="btn btn-sm btn-secondary px-3" onclick="switchRecordMode(false)">취소</button>
				<button type="button" class="btn btn-sm btn-primary px-3 fw-semibold" onclick="submitRecordUpdate()">수정 완료</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade ne-record-insert-modal" id="insertRecordModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 460px;"> 
		<div class="modal-content">
		
			<div class="modal-header">
				<h5 class="modal-title">새로운 플레이 기록 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			
			<div class="modal-body p-4" style="font-size: 14px;">
				<form id="recordInsertForm">
					
					<div class="ne-insert-select-box mb-4">
						<label for="unrecordedSelect" class="ne-insert-label mb-2 d-block">기록할 플레이 내역 선택</label>
						<select class="form-select form-select-sm" id="unrecordedSelect" name="detailId" required>
							<option value="" selected disabled>-- 미등록 내역을 선택해 주세요 --</option>
						</select>
					</div>
					
					<div class="mb-4">
						<label class="ne-insert-label mb-2 d-block">탈출 성공 여부</label>
						<div class="ne-status-toggle-group">
							<input type="radio" class="ne-status-toggle-btn" name="isEscaped" id="statusEscape" value="1" checked>
							<label class="ne-status-label" for="statusEscape">탈출 성공</label>
							
							<input type="radio" class="ne-status-toggle-btn" name="isEscaped" id="statusFail" value="0">
							<label class="ne-status-label" for="statusFail">탈출 실패</label>
						</div>
					</div>
					
					<div class="ne-input-grid mb-4">
						<div>
							<label for="insPlayTime" class="ne-insert-label mb-1">소요 시간</label>
							<input type="text" class="form-control form-control-sm text-center" id="insPlayTime" name="playTime" placeholder="분 단위, 예:58" required>
						</div>
						<div>
							<label for="insHintCount" class="ne-insert-label mb-1">힌트 사용</label>
							<div class="input-group input-group-sm">
								<input type="number" class="form-control text-center" id="insHintCount" name="hintCount" min="0" value="0" required>
								<span class="input-group-text">개</span>
							</div>
						</div>
						<div>
							<label for="insPlayerCount" class="ne-insert-label mb-1">플레이 인원</label>
							<div class="input-group input-group-sm">
								<input type="number" class="form-control text-center" id="insPlayerCount" name="peopleCount" min="1" value="2" required>
								<span class="input-group-text">명</span>
							</div>
						</div>
					</div>
					
					<div class="mb-2">
						<label for="insRecordComment" class="ne-insert-label mb-1">기록 메모</label>
						<textarea class="form-control" id="insRecordComment" name="recordComment" rows="3" 
								  style="font-size: 13px; resize: none;" placeholder="인테리어나 플레이 소감을 자유롭게 기록해 보세요!"></textarea>
					</div>

				</form>
			</div>
			
			<div class="modal-footer py-2">
				<button type="button" class="btn btn-sm btn-secondary px-3" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-primary px-3 fw-semibold" onclick="submitRecordInsert()">기록 추가 완료</button>
			</div>
			
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>