<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testCss</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href='${pageContext.request.contextPath }/dist/css/common.css'>
</head>
<body>
<%-- Bootstrap 버튼 그대로 사용, 색상만 자동으로 우리 컬러 ---%>
<button class="btn btn-primary">확인</button>
<button class="btn btn-outline-primary">취소</button>
<button class="btn ne-btn-deact">비활성</button>

<%-- 커스텀 상태 뱃지 ---%>
<%-- 기본 (14px) ---%>
<span class="ne-st ne-st-green">모집중</span>
<span class="ne-st ne-st-blue">예약완료</span>
<span class="ne-st ne-st-amber">대기중</span>
<span class="ne-st ne-st-red">취소됨</span>
<span class="ne-st ne-st-danger">강제취소</span>  <%-- 빨간 채움 ---%>
<span class="ne-st ne-st-gray">종료</span>

<%-- 테이블 안에서 좁게 ---%>
<span class="ne-st ne-st-sm ne-st-blue">예약완료</span>

<%-- 페이지 상단 크게 ---%>
<span class="ne-st ne-st-lg ne-st-green">모집중</span>


<%-- 사이드바 ---%>
<nav class="ne-side-nav">
  <a href="/mypage/reservations" class="active">예약 현황</a>
  <a href="/mypage/parties">매칭 목록</a>
</nav>

<%-- 섹션 카드 ---%>
<div class="ne-sc">
  <div class="ne-sc-title">예약자 정보</div>
  어쩌고저쩌고  
</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>
</body>
</html>