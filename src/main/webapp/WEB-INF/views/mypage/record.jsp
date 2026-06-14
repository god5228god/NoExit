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
	.main-body { display: flex; width: 100%; box-sizing: border-box; padding-left: 2rem; padding-right: 2rem; gap: 1.5rem; align-items: stretch; }
	.main-content { flex-grow: 1; min-width: 0; display: flex; flex-direction: column; }
	.right-sidebar { width: 340px; flex-shrink: 0; display: flex; flex-direction: column; }
	.record-item-body { display: flex; gap: 1.5rem; align-items: center; }
	.clickable-card { cursor: pointer; transition: transform 0.2s, box-shadow 0.2s; }
	.clickable-card:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
	.ne-sc-title { display: flex; justify-content: space-between; }
	.pagination-wrapper { margin-top: auto; padding-top: 2rem; }
</style>

<script type="text/javascript">

	<%-- 경로 깨짐 방지용 공통 변수 --%>
	const CTX = '${pageContext.request.contextPath}'; 
	
	<%-- 모달끼리 공유할 리뷰 데이터 임시 저장용 --%>
	let currentReviewData = {};

	<%-- 카드 클릭 시 상세보기 모달에 데이터 채우기 --%>
	function openRecordDetail(cardElement) {

		<%-- 무조건 수정창이 아닌 보기창부터 뜨도록 초기화 --%>
		switchRecordMode(false);

		<%-- 카드 태그에 숨겨둔 데이터들 다 가져오기 --%>
		const detailId     = cardElement.getAttribute('data-detail-id');
		const themeTitle   = cardElement.getAttribute('data-theme-title');
		const playDate     = cardElement.getAttribute('data-play-date');
		const playTime     = cardElement.getAttribute('data-play-time');
		const hintCount    = cardElement.getAttribute('data-hint-count');
		const peopleCount  = cardElement.getAttribute('data-people-count');
		const isEscaped    = cardElement.getAttribute('data-is-escaped');
		const recordComment = cardElement.getAttribute('data-memo');

		<%-- 리뷰 모달에서 그대로 쓰게 글로벌 객체에 복사 --%>
		currentReviewData = {
			reviewId      : cardElement.getAttribute('data-review-id'),
			difficulty    : cardElement.getAttribute('data-rv-diff'),
			horror        : cardElement.getAttribute('data-rv-horr'),
			activity      : cardElement.getAttribute('data-rv-act'),
			immersion     : cardElement.getAttribute('data-rv-imm'),
			satisfaction  : cardElement.getAttribute('data-rv-sat'),
			reviewComment : cardElement.getAttribute('data-rv-comment')
		};

		<%-- 일반 보기 모드 화면에 데이터 매핑 --%>
		document.getElementById('md-record-detailId').value    = detailId;
		document.getElementById('md-record-theme').innerText   = themeTitle;
		document.getElementById('md-record-date').innerText    = playDate;
		document.getElementById('md-record-time').innerText    = playTime + "분";
		document.getElementById('md-record-hint').innerText    = hintCount + "개";
		document.getElementById('md-record-players').innerText = peopleCount + "명";
		document.getElementById('md-record-memo').innerText    = recordComment || "등록된 메모가 없습니다.";

		<%-- 수정 모드 켰을 때 인풋창에 미리 채워둘 데이터 --%>
		document.getElementById('mdEditPlayTime').value      = playTime;
		document.getElementById('mdEditHintCount').value     = hintCount;
		document.getElementById('mdEditPlayerCount').value   = peopleCount;
		document.getElementById('mdEditRecordComment').value = recordComment || "";
		
		<%-- 탈출 성공 여부 체크박스 세팅 --%>
		document.getElementById(isEscaped === "1" ? 'mdEditEscape' : 'mdEditFail').checked = true;

		<%-- 성공 실패에 맞게 뱃지 색상 다르게 부여 --%>
		const badge = document.getElementById('md-record-status');
		if (isEscaped === "1") {
			badge.innerText = "성공"; badge.className = "ne-st ne-st-amber";
		} else {
			badge.innerText = "실패"; badge.className = "ne-st ne-st-red";
		}

		new bootstrap.Modal(document.getElementById('recordDetailModal')).show();
	}

	<%-- 리뷰Id 여부 확인 후 등록/수정 모드 전환해서 열기 --%>
	function openReviewModal() {
		const detailId = document.getElementById('md-record-detailId').value;
		if (!detailId) { alert("출석 번호를 식별할 수 없습니다."); return; }

		document.getElementById('md-review-detailId').value = detailId;

		const rid = currentReviewData.reviewId;
		
		<%-- reviewId가 존재하면 작성 이력이 있으므로 수정 모드 --%>
		const isEditMode = rid && rid !== "0" && rid !== "";

		if (isEditMode) {
			<%-- 수정 모드: 기존 별점이랑 코멘트 그대로 세팅 --%>
			document.getElementById('insReviewComment').value = currentReviewData.reviewComment || "";
			document.getElementById('diff-' + currentReviewData.difficulty).checked = true;
			document.getElementById('horr-' + currentReviewData.horror).checked     = true;
			document.getElementById('act-' + currentReviewData.activity).checked    = true;
			document.getElementById('imm-' + currentReviewData.immersion).checked   = true;
			document.getElementById('sat-' + currentReviewData.satisfaction).checked = true;

			document.getElementById('reviewModalTitle').innerText   = "테마 리뷰 수정하기";
			document.getElementById('reviewSubmitBtn').innerText    = "리뷰 수정 완료";
		} else {
			<%-- 입력창과 라디오 버튼 1점으로 초기화 --%>
			document.getElementById('insReviewComment').value = "";
			document.getElementById('diff-1').checked = true;
			document.getElementById('horr-1').checked = true;
			document.getElementById('act-1').checked  = true;
			document.getElementById('imm-1').checked  = true;
			document.getElementById('sat-1').checked  = true;

			document.getElementById('reviewModalTitle').innerText = "테마 만족도 및 리뷰 등록";
			document.getElementById('reviewSubmitBtn').innerText  = "리뷰 등록 완료";
		}

		<%-- 기존 상세조회창은 닫고 리뷰창 열기 --%>
		const detailModalEl = document.getElementById('recordDetailModal');
		const detailModal   = bootstrap.Modal.getInstance(detailModalEl);
		if (detailModal) detailModal.hide();

		new bootstrap.Modal(document.getElementById('reviewModal')).show();
	}

	<%-- /write 단일 주소로 리뷰 데이터 일괄 전송 --%>
	function submitReviewForm() {
		const commentEl = document.getElementById('insReviewComment');
		if (!commentEl.value.trim()) {
			alert("한줄 코멘트를 입력해 주세요.");
			commentEl.focus();
			return;
		}

		const detailId = document.getElementById('md-review-detailId').value;
		const formData = new FormData(document.getElementById('reviewInsertForm'));

		<%-- 서버 컨트롤러 잭슨 매핑 규격에 맞춘 데이터 구조 --%>
		const reviewData = {
			detailId     : parseInt(detailId, 10),
			difficulty   : parseInt(formData.get('difficulty'), 10),
			horror       : parseInt(formData.get('horror'), 10),
			activity     : parseInt(formData.get('activity'), 10),
			immersion    : parseInt(formData.get('immersion'), 10),
			satisfaction : parseInt(formData.get('satisfaction'), 10),
			reviewComment: commentEl.value.trim()
		};

		fetch(`${CTX}/mypage/review/write`, {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify(reviewData)
		})
		.then(res => { if (!res.ok) throw new Error(); return res.text(); })
		.then(result => {
			if (result === "success") {
				alert("리뷰가 정상적으로 처리되었습니다.");
				location.reload();
			} else {
				alert("처리에 실패했습니다.");
			}
		})
		.catch(() => alert("통신 중 오류가 발생했습니다."));
	}

	<%-- 아직 기록 등록 안 한 플레이 리스트 가져오기 --%>
	function insertRecordModal() {
		fetch(`${CTX}/mypage/record/write`)
		.then(res => res.json())
		.then(list => {
			const selectEl = document.getElementById('unrecordedSelect');
			selectEl.innerHTML = '<option value="" selected disabled>기록을 등록할 플레이를 선택하세요.</option>';
			if (!list || list.length === 0) {
				alert("기록을 추가할 미등록 플레이 내역이 없습니다.");
				return;
			}
			<%-- 받아온 목록만큼 셀렉트 박스 옵션 동적 추가 --%>
			list.forEach(item => {
				const opt = document.createElement('option');
				opt.value     = item.detailId;
				opt.innerText = item.cafeName + ' - ' + item.roomName + ' / ' + item.playDate;
				selectEl.appendChild(opt);
			});
			new bootstrap.Modal(document.getElementById('insertRecordModal')).show();
		});
	}

	<%-- 새 기록 저장 전송 --%>
	function submitRecordInsert() {
		const selectEl  = document.getElementById('unrecordedSelect');
		const playTimeEl = document.getElementById('insPlayTime');
		if (!selectEl.value || !playTimeEl.value.trim()) return;

		<%-- DTO에 매핑될 수 있도록 숫자 데이터 형변환 파싱 --%>
		const recordData = {
			detailId     : parseInt(selectEl.value, 10),
			isEscaped    : parseInt(document.querySelector('input[name="isEscaped"]:checked').value, 10),
			playTime     : parseInt(playTimeEl.value.trim(), 10),
			hintCount    : parseInt(document.getElementById('insHintCount').value, 10),
			peopleCount  : parseInt(document.getElementById('insPlayerCount').value, 10),
			recordComment: document.getElementById('insRecordComment').value
		};

		fetch(`${CTX}/mypage/record/write`, {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify(recordData)
		}).then(() => location.reload());
	}

	<%-- 기존 탈출 기록 및 메모 수정 요청 전송 --%>
	function submitRecordUpdate() {
		const detailId   = document.getElementById('md-record-detailId').value;
		const updateData = {
			detailId     : parseInt(detailId, 10),
			isEscaped    : parseInt(document.querySelector('input[name="mdIsEscaped"]:checked').value, 10),
			playTime     : parseInt(document.getElementById('mdEditPlayTime').value, 10),
			hintCount    : parseInt(document.getElementById('mdEditHintCount').value, 10),
			peopleCount  : parseInt(document.getElementById('mdEditPlayerCount').value, 10),
			recordComment: document.getElementById('mdEditRecordComment').value
		};

		fetch(`${CTX}/mypage/record/update`, {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify(updateData)
		}).then(() => location.reload());
	}

	<%-- 상세보기 모달에서 보기 폼 ↔ 수정 폼 토글 기능 --%>
	function switchRecordMode(isEditMode) {
		document.getElementById('md-view-form').classList.toggle('d-none', isEditMode);
		document.getElementById('md-edit-form').classList.toggle('d-none', !isEditMode);
		document.getElementById('md-view-footer').classList.toggle('d-none', isEditMode);
		document.getElementById('md-edit-footer').classList.toggle('d-none', !isEditMode);
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

			<c:choose>
				<c:when test="${not empty recordList}">
					<c:forEach var="record" items="${recordList}">
						<%-- 탈출 성공/실패 여부가 실존하는 확정 내역만 카드 렌더링 --%>
						<c:if test="${not empty record.isEscaped}">
							<div id="card-${record.detailId}"
							     class="ne-card ne-card-accent clickable-card p-4 mb-3"
							     onclick="openRecordDetail(this)"
							     data-detail-id="${record.detailId}"
							     data-theme-title="${record.roomName}"
							     data-play-date="${record.playDate}"
							     data-play-time="${record.playTime}"
							     data-hint-count="${record.hintCount}"
							     data-people-count="${record.peopleCount}"
							     data-is-escaped="${record.isEscaped}"
							     data-memo="${record.recordComment}"
							     data-review-id="${record.reviewId}"
							     data-rv-diff="${record.difficulty}"
							     data-rv-horr="${record.horror}"
							     data-rv-act="${record.activity}"
							     data-rv-imm="${record.immersion}"
							     data-rv-sat="${record.satisfaction}"
							     data-rv-comment="${record.reviewComment}">

								<div class="record-item-body justify-content-between">
									<div class="d-flex align-items-center gap-3">
										<div style="width:80px; height:80px; flex-shrink:0; border-radius:var(--ne-radius-md); overflow:hidden;">
											<img src="${pageContext.request.contextPath}/dist/images/${record.roomImg}"
											     style="width:100%; height:100%; object-fit:cover;" alt="${record.roomName}">
										</div>
										<div>
											<h4 class="m-0 mb-1 fw-bold" style="font-size:18px;">${record.roomName}</h4>
											<p class="m-0 text-secondary small">${record.playDate}</p>
										</div>
									</div>
									<div class="d-flex align-items-center gap-3">
										<c:choose>
											<c:when test="${record.isEscaped == 1}"><span class="ne-st ne-st-amber">성공</span></c:when>
											<c:otherwise><span class="ne-st ne-st-red">실패</span></c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="text-center py-5 text-secondary">현재 플레이 기록이 존재하지 않습니다.</div>
				</c:otherwise>
			</c:choose>

			<%-- 하단 페이지 번호 출력 영역 --%>
			<c:if test="${totalPage > 1}">
				<div class="pagination-wrapper d-flex justify-content-center gap-2">
					<c:if test="${hasPrev}">
						<a href="?page=${currentPage - 1}" class="btn btn-sm btn-outline-secondary">이전</a>
					</c:if>
					<c:forEach var="p" begin="1" end="${totalPage}">
						<a href="?page=${p}"
						   class="btn btn-sm ${p == currentPage ? 'btn-primary' : 'btn-outline-secondary'}">${p}</a>
					</c:forEach>
					<c:if test="${hasNext}">
						<a href="?page=${currentPage + 1}" class="btn btn-sm btn-outline-secondary">다음</a>
					</c:if>
				</div>
			</c:if>

		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/rightSideBar.jsp" %>
</div>


<%-- 기록 상세 조회 및 인라인 수정 모달 레이아웃 --%>
<div class="modal fade" id="recordDetailModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="md-record-theme">테마 제목</h5>
				<span id="md-record-status" class="ms-3"></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4" style="font-size:14px;">
				<input type="hidden" id="md-record-detailId" value="">

				<%-- 데이터 단순 출력 화면 --%>
				<div id="md-view-form">
					<div class="ne-price-box mb-4">
						<div class="ne-price-row"><span class="ne-text-muted">최종 소요 시간</span><strong id="md-record-time" class="text-dark"></strong></div>
						<div class="ne-price-row"><span class="ne-text-muted">사용 힌트 개수</span><strong id="md-record-hint" class="text-dark"></strong></div>
						<div class="ne-price-row total"><span>함께한 인원</span><span id="md-record-players" class="ne-price-total-amount"></span></div>
					</div>
					<div class="mb-3">
						<label class="form-label ne-text-muted">플레이 일시</label>
						<div id="md-record-date" class="p-2 border-bottom text-dark fw-semibold"></div>
					</div>
					<div>
						<label class="form-label ne-text-muted">기록 메모</label>
						<div id="md-record-memo" class="ne-notice ne-notice-warning p-3 text-dark" style="min-height:80px; white-space:pre-wrap;"></div>
					</div>
				</div>

				<%-- 수정 버튼 클릭 시 교체되는 입력 폼 화면 --%>
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
					<div style="display:grid; grid-template-columns:repeat(3,1fr); gap:10px;" class="mb-4">
						<div>
							<label for="mdEditPlayTime" class="ne-insert-label mb-1 d-block text-secondary">소요 시간</label>
							<input type="text" class="form-control form-control-sm text-center" id="mdEditPlayTime">
						</div>
						<div>
							<label for="mdEditHintCount" class="ne-insert-label mb-1 d-block text-secondary">힌트 사용</label>
							<input type="number" class="form-control form-control-sm text-center" id="mdEditHintCount">
						</div>
						<div>
							<label for="mdEditPlayerCount" class="ne-insert-label mb-1 d-block text-secondary">플레이 인원</label>
							<input type="number" class="form-control form-control-sm text-center" id="mdEditPlayerCount">
						</div>
					</div>
					<div class="mb-2">
						<label for="mdEditRecordComment" class="ne-insert-label mb-1 d-block text-secondary">기록 메모</label>
						<textarea class="form-control" id="mdEditRecordComment" rows="3" style="font-size:13px; resize:none;"></textarea>
					</div>
				</div>
			</div>

			<div class="modal-footer py-2" id="md-view-footer">
				<button type="button" class="btn btn-sm btn-outline-success px-3 fw-semibold" onclick="openReviewModal()">리뷰 관리</button>
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


<%-- 신규 미등록 내역 생성 모달 레이아웃 --%>
<div class="modal fade" id="insertRecordModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">기록 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4" style="font-size:14px;">
				<div class="mb-3">
					<label class="ne-insert-label mb-1 d-block text-secondary">플레이 선택</label>
					<select class="form-select form-select-sm" id="unrecordedSelect"></select>
				</div>
				<div class="mb-4">
					<label class="ne-insert-label mb-2 d-block fw-semibold text-secondary">탈출 성공 여부</label>
					<div class="ne-status-toggle-group">
						<input type="radio" class="ne-status-toggle-btn" name="isEscaped" id="insEscape" value="1" checked>
						<label class="ne-status-label" for="insEscape">탈출 성공</label>
						<input type="radio" class="ne-status-toggle-btn" name="isEscaped" id="insFail" value="0">
						<label class="ne-status-label" for="insFail">탈출 실패</label>
					</div>
				</div>
				<div style="display:grid; grid-template-columns:repeat(3,1fr); gap:10px;" class="mb-4">
					<div>
						<label for="insPlayTime" class="ne-insert-label mb-1 d-block text-secondary">소요 시간</label>
						<input type="text" class="form-control form-control-sm text-center" id="insPlayTime" placeholder="분">
					</div>
					<div>
						<label for="insHintCount" class="ne-insert-label mb-1 d-block text-secondary">힌트 사용</label>
						<input type="number" class="form-control form-control-sm text-center" id="insHintCount" value="0" min="0">
					</div>
					<div>
						<label for="insPlayerCount" class="ne-insert-label mb-1 d-block text-secondary">플레이 인원</label>
						<input type="number" class="form-control form-control-sm text-center" id="insPlayerCount" value="1" min="1">
					</div>
				</div>
				<div class="mb-2">
					<label for="insRecordComment" class="ne-insert-label mb-1 d-block text-secondary">기록 메모</label>
					<textarea class="form-control" id="insRecordComment" rows="3" style="font-size:13px; resize:none;"></textarea>
				</div>
			</div>
			<div class="modal-footer py-2">
				<button type="button" class="btn btn-sm btn-secondary px-3" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-primary px-3 fw-semibold" onclick="submitRecordInsert()">기록 등록</button>
			</div>
		</div>
	</div>
</div>


<%-- 별점 정보 및 한줄평 리뷰 제어용 모달 레이아웃 --%>
<div class="modal fade" id="reviewModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered" style="max-width:480px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reviewModalTitle">테마 만족도 및 리뷰 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4" style="font-size:14px;">
				<form id="reviewInsertForm">
					<input type="hidden" id="md-review-detailId" name="detailId" value="">

					<div class="mb-3">
						<label class="ne-insert-label mb-2 d-block text-secondary fw-semibold">체감 난이도</label>
						<div class="ne-status-toggle-group d-flex" style="gap:4px;">
							<input type="radio" class="ne-status-toggle-btn" name="difficulty" id="diff-1" value="1"><label class="ne-status-label flex-fill text-center" for="diff-1">1</label>
							<input type="radio" class="ne-status-toggle-btn" name="difficulty" id="diff-2" value="2"><label class="ne-status-label flex-fill text-center" for="diff-2">2</label>
							<input type="radio" class="ne-status-toggle-btn" name="difficulty" id="diff-3" value="3"><label class="ne-status-label flex-fill text-center" for="diff-3">3</label>
							<input type="radio" class="ne-status-toggle-btn" name="difficulty" id="diff-4" value="4"><label class="ne-status-label flex-fill text-center" for="diff-4">4</label>
							<input type="radio" class="ne-status-toggle-btn" name="difficulty" id="diff-5" value="5"><label class="ne-status-label flex-fill text-center" for="diff-5">5</label>
						</div>
					</div>
					<div class="mb-3">
						<label class="ne-insert-label mb-2 d-block text-secondary fw-semibold">체감 공포도</label>
						<div class="ne-status-toggle-group d-flex" style="gap:4px;">
							<input type="radio" class="ne-status-toggle-btn" name="horror" id="horr-1" value="1"><label class="ne-status-label flex-fill text-center" for="horr-1">1</label>
							<input type="radio" class="ne-status-toggle-btn" name="horror" id="horr-2" value="2"><label class="ne-status-label flex-fill text-center" for="horr-2">2</label>
							<input type="radio" class="ne-status-toggle-btn" name="horror" id="horr-3" value="3"><label class="ne-status-label flex-fill text-center" for="horr-3">3</label>
							<input type="radio" class="ne-status-toggle-btn" name="horror" id="horr-4" value="4"><label class="ne-status-label flex-fill text-center" for="horr-4">4</label>
							<input type="radio" class="ne-status-toggle-btn" name="horror" id="horr-5" value="5"><label class="ne-status-label flex-fill text-center" for="horr-5">5</label>
						</div>
					</div>
					<div class="mb-3">
						<label class="ne-insert-label mb-2 d-block text-secondary fw-semibold">체감 활동성</label>
						<div class="ne-status-toggle-group d-flex" style="gap:4px;">
							<input type="radio" class="ne-status-toggle-btn" name="activity" id="act-1" value="1"><label class="ne-status-label flex-fill text-center" for="act-1">1</label>
							<input type="radio" class="ne-status-toggle-btn" name="activity" id="act-2" value="2"><label class="ne-status-label flex-fill text-center" for="act-2">2</label>
							<input type="radio" class="ne-status-toggle-btn" name="activity" id="act-3" value="3"><label class="ne-status-label flex-fill text-center" for="act-3">3</label>
							<input type="radio" class="ne-status-toggle-btn" name="activity" id="act-4" value="4"><label class="ne-status-label flex-fill text-center" for="act-4">4</label>
							<input type="radio" class="ne-status-toggle-btn" name="activity" id="act-5" value="5"><label class="ne-status-label flex-fill text-center" for="act-5">5</label>
						</div>
					</div>
					<div class="mb-3">
						<label class="ne-insert-label mb-2 d-block text-secondary fw-semibold">스토리 몰입도</label>
						<div class="ne-status-toggle-group d-flex" style="gap:4px;">
							<input type="radio" class="ne-status-toggle-btn" name="immersion" id="imm-1" value="1"><label class="ne-status-label flex-fill text-center" for="imm-1">1</label>
							<input type="radio" class="ne-status-toggle-btn" name="immersion" id="imm-2" value="2"><label class="ne-status-label flex-fill text-center" for="imm-2">2</label>
							<input type="radio" class="ne-status-toggle-btn" name="immersion" id="imm-3" value="3"><label class="ne-status-label flex-fill text-center" for="imm-3">3</label>
							<input type="radio" class="ne-status-toggle-btn" name="immersion" id="imm-4" value="4"><label class="ne-status-label flex-fill text-center" for="imm-4">4</label>
							<input type="radio" class="ne-status-toggle-btn" name="immersion" id="imm-5" value="5"><label class="ne-status-label flex-fill text-center" for="imm-5">5</label>
						</div>
					</div>
					<div class="mb-4">
						<label class="ne-insert-label mb-2 d-block text-secondary fw-semibold">종합 만족도</label>
						<div class="ne-status-toggle-group d-flex" style="gap:4px;">
							<input type="radio" class="ne-status-toggle-btn" name="satisfaction" id="sat-1" value="1"><label class="ne-status-label flex-fill text-center" for="sat-1">1</label>
							<input type="radio" class="ne-status-toggle-btn" name="satisfaction" id="sat-2" value="2"><label class="ne-status-label flex-fill text-center" for="sat-2">2</label>
							<input type="radio" class="ne-status-toggle-btn" name="satisfaction" id="sat-3" value="3"><label class="ne-status-label flex-fill text-center" for="sat-3">3</label>
							<input type="radio" class="ne-status-toggle-btn" name="satisfaction" id="sat-4" value="4"><label class="ne-status-label flex-fill text-center" for="sat-4">4</label>
							<input type="radio" class="ne-status-toggle-btn" name="satisfaction" id="sat-5" value="5"><label class="ne-status-label flex-fill text-center" for="sat-5">5</label>
						</div>
					</div>
					<div class="mb-2">
						<label for="insReviewComment" class="ne-insert-label mb-1 text-secondary fw-semibold">한줄 코멘트</label>
						<textarea class="form-control" id="insReviewComment" name="reviewComment" rows="3" style="font-size:13px; resize:none;"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer py-2">
				<button type="button" class="btn btn-sm btn-secondary px-3" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-primary px-3 fw-semibold" id="reviewSubmitBtn" onclick="submitReviewForm()">리뷰 등록 완료</button>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<%-- 부트스트랩 토글 및 팝업 작동용 플러그인 --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>