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
			<div class="sliderContent">
				같이 방탈출?
			</div>			
		</div>
		<div class="ne-container ne-card mainWrap">
			
			<div class="themeWrap">
				<div class="title">인기 테마</div>
				<div class="more">
					<a href="">▶ 더보기</a>
				</div>
				<div class="theme d-flex justify-content-around ">
					<div class="d-flex flex-column themeBox" onclick="">
						<img src="http://placehold.co/230x250" alt="" />
						<div class="badgeWrap">
							<span class="ne-tag ne-tag-dark ne-tag-sm">스릴러</span>
							<span class="ne-tag ne-tag-red ne-tag-sm">성인</span>
						</div>
						<div class="themeTitle">
							어둠의 저택
							<span class="sm">방탈출 공장</span>
						</div>
					</div>
					<div class="d-flex flex-column themeBox" onclick="">
						<img src="http://placehold.co/230x250" alt="" />
						<div class="badgeWrap">
							<span class="ne-tag ne-tag-dark ne-tag-sm">스릴러</span>
						</div>
						<div class="themeTitle">
							어둠의 저택
							<span class="sm">방탈출 공장</span>
						</div>
					</div>
					<div class="d-flex flex-column themeBox" onclick="">
						<img src="http://placehold.co/230x250" alt="" />
						<div class="badgeWrap">
							<span class="ne-tag ne-tag-dark ne-tag-sm">공포</span>
							<span class="ne-tag ne-tag-red ne-tag-sm">성인</span>
						</div>
						<div class="themeTitle">
							어둠의 저택
							<span class="sm">방탈출 공장</span>
						</div>
					</div>
					<div class="d-flex flex-column themeBox" onclick="">
						<img src="http://placehold.co/230x250" alt="" />
						<div class="badgeWrap">
							<span class="ne-tag ne-tag-dark ne-tag-sm">드라마</span>
						</div>
						<div class="themeTitle">
							어둠의 저택
							<span class="sm">방탈출 공장</span>
						</div>
					</div>
				</div>
			</div>
			<div class="partyWrap">
				<div class="title">모집 중인 파티</div>
				<div class="more">
					<a href="">▶ 더보기</a>
				</div>
				<div class="party">
					<div class="d-flex flex-column partyBox" onclick="">
						파티명
					</div>	
				
				</div>
			</div>
		
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>