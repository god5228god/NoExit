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
		gap: 1rem;                       
	}
	
	.record-item-body {
		display: flex;
		gap: 1.5rem;
		align-items: center;
	}
</style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 헤더 높이만큼 본문 밀기( padding-top ) -->
<div class="main-body ne-body-offset">
	
	<!-- 왼쪽 사이드 바 영역 -->
	<%@ include file="/WEB-INF/views/common/myside.jsp" %>

	<!-- 메인 구성 영역 (개인기록, 매칭기록, 예약내역이 이 구역 안에서만 바뀜) -->
	<div class="main-content">
	
		<!-- 섹션 카드 -->
		<div class="ne-sc">
			<div class="ne-sc-title" style="font-size: 24px;">개인 기록</div>
			
			
			<div class="ne-card ne-card-accent p-4 mb-3">
				<div class="record-item-body">
					<div class="ne-room-img" style="width: 120px; height: 120px; flex-shrink: 0; font-size: 1.2rem;">
						🔑
					</div>
					<div>
						<h4 class="m-0 mb-2" style="font-size: 20px;">테마 제목</h4>
						<p class="m-0 text-secondary small">플레이 일시: 2026-06-01 14:00</p>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="right-sidebar">
		
		<div class="ne-sc m-0">
			<div class="ne-sc-title">예약 캘린더</div>
			<div class="ne-cal">
				<div class="ne-cal-head">
					<button class="ne-cal-btn">&lt;</button>
					<span class="ne-cal-title">2026.06</span>
					<button class="ne-cal-btn">&gt;</button>
				</div>
				<div class="ne-cal-grid">
					<div class="ne-cal-dow text-danger">일</div><div class="ne-cal-dow">월</div><div class="ne-cal-dow">화</div><div class="ne-cal-dow">수</div><div class="ne-cal-dow">목</div><div class="ne-cal-dow">금</div><div class="ne-cal-dow text-primary">토</div>
					<div class="ne-cal-day ne-cal-day-past">31</div>
					<div class="ne-cal-day selected">1</div>
					<div class="ne-cal-day has-slot">2</div>
					<div class="ne-cal-day">3</div><div class="ne-cal-day">4</div><div class="ne-cal-day">5</div><div class="ne-cal-day">6</div>
				</div>
			</div>
		</div>
		
		<div class="ne-sc m-0">
			<div class="ne-sc-title">매너 온도</div>
			<div class="d-flex align-items-center gap-2 mt-2">
				<span class="ne-mannero" style="font-size: 18px; padding: 0.4em 0.8em;">
					🔥 36.5°C
				</span>
			</div>
			<p class="ne-hint mt-3">상위 23%의 매너를 보유하고 있어요!<br>앞으로도 매너있는 플레이를 기대할게요!</p>
		</div>
		
		<div class="ne-sc m-0">
			<div class="ne-sc-title">현재 미진행 상호평가</div>
			<div class="d-flex flex-column gap-3 mt-2">
				<div class="d-flex justify-content-between align-items-center">
					<div>
						<span class="fw-bold d-block" style="font-size: 14px;">열정 탐험가</span>
						<span class="text-muted text-xs">홍대 NoExit</span>
					</div>
					<button class="btn btn-sm btn-outline-primary" style="font-size: 12px; padding: 4px 10px;">평가하기</button>
				</div>
			</div>
		</div>
		
	</div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>