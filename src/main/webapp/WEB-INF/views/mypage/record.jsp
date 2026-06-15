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

	// JSP 안에서 contextPath를 JS 변수로 빼서 관리 (매번 EL 쓰면 지저분해짐)
	const CTX = '${pageContext.request.contextPath}';

	// 리뷰 모달에서 사용할 현재 카드의 리뷰 데이터를 전역으로 보관
	// openRecordDetail()에서 세팅하고, openReviewModal()에서 읽어서 씀
	let currentReviewData = {};

	// 카드 클릭 시 호출 - 카드의 data 속성 읽어서 기록 상세 모달에 바인딩
	function openRecordDetail(cardElement) {

		// 모달을 열 때마다 항상 보기 모드로 초기화 (이전에 수정 모드였을 수 있으니까)
		switchRecordMode(false);

		// 카드 HTML의 data 속성에서 기록 데이터 읽기
		const detailId      = cardElement.getAttribute('data-detail-id');
		const themeTitle    = cardElement.getAttribute('data-theme-title');
		const playDate      = cardElement.getAttribute('data-play-date');
		const playTime      = cardElement.getAttribute('data-play-time');
		const hintCount     = cardElement.getAttribute('data-hint-count');
		const peopleCount   = cardElement.getAttribute('data-people-count');
		const isEscaped     = cardElement.getAttribute('data-is-escaped');
		const recordComment = cardElement.getAttribute('data-memo');

		// 리뷰 관련 데이터는 openReviewModal()에서 쓸 거라 전역 객체에 따로 보관
		currentReviewData = {
			reviewId      : cardElement.getAttribute('data-review-id'),
			difficulty    : cardElement.getAttribute('data-rv-diff'),
			horror        : cardElement.getAttribute('data-rv-horr'),
			activity      : cardElement.getAttribute('data-rv-act'),
			immersion     : cardElement.getAttribute('data-rv-imm'),
			satisfaction  : cardElement.getAttribute('data-rv-sat'),
			reviewComment : cardElement.getAttribute('data-rv-comment')
		};

		// 기록 상세 모달 - 보기 폼 세팅
		document.getElementById('md-record-detailId').value    = detailId;
		document.getElementById('md-record-theme').innerText   = themeTitle;
		document.getElementById('md-record-date').innerText    = playDate;
		// 초 단위로 저장된 playTime을 분:초 형태로 변환해서 표시
		const totalSec  = parseInt(playTime, 10);
		const dispMin   = Math.floor(totalSec / 60);
		const dispSec   = totalSec % 60;
		document.getElementById('md-record-time').innerText = dispMin + "분 " + (dispSec > 0 ? dispSec + "초" : "");
		document.getElementById('md-record-hint').innerText    = hintCount + "개";
		document.getElementById('md-record-players').innerText = peopleCount + "명";
		// 메모 없으면 안내 문구 표시
		document.getElementById('md-record-memo').innerText    = recordComment || "등록된 메모가 없습니다.";

		// 기록 상세 모달 - 수정 폼에도 미리 세팅 (수정하기 버튼 누르면 바로 보여야 하니까)
		// 초 단위 playTime을 분/초 칸에 나눠서 세팅
		const editTotalSec = parseInt(playTime, 10);
		document.getElementById('mdEditPlayMin').value = Math.floor(editTotalSec / 60);
		document.getElementById('mdEditPlaySec').value = editTotalSec % 60;
		document.getElementById('mdEditHintCount').value     = hintCount;
		document.getElementById('mdEditPlayerCount').value   = peopleCount;
		document.getElementById('mdEditRecordComment').value = recordComment || "";
		// isEscaped 값으로 라디오버튼 선택 상태 세팅
		document.getElementById(isEscaped === "1" ? 'mdEditEscape' : 'mdEditFail').checked = true;

		// 탈출 성공/실패에 따라 뱃지 스타일 분기
		const badge = document.getElementById('md-record-status');
		if (isEscaped === "1") {
			badge.innerText = "성공"; badge.className = "ne-st ne-st-amber";
		} else {
			badge.innerText = "실패"; badge.className = "ne-st ne-st-red";
		}

		new bootstrap.Modal(document.getElementById('recordDetailModal')).show();
	}

	// 리뷰 관리 버튼 클릭 시 호출
	// currentReviewData.reviewId 유무로 등록 / 수정 모드 분기
	function openReviewModal() {
		const detailId = document.getElementById('md-record-detailId').value;
		if (!detailId) { alert("출석 번호를 식별할 수 없습니다."); return; }

		// 리뷰 모달 hidden input에 detailId 세팅 (서버로 전송할 때 필요)
		document.getElementById('md-review-detailId').value = detailId;

		const rid = currentReviewData.reviewId;
		// reviewId가 존재하고 0이 아니면 수정 모드
		const isEditMode = rid && rid !== "0" && rid !== "";

		if (isEditMode) {
			// 수정 모드 - 기존 리뷰 데이터로 폼 채우기
			document.getElementById('insReviewComment').value = currentReviewData.reviewComment || "";

			// JSP 안에서 JS 템플릿 리터럴 쓰면 EL이랑 충돌해서 문자열 연결로 처리
			document.getElementById('diff-' + currentReviewData.difficulty).checked = true;
			document.getElementById('horr-' + currentReviewData.horror).checked     = true;
			document.getElementById('act-'  + currentReviewData.activity).checked   = true;
			document.getElementById('imm-'  + currentReviewData.immersion).checked  = true;
			document.getElementById('sat-'  + currentReviewData.satisfaction).checked = true;

			// 모달 타이틀, 버튼 텍스트 수정 모드로 변경
			document.getElementById('reviewModalTitle').innerText = "테마 리뷰 수정하기";
			document.getElementById('reviewSubmitBtn').innerText  = "리뷰 수정 완료";
			document.getElementById('reviewDeleteBtn').classList.remove('d-none');
		} else {
			// 등록 모드 - 폼 초기화
			document.getElementById('insReviewComment').value = "";
			document.getElementById('diff-1').checked = true;
			document.getElementById('horr-1').checked = true;
			document.getElementById('act-1').checked  = true;
			document.getElementById('imm-1').checked  = true;
			document.getElementById('sat-1').checked  = true;

			// 모달 타이틀, 버튼 텍스트 등록 모드로 변경
			document.getElementById('reviewModalTitle').innerText = "테마 만족도 및 리뷰 등록";
			document.getElementById('reviewSubmitBtn').innerText  = "리뷰 등록 완료";
			document.getElementById('reviewDeleteBtn').classList.add('d-none');
		}

		// 기록 상세 모달 닫고 리뷰 모달 열기
		// getInstance로 이미 열린 인스턴스 가져와서 닫아야 backdrop 안 겹침
		const detailModal = bootstrap.Modal.getInstance(document.getElementById('recordDetailModal'));
		if (detailModal) detailModal.hide();

		new bootstrap.Modal(document.getElementById('reviewModal')).show();
	}

	// 리뷰 등록/수정 공통 전송 함수
	// URL은 /mypage/review/write 하나로 통일
	// 서버(MyPageServiceImpl.insertReview)에서 countReview로 insert/update 분기 처리함
	function submitReviewForm() {
		const commentEl = document.getElementById('insReviewComment');
		// 한줄 코멘트 공백 검증
		if (!commentEl.value.trim()) {
			alert("한줄 코멘트를 입력해 주세요.");
			commentEl.focus();
			return;
		}

		const detailId = document.getElementById('md-review-detailId').value;
		// FormData로 라디오버튼 name 기반으로 선택된 값 한 번에 수집
		const formData = new FormData(document.getElementById('reviewInsertForm'));

		// 서버 MyPage 객체 필드명에 맞게 키 세팅
		const reviewData = {
			detailId     : parseInt(detailId, 10),
			difficulty   : parseInt(formData.get('difficulty'), 10),
			horror       : parseInt(formData.get('horror'), 10),
			activity     : parseInt(formData.get('activity'), 10),
			immersion    : parseInt(formData.get('immersion'), 10),
			satisfaction : parseInt(formData.get('satisfaction'), 10),
			reviewComment: commentEl.value.trim()
		};

		fetch(CTX + '/mypage/review/write', {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify(reviewData)
		})
		.then(res => { if (!res.ok) throw new Error(); return res.text(); })
		.then(result => {
			if (result === "success") {
				alert("리뷰가 정상적으로 처리되었습니다.");
				// 리뷰 데이터 최신화를 위해 페이지 새로고침
				location.reload();
			} else {
				alert("처리에 실패했습니다.");
			}
		})
		.catch(() => alert("통신 중 오류가 발생했습니다."));
	}

	// 리뷰 삭제 - 수정 모드일 때만 버튼 노출, detailId 기준으로 삭제 요청
	function deleteReview() {
		if (!confirm("삭제하시겠습니까?")) return;

		// currentReviewData에 보관된 reviewId로 삭제 요청
		const reviewId = currentReviewData.reviewId;

		fetch(CTX + '/mypage/review/delete', {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify({ reviewId: parseInt(reviewId, 10) })
		})
		.then(res => { if (!res.ok) throw new Error(); return res.text(); })
		.then(result => {
			if (result === "success") {
				alert("리뷰가 삭제되었습니다.");
				location.reload();
			} else {
				alert("삭제에 실패했습니다.");
			}
		})
		.catch(() => alert("통신 중 오류가 발생했습니다."));
	}

	// 기록 추가 버튼 클릭 시 호출
	// 아직 기록을 남기지 않은 플레이 목록을 GET으로 받아서 select에 채워줌
	function insertRecordModal() {
		fetch(CTX + '/mypage/record/write')
		.then(res => res.json())
		.then(list => {
			const selectEl = document.getElementById('unrecordedSelect');
			// 호출할 때마다 초기화 (이전에 채워진 옵션 남아있을 수 있으니까)
			selectEl.innerHTML = '<option value="" selected disabled>기록을 등록할 플레이를 선택하세요.</option>';
			if (!list || list.length === 0) {
				alert("기록을 추가할 미등록 플레이 내역이 없습니다.");
				return;
			}
			// [카페명] 테마명 (날짜) 형식으로 옵션 생성
			list.forEach(item => {
				const opt = document.createElement('option');
				opt.value     = item.detailId;
				opt.innerText = '[' + item.cafeName + '] ' + item.roomName + ' (' + item.playDate + ')';
				selectEl.appendChild(opt);
			});
			new bootstrap.Modal(document.getElementById('insertRecordModal')).show();
		});
	}

	// 기록 등록 전송
	function submitRecordInsert() {
		const selectEl   = document.getElementById('unrecordedSelect');
		const playTimeEl = document.getElementById('insPlayTime');
		// 플레이 선택, 소요 시간은 필수값
		if (!selectEl.value || !playTimeEl.value.trim()) { alert("소요 시간을 입력해주세요."); return; }

		// 분*60 + 초 합산해서 초 단위로 전송
		const insMin = parseInt(playTimeEl.value.trim(), 10) || 0;
		const insSec = parseInt(document.getElementById('insPlaySec').value, 10) || 0;

		const recordData = {
			detailId     : parseInt(selectEl.value, 10),
			isEscaped    : parseInt(document.querySelector('input[name="isEscaped"]:checked').value, 10),
			playTime     : insMin * 60 + insSec,
			hintCount    : parseInt(document.getElementById('insHintCount').value, 10),
			peopleCount  : parseInt(document.getElementById('insPlayerCount').value, 10),
			recordComment: document.getElementById('insRecordComment').value
		};

		fetch(CTX + '/mypage/record/write', {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify(recordData)
		}).then(() => location.reload());
	}

	// 기록 수정 전송
	// 기록 상세 모달의 수정 폼 데이터를 읽어서 전송
	function submitRecordUpdate() {
		const detailId   = document.getElementById('md-record-detailId').value;
		// 분*60 + 초 합산해서 초 단위로 전송
		const editMin = parseInt(document.getElementById('mdEditPlayMin').value, 10) || 0;
		const editSec = parseInt(document.getElementById('mdEditPlaySec').value, 10) || 0;

		const updateData = {
			detailId     : parseInt(detailId, 10),
			isEscaped    : parseInt(document.querySelector('input[name="mdIsEscaped"]:checked').value, 10),
			playTime     : editMin * 60 + editSec,
			hintCount    : parseInt(document.getElementById('mdEditHintCount').value, 10),
			peopleCount  : parseInt(document.getElementById('mdEditPlayerCount').value, 10),
			recordComment: document.getElementById('mdEditRecordComment').value
		};

		fetch(CTX + '/mypage/record/update', {
			method : 'POST',
			headers: { 'Content-Type': 'application/json' },
			body   : JSON.stringify(updateData)
		}).then(() => location.reload());
	}

	// 기록 상세 모달의 보기 / 수정 모드 전환
	// isEditMode true면 수정 폼 보이고 보기 폼 숨김, false면 반대
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
						<%-- isEscaped가 비어있는 카드(기록 미등록)는 렌더링하지 않음 --%>
						<c:if test="${not empty record.isEscaped}">
							<%-- 카드 클릭 시 JS에서 data 속성 읽어서 모달에 바인딩 --%>
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
										<%-- isEscaped 값으로 성공/실패 뱃지 분기 --%>
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

			<%-- 총 페이지가 1개면 페이지네이션 안 보여줌 --%>
			<c:if test="${totalPage > 1}">
				<div class="pagination-wrapper d-flex justify-content-center gap-2">
					<c:if test="${hasPrev}">
						<a href="?page=${currentPage - 1}" class="btn btn-sm btn-outline-secondary">이전</a>
					</c:if>
					<%-- 현재 페이지는 btn-primary, 나머지는 outline --%>
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

<%-- 기록 상세 모달 - 보기/수정 모드 전환 구조 --%>
<div class="modal fade" id="recordDetailModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="md-record-theme">테마 제목</h5>
				<span id="md-record-status" class="ms-3"></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4" style="font-size:14px;">
				<%-- JS에서 detailId를 읽어야 해서 hidden으로 박아둠 --%>
				<input type="hidden" id="md-record-detailId" value="">

				<%-- 보기 폼 --%>
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
						<div id="md-record-memo" class="ne-notice ne-notice-warning p3 text-dark" style="min-height:80px; white-space:pre-wrap;"></div>
					</div>
				</div>

				<%-- 수정 폼 - 기본은 d-none, 수정하기 버튼 클릭 시 switchRecordMode(true)로 토글 --%>
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
					<div style="display:grid; grid-template-columns:repeat(4,1fr); gap:10px;" class="mb-4">
						<div>
							<label for="mdEditPlayMin" class="ne-insert-label mb-1 d-block text-secondary">분</label>
							<input type="number" class="form-control form-control-sm text-center" id="mdEditPlayMin" min="0">
						</div>
						<div>
							<label for="mdEditPlaySec" class="ne-insert-label mb-1 d-block text-secondary">초</label>
							<input type="number" class="form-control form-control-sm text-center" id="mdEditPlaySec" min="0" max="59">
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

			<%-- 보기 모드 푸터 --%>
			<div class="modal-footer py-2" id="md-view-footer">
				<button type="button" class="btn btn-sm btn-outline-success px-3 fw-semibold" onclick="openReviewModal()">리뷰 관리</button>
				<button type="button" class="btn btn-sm btn-outline-primary px-3" onclick="switchRecordMode(true)">수정하기</button>
				<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
			<%-- 수정 모드 푸터 - 기본은 d-none --%>
			<div class="modal-footer py-2 d-none" id="md-edit-footer">
				<button type="button" class="btn btn-sm btn-secondary px-3" onclick="switchRecordMode(false)">취소</button>
				<button type="button" class="btn btn-sm btn-primary px-3 fw-semibold" onclick="submitRecordUpdate()">수정 완료</button>
			</div>
		</div>
	</div>
</div>

<%-- 기록 추가 모달 - 미등록 플레이 목록 select로 선택 후 등록 --%>
<div class="modal fade" id="insertRecordModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">기록 추가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4" style="font-size:14px;">
				<%-- insertRecordModal()에서 동적으로 option 채워줌 --%>
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
				<div style="display:grid; grid-template-columns:repeat(4,1fr); gap:10px;" class="mb-4">
					<div>
						<label for="insPlayTime" class="ne-insert-label mb-1 d-block text-secondary">분</label>
						<input type="number" class="form-control form-control-sm text-center" id="insPlayTime" placeholder="0" min="0">
					</div>
					<div>
						<label for="insPlaySec" class="ne-insert-label mb-1 d-block text-secondary">초</label>
						<input type="number" max="59" class="form-control form-control-sm text-center" id="insPlaySec" placeholder="0" min="0" max="59">
					</div>
					<div>
						<label for="insHintCount" class="ne-insert-label mb-1 d-block text-secondary">힌트 사용</label>
						<input type="number" min="0" class="form-control form-control-sm text-center" id="insHintCount" value="0" min="0">
					</div>
					<div>
						<label for="insPlayerCount" class="ne-insert-label mb-1 d-block text-secondary">플레이 인원</label>
						<input type="number" min="0" class="form-control form-control-sm text-center" id="insPlayerCount" value="1" min="1">
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

<%-- 리뷰 등록/수정 모달
     등록: reviewId 없을 때 / 수정: reviewId 있을 때
     openReviewModal()에서 분기 후 타이틀, 버튼 텍스트, 폼 데이터 세팅
     전송은 submitReviewForm() 하나로 통일, 서버에서 countReview로 insert/update 분기 --%>
<div class="modal fade" id="reviewModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered" style="max-width:480px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="reviewModalTitle">테마 만족도 및 리뷰 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4" style="font-size:14px;">
				<form id="reviewInsertForm">
					<%-- 서버로 전송할 detailId, openReviewModal()에서 세팅됨 --%>
					<input type="hidden" id="md-review-detailId" name="detailId" value="">

					<%-- 라디오버튼 1~5 하드코딩
					     c:forEach + ${i} 조합 시 JSP EL 충돌로 렌더링 안 되는 문제 있어서 풀어씀 --%>
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
				<%-- 삭제 버튼은 수정 모드일 때만 보임, openReviewModal()에서 토글 --%>
				<button type="button" class="btn btn-sm btn-outline-danger px-3 me-auto d-none" id="reviewDeleteBtn" onclick="deleteReview()">삭제</button>
				<button type="button" class="btn btn-sm btn-secondary px-3" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-primary px-3 fw-semibold" id="reviewSubmitBtn" onclick="submitReviewForm()">리뷰 등록 완료</button>
			</div>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
