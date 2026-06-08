<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 출석체크</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/attendance.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">

	function attendOk(formId){
		if(confirm('출석 처리 하시겠습니까?')){
			document.getElementById(formId).submit();
		}
	}

	function noshowOk(formId){
		if(confirm('노쇼 처리 하시겠습니까?')){
			document.getElementById(formId).submit();
		}
	}

</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex">
			<aside class="col-md-2">
					<%@ include file="/WEB-INF/views/common/ownerSide.jsp"%>
			</aside>
			<div class="col-md-10 resWrap">
				<div class="title">출석 체크</div>
				<div class="d-flex justify-content-between">
					<div class="resList" style="width:100%">
						<div class="attend-list">

							<div class="row fw-bold border-bottom py-2 m-0">
								<div class="col-1">시간</div>
								<div class="col-2">카페</div>
								<div class="col-2">테마</div>
								<div class="col-2">예약자</div>
								<div class="col-1">인원</div>
								<div class="col-2">상태</div>
								<div class="col-2"></div>
							</div>

							<c:forEach var="r" items="${attendList}">
								<div class="row align-items-center border-bottom py-2 m-0 text-muted">
									<div class="col-1 fw-bold">
									<fmt:formatDate value="${r.openAt}" pattern="MM-dd"/><br>
									<fmt:formatDate value="${r.openAt}" pattern="HH:mm"/>
								</div>
									<div class="col-2">${r.cafeName}</div>
									<div class="col-2">${r.roomName}</div>
									<div class="col-2">${r.leaderNickname}</div>
									<div class="col-1">${r.totalMember}명</div>
									<c:choose>
										<c:when test="${r.statusName == '출석 완료'}">
											<div class="col-2"><span class="status-done">출석</span></div>
											<div class="col-2">-</div>
										</c:when>
										<c:when test="${r.statusName == '노쇼'}">
											<div class="col-2"><span class="status-noshow">노쇼</span></div>
											<div class="col-2">-</div>
										</c:when>
										<c:otherwise>
											<div class="col-2"><span class="status-wait">대기</span></div>
											<div class="col-2">
												<form id="attendForm-${r.reservationId}"
												      action="${pageContext.request.contextPath}/owner/attendance/attend"
												      method="post" style="display:inline">
													<input type="hidden" name="reservationId"  value="${r.reservationId}">
													<input type="hidden" name="leaderId"       value="${r.leaderId}">
													<input type="hidden" name="attendStatusId" value="1">
													<button type="button" class="btn btn-primary"
													        onclick="attendOk('attendForm-${r.reservationId}')">출석</button>
												</form>
												<form id="noshowForm-${r.reservationId}"
												      action="${pageContext.request.contextPath}/owner/attendance/attend"
												      method="post" style="display:inline">
													<input type="hidden" name="reservationId"  value="${r.reservationId}">
													<input type="hidden" name="leaderId"       value="${r.leaderId}">
													<input type="hidden" name="attendStatusId" value="2">
													<button type="button" class="btn ne-btn-deact"
													        onclick="noshowOk('noshowForm-${r.reservationId}')">노쇼</button>
												</form>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
							<c:if test="${empty attendList}">
								<div class="text-center py-3">조회된 예약이 없습니다.</div>
							</c:if>
						</div>
						<div class="paginate">							
							<span class="active">1</span>
							<a href="#">2</a>
							<a href="#">3</a>					
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
