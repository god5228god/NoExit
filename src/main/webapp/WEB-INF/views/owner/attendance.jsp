<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석체크</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/attendance.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex">
			<aside class="col-md-2">
					<%@ include file="/WEB-INF/views/common/ownerSide.jsp"%>
			</aside>
			<div class="col-md-10 resWrap">	
				<div class="title ">출석 체크 현황</div>						
					<div class="d-flex justify-content-between">						
   					 <div class="resList" style="width:100%">
       					 <div class="inputBox d-flex justify-content-end">					 	
         					   <a href="${pageContext.request.contextPath}/owner/attendance/history"
            					   class="btn btn-outline-dark">출석기록</a>
       					 </div>
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
											<div class="col-2"><span class="status-done">출석처리 완료</span></div>
											<div class="col-2">-</div>
										</c:when>
										<c:when test="${r.statusName == '노쇼'}">
											<div class="col-2"><span class="status-noshow">노쇼</span></div>
											<div class="col-2">-</div>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${doneList.contains(r.reservationId)}">
													<div class="col-2"><span class="status-done">입력 완료</span></div>
													<div class="col-2">
														<a class="btn btn-sm btn-outline-secondary"
														   href="${pageContext.request.contextPath}/owner/attendance/check?reservationId=${r.reservationId}">다시 입력</a>
													</div>
												</c:when>
												<c:when test="${partialList.contains(r.reservationId)}">
													<div class="col-2"><span class="status-wait">출석 미완료</span></div>
													<div class="col-2">
														<a class="btn btn-sm btn-outline-warning"
														   href="${pageContext.request.contextPath}/owner/attendance/check?reservationId=${r.reservationId}">이어서 입력</a>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col-2"><span class="status-wait">대기</span></div>
													<div class="col-2">
														<a class="btn btn-primary"
														   href="${pageContext.request.contextPath}/owner/attendance/check?reservationId=${r.reservationId}">출석체크확인</a>
													</div>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
							<c:if test="${empty attendList}">
								<div class="text-center py-3">조회된 예약이 없습니다.</div>
							</c:if>
						</div>

						<c:if test="${not empty doneList}">
							<form action="${pageContext.request.contextPath}/owner/attendance/finalize" method="post" class="text-end mt-3">
								<button type="submit" class="btn btn-primary"
								        onclick="return confirm('입력한 출석 내용을 최종 저장하시겠습니까?');">
									최종 확인 (${doneList.size()}건)
								</button>
							</form>
						</c:if>

						${dataCount == 0 ? "" : paging}
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
