<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 매니저관리</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/manager.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">

	function deactOk(formId){
		if(confirm('정말 비활성화 하시겠습니까?')){
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
				<div class="title">매니저 관리</div>
				<div class="d-flex justify-content-between">
					<div class="resList" style="width:100%">
						<div class="inputBox d-flex justify-content-end">
							<a href="${pageContext.request.contextPath}/owner/manager/enroll"
							   class="btn btn-outline-dark">매니저 등록</a>
						</div>
						<div class="manager-list">
							
							<div class="row fw-bold border-bottom py-2 m-0">
								<div class="col-1">번호</div>
								<div class="col-2">이름</div>
								<div class="col-2">담당 카페</div>
								<div class="col-2">연락처</div>
								<div class="col-2">입사일</div>
								<div class="col-1">상태</div>
								<div class="col-2"></div>
							</div>
							
							<c:forEach var="m" items="${managerList}" varStatus="st">
								<div class="row align-items-center border-bottom py-2 m-0">
									<div class="col-1">${st.count}</div>
									<div class="col-2">${m.name}</div>
									<div class="col-2">${m.cafeName}</div>
									<div class="col-2">${m.phone}</div>
									<div class="col-2"><fmt:formatDate value="${m.createdAt}" pattern="yyyy-MM-dd"/></div>
									<div class="col-1"><span class="status-active">활성</span></div>
									<div class="col-2">
										<form id="deactForm-${m.managerHistoryId}"
										      action="${pageContext.request.contextPath}/owner/manager/deact"
										      method="post" style="display:inline">
											<input type="hidden" name="cafeId" value="${m.cafeId}">
											<input type="hidden" name="userId" value="${m.userId}">
											<button type="button" class="btn btn-sm ne-btn-deact"
											        onclick="deactOk('deactForm-${m.managerHistoryId}')">비활성화</button>
										</form>
									</div>
								</div>
							</c:forEach>
							<c:if test="${empty managerList}">
								<div class="text-center py-3">등록된 매니저가 없습니다.</div>
							</c:if>
						</div>

						${dataCount == 0 ? "" : paging}

					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
