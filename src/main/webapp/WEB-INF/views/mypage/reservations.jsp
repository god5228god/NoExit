<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No Exit - 마이페이지 예약현황 </title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath }/dist/css/myReserv.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/dist/js/reservations.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<main class="ne-main-content">
		<div class="ne-container d-flex justify-content-between" style="margin: 30px auto;">
			<aside class="">
				<%@ include file="/WEB-INF/views/common/myside.jsp" %>
			</aside>
			<div class="ne-card resListWrap" style="width: 55%;">
				<div class="title ne-sc-title">예약현황</div>
				<div class="tabWrap d-flex">
					<button type="button" class="tab on">예약 중 <span>3</span></button>
					<button type="button" class="tab">플레이 완료</button>
					<button type="button" class="tab">취소 내역</button>
				</div>
				<div class="listWrap">
					<div class="booked">
						<div class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">어둠의 저택</a> <span
										class="ne-st ne-st-sm ne-st-blue">예약 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									홍대 방탈출 공장 <span class="reservDate"> 2026-06-10 14:00 </span>
								</div>
								<div>예약인원 4명</div>
							</div>
							<div class="btnWrap">
								<button type="button" class="btn btn-outline-secondary">예약
									변경</button>
								<button type="button" class="btn ne-btn-deact">예약 취소</button>
							</div>
						</div>
						<div class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">어둠의 저택</a>	
									<span class="ne-st ne-st-sm ne-st-blue">예약 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									홍대 방탈출 공장
									<span class="reservDate">
										2026-06-10 14:00 
									</span>
								</div>
								<div style="">
									예약인원 4명
								</div>
							</div>
							<div class="btnWrap">
								<button type="button" class="btn btn-outline-secondary">예약 변경</button>
								<button type="button" class="btn ne-btn-deact">예약 취소</button>
							</div>
						</div>
						<div class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">어둠의 저택</a>	
									<span class="ne-st ne-st-sm ne-st-blue">예약 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									홍대 방탈출 공장
									<span class="reservDate">
										2026-06-10 14:00 
									</span>
								</div>
								<div style="">
									예약인원 4명
								</div>
							</div>
							<div class="btnWrap">
								<button type="button" class="btn btn-outline-secondary">예약 변경</button>
								<button type="button" class="btn ne-btn-deact">예약 취소</button>
							</div>
						</div>
						<div class="paginate">
							<!-- 등록된 내역이 없습니다. -->
							<a href="#"> 1 </a>
							<a href="#"> 2 </a>
							<span class="active">3</span>
							<a href="#"> 4 </a>
							<a href="#"> 5 </a>
						</div>
					</div> <!-- .booked -->
					<div class="done">
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">고대 신전의 비밀</a> <span
										class="ne-st ne-st-sm ne-st-green">출석 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									합정 미로존 <span class="reservDate"> 2026-05-12 17:00 </span>
								</div>
							</div>
							<div class="btnWrap">
								<button type="button" class="btn btn-primary">기록 등록</button>
								<button type="button" class="btn btn-outline-secondary">리뷰 등록</button>
							</div>
						</div>
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">고대 신전의 비밀</a> <span
										class="ne-st ne-st-sm ne-st-red">노쇼</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									합정 미로존 <span class="reservDate"> 2026-05-12 17:00 </span>
								</div>
							</div>
						</div>
						<div class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">고대 신전의 비밀</a>
									<span class="ne-st ne-st-sm ne-st-amber" >출석 미등록</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									합정 미로존 <span class="reservDate"> 2026-05-12 17:00 </span>
								</div>
							</div>
							<div class="btnWrap">
								<div class="ne-tooltip" data-tooltip="매장 누락 건입니다. 해당 카페(010-1234-1234)로 문의해 주세요.">
									<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-question-circle" viewBox="0 0 16 16">
										<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
										<path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286m1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94"/>
									</svg>
								</div>
							</div> 
						</div>
						<div class="paginate">
							<!-- 등록된 내역이 없습니다. -->
							<a href="#"> 1 </a>
							<a href="#"> 2 </a>
							<span class="active">3</span>
							<a href="#"> 4 </a>
							<a href="#"> 5 </a>
						</div>
					</div> <!-- .done -->
					<div class="canceled">
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">고대 신전의 비밀</a> <span
										class="ne-st ne-st-sm ne-st-red">취소 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									합정 미로존 <span class="reservDate"> 2026-05-12 17:00 </span>
								</div>
								<div style="font-size: 14px; color: #666;">
									취소일: 2026-05-01
								</div>
							</div>
						</div>
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">고대 신전의 비밀</a> <span
										class="ne-st ne-st-sm ne-st-danger">매장 취소</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									합정 미로존 <span class="reservDate"> 2026-05-12 17:00 </span>
								</div>
								<div style="font-size: 14px; color: #666;">
									취소일: 2026-05-01
								</div>
							</div>
						</div>
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="#" class="theme">고대 신전의 비밀</a> <span
										class="ne-st ne-st-sm ne-st-red">취소 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									합정 미로존 <span class="reservDate"> 2026-05-12 17:00 </span>
								</div>
								<div style="font-size: 14px; color: #666;">
									취소일: 2026-05-01
								</div>
							</div>
						</div>
						<div class="paginate">
							<!-- 등록된 내역이 없습니다. -->
							<a href="#"> 1 </a>
							<a href="#"> 2 </a>
							<span class="active">3</span>
							<a href="#"> 4 </a>
							<a href="#"> 5 </a>
						</div>
					</div><!-- .canceled -->
			
				</div>
			</div>
			<aside class="d-flex justify-content-end">
				<%@ include file="/WEB-INF/views/common/myside.jsp" %>
			</aside>

		</div>
	</main>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>