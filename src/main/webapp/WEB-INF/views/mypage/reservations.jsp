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
	<div class="modal fade" id="cancelModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">예약 취소</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					     <p><span class="text-muted">카페</span> &nbsp; <strong id="modal-cafe-name"></strong></p>
		                <p><span class="text-muted">테마</span> &nbsp; <strong id="modal-room-name"></strong></p>
		                <p><span class="text-muted">일시</span> &nbsp; <strong id="modal-open-at"></strong></p>
		                <p><span class="text-muted">인원</span> &nbsp; <strong id="modal-total-member"></strong>명</p>
<!-- 		                <p><span class="text-muted">연결된 파티</span> &nbsp; <strong id="modal-party-name"></strong></p> -->
		                <div class="mt-3" style="color:#e53935; font-size:13px;">
		                    취소 후 복구가 불가합니다. 정말 취소하시겠습니까? ${dto.reservationId} 
                		</div>
				</div>
				<div class="modal-footer">
                	<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                	<button type="button" class="btn ne-btn-deact" id="modalConfirmBtn" >예약 취소</button>
            	</div>
			
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<main class="ne-main-content" >
		<div class="ne-container d-flex justify-content-between" style="margin: 30px auto;">
			<aside class="">
				<%@ include file="/WEB-INF/views/common/leftSideBar.jsp" %>
			</aside>
			<div class="ne-card resListWrap" style="width: 55%; margin: 0 20px;">
				<div class="title ne-sc-title">예약현황</div>
				<div class="tabWrap d-flex">
					<a href="${pageContext.request.contextPath }/mypage/reservations?tab=1&page=1" 
					class="tab ${tab==1? 'on': '' }">예약 중 <span>${bookedCount }</span></a>
					<a href="${pageContext.request.contextPath }/mypage/reservations?tab=2&page=1" 
					class="tab ${tab==2? 'on': ''}">플레이 완료 </a>
					<a href="${pageContext.request.contextPath }/mypage/reservations?tab=3&page=1" 
					class="tab ${tab==3? 'on': ''}">예약 취소 </a>
				</div>
				<div class="listWrap">
				<c:if test="${tab==1 }">
					<div class="booked">
					<c:forEach var="dto" items="${list }">
						<div class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="${pageContext.request.contextPath }/theme/info/${dto.roomId}" class="theme">${dto.roomName }</a> <span
										class="ne-st ne-st-sm ne-st-blue">예약 완료</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									${dto.cafeName } <span class="reservDate"> ${dto.openAt } </span>
								</div>
								<div>예약인원 ${dto.totalMember }명</div>
							</div>
							<c:if test="${dto.partyRole == '파티장' }">
								<div class="btnWrap">
									<button type="button" class="btn ne-btn-deact cancelBtn" 
									data-reservation-id="${dto.reservationId}"
							        data-cafe-name="${dto.cafeName}"
							        data-room-name="${dto.roomName}"
							        data-open-at="${dto.openAt}"
							        data-total-member="${dto.totalMember}"
							        data-party-name="${dto.partyName}"
							        data-party-id="${dto.partyId}"
									>예약 취소</button>
								</div>
							</c:if>
						</div>
					</c:forEach>
						<c:if test="${empty list }">
							<div class="text-center">예약 중인 내역이 없습니다.</div>
						</c:if>
						${paging }
			
					</div> 
				</c:if>
				<c:if test="${tab==2 }">
					<div class="done">
					<c:forEach var="dto" items="${list }">
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="${pageContext.request.contextPath }/theme/info/${dto.roomId}" class="theme">${dto.roomName }</a> <span
										class="ne-st ne-st-sm 
										${dto.attendStatus=='출석 완료'? 'ne-st-green'
										: dto.attendStatus=='노쇼'? 'ne-st-red' : 'ne-st-amber'}
										">${dto.attendStatus }</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									${dto.cafeName } <span class="reservDate"> ${dto.openAt } </span>
								</div>
							</div>
							<c:if test="${dto.attendStatus == '출석 완료' }">
								<div class="btnWrap">
									<button type="button" class="btn btn-primary">기록 등록</button>
									<button type="button" class="btn btn-outline-secondary">리뷰 등록</button>
								</div>
							</c:if>
							<c:if test="${dto.attendStatus == '출석 미등록' }">
								<div class="btnWrap">
									<div class="ne-tooltip" data-tooltip="매장 누락 건입니다. 해당 카페(${dto.cafeTel })로 문의해 주세요.">
										<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-question-circle" viewBox="0 0 16 16">
											<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
											<path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286m1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94"/>
										</svg>
									</div>
								</div> 
							</c:if>
						</div>
					</c:forEach>
			
						<c:if test="${empty list }">
							<div class="text-center">플레이 완료된 내역이 없습니다.</div>
						</c:if>
						${paging }
					
					</div> <!-- .done -->
				</c:if>
				<c:if test="${tab==3 }">
					<div class="canceled">
					<c:forEach var="dto" items="${list }">
						<div
							class="ne-card ne-card-accent d-flex justify-content-between align-items-center">
							<div>
								<div>
									<a href="${pageContext.request.contextPath }/theme/info/${dto.roomId}" class="theme">${dto.roomName }</a> <span
										class="ne-st ne-st-sm ne-st-red">${dto.cancelType }</span>
								</div>
								<div style="color: #666; font-size: 14px;">
									${dto.cafeName } <span class="reservDate">
										${dto.openAt } 
									</span>
								</div>
								<div style="font-size: 14px; color: #666;">
									취소일: ${dto.canceledAt }
								</div>
							</div>
						</div>
					</c:forEach>
						<c:if test="${empty list }">
							<div class="text-center">취소된 내역이 없습니다.</div>
						</c:if>
						${paging }
					</div><!-- .canceled -->
				</c:if>
				</div>
			</div>
			<aside class="d-flex justify-content-end" style="width: 25%;">
				<%@ include file="/WEB-INF/views/common/rightSideBar.jsp" %>
			</aside>

		</div>
	</main>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>