<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 테마 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/dist/css/common.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex">
			<aside class="col-md-2">
					<%@ include file="/WEB-INF/views/common/ownerSide.jsp"%>
			</aside>
			<div class="col-md-10 resWrap">
				<div class="title">테마 관리</div>
				<div class="d-flex justify-content-between">
					<div class="resList" style="width:100%">
						<div class="inputBox d-flex justify-content-end">
							<a href="${pageContext.request.contextPath}/owner/theme/write?mode=write"
							   class="btn btn-outline-dark">테마 등록</a>
						</div>
						<div class="theme-list">

							<div class="row fw-bold border-bottom py-2 m-0">
								<div class="col-1">번호</div>
								<div class="col-2">카페</div>
								<div class="col-3">테마명</div>
								<div class="col-2">장르</div>
								<div class="col-2">가격</div>
								<div class="col-2"></div>
							</div>

							<c:forEach var="t" items="${themeList}" varStatus="st">
								<div class="row align-items-center border-bottom py-2 m-0">
									<div class="col-1">${st.count}</div>
									<div class="col-2">${t.cafeName}</div>
									<div class="col-3">${t.themeName}</div>
									<div class="col-2">${t.genre}</div>
									<div class="col-2"><fmt:formatNumber value="${t.price}" pattern="#,###"/>원</div>
									<div class="col-2">
										<a href="${pageContext.request.contextPath}/owner/theme/write?mode=update&roomId=${t.themeId}"
										   class="btn btn-sm btn-primary">수정</a>
										 <button type="button" class="btn btn-sm btn-danger"
            									 onclick="openDropModal(${t.themeId}, '${t.themeName}')">삭제</button>   
									</div>
								</div>
							</c:forEach>
							<c:if test="${empty themeList}">
								<div class="text-center py-3">등록된 테마가 없습니다.</div>
							</c:if>
						</div>

						${dataCount == 0 ? "" : paging}

					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- 테마 삭제 모달 -->
	<div class="modal fade" id="themeDropModal" tabindex="-1">
  	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
     	 <div class="modal-header">
      	  <h6 class="modal-title fw-bold">테마 삭제</h6>
       	 <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
     	 </div>
     	 <form id="themeDropForm" action="${pageContext.request.contextPath}/owner/theme/drop" method="post">
       		<div class="modal-body">
         	 <p>
           	 <strong id="dropThemeName"></strong> 테마를 삭제하시겠습니까?<br>
           	 <span class="text-muted small">삭제 후에는 복구할 수 없습니다.</span>
          	</p>
         	 <input type="hidden" name="themeId" id="dropThemeId">
         	 <div class="mb-2">
         	   <label for="dropReasonId" class="form-label">삭제 사유</label>
        	    <select id="dropReasonId" name="dropReasonId" class="form-select" required>
         	     <option value="">-- 사유 선택 --</option>
         	     <c:forEach var="r" items="${reasonList}">
         	       <option value="${r.dropReasonId}">${r.dropReasonName}</option>
         	     </c:forEach>
         	   </select>
      	    </div>
     	   </div>
       	 <div class="modal-footer">
       	   <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
       	   <button type="submit" class="btn btn-danger btn-sm">삭제</button>
      	  </div>
     	 </form>
   	 </div>
  	</div>
	</div>

<script>
function openDropModal(themeId, themeName) {
    document.getElementById('dropThemeId').value = themeId;
    document.getElementById('dropThemeName').innerText = themeName;
    document.getElementById('dropReasonId').value = '';
    new bootstrap.Modal(document.getElementById('themeDropModal')).show();
}
</script>	
	

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
