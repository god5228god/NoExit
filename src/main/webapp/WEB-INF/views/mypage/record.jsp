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
	}

	.main-content {
		flex-grow: 1;
		min-width: 0;
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
	
	
</style>
<script type="text/javascript">

	function openRecordDetail(cardElement) {
		
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
		
		//  Escaped 여부에 따른 상태 뱃지 랜더링
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
</script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 헤더 높이만큼 본문 밀기( padding-top ) , 메인 바디 영역-->
<div class="main-body ne-body-offset">
	
	<!-- 왼쪽 사이드 바 영역 -->
	<%@ include file="/WEB-INF/views/common/leftSideBar.jsp" %>

	<!-- 메인 구성 영역 (개인기록, 매칭기록, 예약내역이 이 구역 안에서만 바뀜) -->
	<div class="main-content">
	
		<!-- 섹션 카드 -->
		<div class="ne-sc">
			<div class="ne-sc-title" style="font-size: 24px;">개인 기록</div>
			
			<!-- 더미 기록 카드 -->
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
						</div>
						<div>
							<h4 class="m-0 mb-1 fw-bold" style="font-size: 18px;">비밀의 숲</h4>
							<p class="m-0 text-secondary small">2024.05.17 (금) 14:00</p>
						</div>
					</div>
					
					<!-- 우측 정보 박스 (성공 여부) -->
					<div class="d-flex align-items-center gap-3">
						<div>
							<span class="ne-st ne-st-amber">성공</span>
						</div>
					</div>
				</div>
			</div><!-- 더미 기록 카드 -->
			
			
			
			
			<!-- 기록 카드 -->
			<c:choose>
				<%-- DB에서 조회해온 리스트가 들어가있을 때 리스트 출력 --%>
				<c:when test="${not empty recordList}">
					<c:forEach var="record" items="${recordList}">
						
						<%-- 클릭 이벤트 연결, 모달로 보낼 데이터 추가 --%>
						<div class="ne-card ne-card-accent p-4 mb-3 clickable-card" 
							 onclick="openRecordDetail(this)"
							 data-theme-title="${record.themeTitle}"
							 data-play-date="${record.playDate} | ${record.branchName}"
							 data-play-time="${record.playTime}"
							 data-hint-count="${record.hintCount}"
							 data-player-count="${record.playerCount}"
							 data-is-escaped="${record.isEscaped}"
							 data-memo="${record.memo}">
							 
							<div class="record-item-body justify-content-between">
							
								<%-- 테마 이미지, 테마명, 플레이 일시 --%>
								<div class="d-flex align-items-center gap-3">
									<div class="ne-room-img" style="width: 80px; height: 80px; flex-shrink: 0; border-radius: var(--ne-radius-md);">
									</div>
									<div>
										<h4 class="m-0 mb-1 fw-bold" style="font-size: 18px;">${record.themeTitle}</h4>
										<p class="m-0 text-secondary small">${record.playDate}</p>
									</div>
								</div>
								
								
								<%-- 탈출여부 동적 바인딩 영역 --%>
								<div class="d-flex align-items-center gap-3">
									<c:choose>
										<%-- 출석체크만 된 최초 상태 --%>
										<c:when test="${empty record.isEscaped}">
											<div>
												<%-- 클릭 시 모달창이 열리면서 '입력 모드'로 작동하게 설정할 버튼 --%>
												<button type="button" class="btn btn-sm btn-outline-primary px-3 fw-semibold">기록하기</button>
											</div>
										</c:when>
										
										<%-- 유저가 탈출 성공/실패 기록을 입력해 둔 상태 --%>
										<c:otherwise>
											<div>
											
											<c:choose>
												<%-- 리뷰가 비어있을 때 리뷰입력 버튼 랜더링 --%>
												<c:when test="${empty review.reviewId}">
													<button type="button" class="btn-sm btn-outline-primary px-3 fw-semibold" >리뷰 입력</button>
												</c:when>
											</c:choose>
																			
												<%-- 성공 or 실패 뱃지 출력 --%>
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
				
				
				
				<%-- DB에 기록 데이터 없을 때 출력--%>
				<c:otherwise>
					<div class="text-center py-5 text-secondary">
						현재 플레이 기록이 존재하지 않습니다.
					</div>
				</c:otherwise>
			</c:choose>

			
		</div><!-- 섹션 -->
		
	</div><!-- 메인 레코드 영역 -->

<!-- 우측 사이드 바 import -->
<%@ include file="/WEB-INF/views/common/rightSideBar.jsp" %>

</div><!-- 메인 바디 영역 -->


<!-- 개인 기록 모달 영역 -->
<div class="modal fade" id="recordDetailModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered"> 
		<div class="modal-content">
		
			<%-- 모달 헤더 --%>
			<div class="modal-header">
				<h5 class="modal-title" id="md-record-theme">테마 제목</h5>
				<span id="md-record-status" class="ms-3"></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			
			<%-- 모달 본문 --%>
			<div class="modal-body p-4" style="font-size: 14px;">
				
				<%-- 최종 기록 정보 레이아웃 --%>
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
				
				
				<%-- 플레이 일시 영역 --%>
				<div class="mb-3">
					<label class="form-label ne-text-muted">플레이 일시</label>
					<div id="md-record-date" class="p-2 border-bottom text-dark fw-semibold"></div>
				</div>
				
				<%-- 기록 메모 영역 --%>
				<div>
					<label class="form-label ne-text-muted">기록 메모</label>
					<div id="md-record-memo" class="ne-notice ne-notice-warning p-3 text-dark" style="min-height: 80px; white-space: pre-wrap;"></div>
				</div>
			</div>
			
			<%-- 모달 푸터: 닫기 버튼 --%>
			<div class="modal-footer py-2">
				<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div><!-- 개인 기록 모달 영역 -->


<!-- 푸터 import -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>