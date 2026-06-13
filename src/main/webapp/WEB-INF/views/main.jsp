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
<body style="background-color: #fff !important;">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content">
		<div class="slider">
			<div class="sliderContent">
				함께 즐길 파티원을 찾고 계신가요?<br>
				NoExit에서 파티를 만들어 플레이하세요!<br>
				<p>빠르고 쉽게 파티를 모으고, 원하는 테마를 바로 예약하세요!<br>
				   리뷰와 기록까지, 당신의 완벽한 방탈출 여정을 함께합니다.
				</p>
				<button class="btn btn-primary">파티 매칭하러 가기</button>
			</div>			
		</div>
		<div class="ne-container ne-card mainWrap">
			<div class="themeWrap">
				<div class="title">인기 테마</div>
				<div class="more">
					<a href="${pageContext.request.contextPath }/theme/list">
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-arrow-right-circle" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8m15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0M4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5z"/>
						</svg>
					 </a>
				</div>
				
				<div class="theme d-flex justify-content-around ">
					<c:forEach var="theme" items="${themeList }">
						<div class="d-flex flex-column themeBox ne-card-hover ne-card" onclick="location.href='${pageContext.request.contextPath}/theme/info/${theme.roomId }'">
							<img src="${pageContext.request.contextPath }/dist/images/${theme.roomImg}" alt="" />
							<div class="badgeWrap">
								<span class="ne-tag ne-tag-dark ne-tag-sm">${theme.genreName }</span>
								<c:if test="${theme.isAdult==1 }">
									<span class="ne-tag ne-tag-red ne-tag-sm">성인</span>
								</c:if>
							</div>
							<div class="themeTitle">
								${theme.roomName }
								<span class="sm">${theme.cafeName }</span>
							</div>
							<div class="review"><span>★ </span>${theme.avgGrade }</div>
						</div>	
					</c:forEach>
				</div>
			</div>
			<div class="partyWrap">
				<div class="title">신규 파티</div>
				<div class="more">
					<a href="${pageContext.request.contextPath }/party/list">
					<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-arrow-right-circle" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8m15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0M4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5z"/>
					</svg>
					</a>
				</div>
				<div class="party d-flex justify-content-around ">
					<c:forEach var="party" items="${partyList }">
						<div class="d-flex flex-column partyBox ne-card ne-card-hover ne-card-top" onclick="location.href='${pageContext.request.contextPath}/party/info/${party.partyId }'">
							<div class="d-flex justify-content-between mb-2">
								<div class="subject">
									${party.partyName }
								</div>
								<div>
									<span class="ne-tag ne-tag-sm ${party.partyCnt >= party.maxPlayers?'ne-tag-red':'ne-tag-blue' }" style="width: 62px; text-align: center;">
										${party.partyCnt >= party.maxPlayers?'모집 마감':'모집중' }
									</span>
								</div>
							</div>
							<div class="mb-3">
								<div class="name">${party.roomName }<span class="sm">${party.cafeName } · ${party.openAt }</span> </div>
							</div>
							<div class="d-flex justify-content-between">
								<div class="ne-tag ne-tag-green"> ${party.avgTemp }℃</div>
								<div class="detail"><span>${party.partyCnt }</span> / ${party.maxPlayers }명</div>
							</div>
						</div>
					</c:forEach>
					<!-- <div class="d-flex flex-column partyBox ne-card ne-card-hover ne-card-top" onclick="">
						<div class="d-flex justify-content-between mb-2">
							<div class="subject">
								같이 탈출하실 분! 빠른 탈출 희망합니다 스겜하실 분
							</div>
							<div>
								<span class="ne-tag ne-tag-blue ne-tag-sm">모집중</span>
							</div>
						</div>
						<div class="mb-3">
							<div class="name">어둠의 저택<span class="sm">지구별 · 2026-06-12 12:30 </span> </div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="ne-tag ne-tag-green"> 36.4℃</div>
							<div class="detail"><span>2</span> / 6명</div>
						</div>
					</div>
					<div class="d-flex flex-column partyBox ne-card ne-card-hover ne-card-top" onclick="">
						<div class="d-flex justify-content-between mb-2">
							<div class="subject">
								같이 탈출하실 분! 빠른 탈출 희망합니다 스겜하실 분
							</div>
							<div>
								<span class="ne-tag ne-tag-blue ne-tag-sm">모집중</span>
							</div>
						</div>
						<div class="mb-3">
							<div class="name">어둠의 저택<span class="sm">지구별 · 2026-06-12 12:30 </span> </div>
						</div>
						<div class="d-flex justify-content-between">
							<div class="ne-tag ne-tag-green"> 36.4℃</div>
							<div class="detail"><span>2</span> / 6명</div>
						</div>
					</div> -->
				
				</div>
			</div>
		
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>