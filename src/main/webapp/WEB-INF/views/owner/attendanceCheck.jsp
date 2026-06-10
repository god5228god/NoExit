<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 출석체크 확인</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/attendance.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex">
					<%@ include file="/WEB-INF/views/common/ownerSide.jsp"%>
			<div class="col-md-10 resWrap">
				<div class="title">출석 체크</div>
				<div class="d-flex justify-content-between">
					<div class="resList" style="width:100%">
						<form action="${pageContext.request.contextPath}/owner/attendance/saveDraft" method="post">
							<input type="hidden" name="reservationId" value="${reservationId}">

							<div class="attend-list">

								<div class="row fw-bold border-bottom py-2 m-0">
									<div class="col-4">닉네임</div>
									<div class="col-3">역할</div>
									<div class="col-5">출석 여부</div>
								</div>

								<c:forEach var="c" items="${crewList}">
									<div class="row align-items-center border-bottom py-2 m-0">
										<div class="col-4">${c.nickname}</div>
										<div class="col-3">
											<c:choose>
												<c:when test="${c.position == 'HOST'}">파티장</c:when>
												<c:otherwise>파티원</c:otherwise>
											</c:choose>
										</div>
										<div class="col-5">
											<input type="hidden" name="userIds" value="${c.userId}">
											<select name="attendStatusIds" class="form-select">
												<option value="" ${empty c.attendStatusId ? 'selected' : ''}>미정</option>
												<option value="1" ${c.attendStatusId eq 1 ? 'selected' : ''}>출석</option>
												<option value="2" ${c.attendStatusId eq 2 ? 'selected' : ''}>노쇼</option>
											</select>
										</div>
									</div>
								</c:forEach>
								<c:if test="${empty crewList}">
									<div class="text-center py-3">파티원이 없습니다.</div>
								</c:if>
							</div>

							<div class="text-end mt-4">
								<button type="submit" class="btn btn-primary"
								        onclick="return confirm('이대로 저장하시겠습니까?');">확인</button>
								<a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/owner/attendance">취소</a>
							</div>
						</form>
					</div>
				</div>
			</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
