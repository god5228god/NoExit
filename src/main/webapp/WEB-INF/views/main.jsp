<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath }/dist/css/main.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content">
		<div class="slider">
			같이 방탈출 할 사람을 
			찾고 있나요?
			
		</div>
		<div class="ne-container ne-card mainWrap">
			
			<div class="themeWrap">
				<div class="title">인기 테마</div>
				<div class="theme"></div>
			</div>
			<div class="partyWrap">
				<div class="title">모집 중인 파티</div>
				<div class="party"></div>
			</div>
		
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>