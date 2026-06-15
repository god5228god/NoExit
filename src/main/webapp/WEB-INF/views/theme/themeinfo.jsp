<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>themeinfo.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

/* ── 페이지 레이아웃 ───────────────────────────── */
.container {
	display: flex;
	flex-direction: column;
	gap: 1.5rem;
	padding: 2rem 0;
}

/* ── 테마 정보 (이미지 + 정보) ─────────────────── */
.theme-info-wrap {
	display: grid;
	grid-template-columns: 2fr 3fr;
	gap: 1.5rem;
	align-items: stretch;
}

.theme-image {
	border-radius: var(--ne-radius);
	overflow: hidden;
	border: 1px solid var(--ne-border);
	background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
}
.theme-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.theme-info {
	display: flex;
	flex-direction: column;
	gap: .35rem;
}

.theme-title {
	font-size: 1.4rem;
	font-weight: 800;
	margin: 0 0 .25rem;
	display: flex;
	align-items: center;
	gap: .5rem;
	flex-wrap: wrap;
}

.info-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: .5rem .9rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-sm);
	font-size: .9rem;
}
.info-item > span:first-child {
	color: var(--ne-text-2);
	font-weight: 600;
	font-size: .84rem;
}
.info-item > span:last-child {
	font-weight: 600;
}
.info-item .ne-star { color: var(--ne-primary); letter-spacing: 1px; }

/* ── 테마 소개 ─────────────────────────────────── */
.theme-description p {
	margin: 0;
	padding: 1rem 1.25rem;
	background: var(--ne-primary-light);
	border: 1.5px solid var(--ne-primary-mid);
	border-radius: var(--ne-radius-md);
	font-size: .9rem;
	line-height: 1.7;
	color: #7a4f00;
}

/* ── 예약 슬롯 ─────────────────────────────────── */
.slot {
	display: flex;
	align-items: flex-start;
	gap: 1.25rem;
	padding: .9rem 1.1rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-md);
	margin-bottom: .6rem;
}
.slot-date {
	font-weight: 800;
	font-size: .9rem;
	min-width: 95px;
	padding-top: .35rem;
	color: var(--ne-text);
}
.slot-time {
	display: flex;
	flex-wrap: wrap;
	gap: .5rem;
}
.slot-time .slot-btn {
	padding: .45rem .9rem;
	border: 1.5px solid var(--ne-border-dark);
	border-radius: var(--ne-radius-sm);
	background: #ffffff;
	font-size: .84rem;
	font-weight: 600;
	color: var(--ne-text-2);
	cursor: pointer;
	transition: all .13s;
	line-height: 1.3;
}
.slot-time .slot-btn:hover {
	border-color: var(--ne-primary);
	background: var(--ne-primary-light);
	color: var(--ne-primary-dark);
}
.slot-time .slot-off {
	padding: .45rem .9rem;
	border: 1.5px solid var(--ne-border);
	border-radius: var(--ne-radius-sm);
	background: var(--ne-bg);
	font-size: .84rem;
	color: var(--ne-text-3);
	line-height: 1.3;
	cursor: not-allowed;
}

/* ── 리뷰 ──────────────────────────────────────── */
.review-wrap {
	display: flex;
	flex-direction: column;
	gap: .75rem;
}
.review-total { max-width: 360px; }

.review {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: .87rem;
	padding: .25rem 0;
}
.review > span:first-child { color: var(--ne-text-2); }
.review .ne-star { color: var(--ne-primary); letter-spacing: 1px; }

.review-list {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: .75rem;
}
.review-list .ne-sc { margin-bottom: 0; }

.comment p {
	margin: .6rem 0 0;
	padding: .6rem .8rem;
	font-size: .84rem;
	line-height: 1.6;
	color: var(--ne-text-2);
	background: var(--ne-bg);
	border-radius: var(--ne-radius-sm);
}

</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$(".slot-btn").click(function()
		{
			window.location.href = "${path}/party/write?slotId=" + this.getAttribute("data-slot");
		});

	});

</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">

				<!-- 테마 정보 -->
				<div class="theme-info-wrap">

					<div class="theme-image">
						<img src="${pageContext.request.contextPath}/dist/images/${dto.imagePath}" alt="${dto.themeName }">
					</div>

					<div class="theme-info">

						<h1 class="theme-title">
							${dto.themeName }
							<span class="ne-tag ne-tag-sm ne-tag-primary">${dto.genre }</span>
							<c:if test="${dto.adult == 1 }">
								<span class="ne-st ne-st-sm ne-st-red">성인 전용</span>
							</c:if>
						</h1>

						<div class="info-item">
							<span>카페명</span>
							<span>${dto.cafeName }</span>
						</div>

						<div class="info-item">
							<span>카페 위치</span>
							<span>${dto.cafeLocation }</span>
						</div>

						<div class="info-item">
							<span>전화번호</span>
							<span>${dto.cafePhone }</span>
						</div>

						<div class="info-item">
							<span>테마 시간</span>
							<span>${dto.duration }분</span>
						</div>

						<div class="info-item">
							<span>난이도</span>
							<span class="ne-star" style="color: #dec316;">
							<c:forEach begin="1" end="${dto.difficulty }">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
							</c:forEach>
							
							<c:forEach begin="${dto.difficulty +1}" end="5">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
							</c:forEach></span>
						</div>

						<div class="info-item">
							<span>공포도</span>
							<span class="ne-star" style="color: #dec316;">
							<c:forEach begin="1" end="${dto.horror }">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
							</c:forEach>
							
							<c:forEach begin="${dto.horror +1}" end="5">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
							</c:forEach></span>
						</div>

						<div class="info-item">
							<span>활동도</span>
							<span class="ne-star" style="color: #dec316;">
							<c:forEach begin="1" end="${dto.activity }">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
							</c:forEach>
							
							<c:forEach begin="${dto.activity +1}" end="5">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
							</c:forEach></span>
						</div>

						<div class="info-item">
							<span>가격</span>
							<span><fmt:formatNumber value="${dto.price }" pattern="#,###"/>원</span>
						</div>

						<div class="info-item">
							<span>인원</span>
							<span>${dto.minPlayers }명 ~ ${dto.maxPlayers }명</span>
						</div>

					</div>
				</div>

				<!-- 테마 소개 -->
				<div class="theme-description">
					<div class="ne-title">테마 소개</div>
					<p>${dto.description }</p>
				</div>

				<!-- 예약 목록 -->
				<div class="slot-list">

					<div class="ne-title">예약 목록</div>

					<c:forEach var="date" items="${slot }">

						<div class="slot">

							<div class="slot-date">${date.key }</div>

							<div class="slot-time">

							<c:forEach var="time" items="${date.value }">

								<c:choose>
									<c:when test="${time.status == 1 }">
										<button type="button" data-slot="${time.slotId }" class="slot-btn">
											${time.resTime }
										</button>
									</c:when>
									<c:otherwise>
										<span class="slot-off">${time.resTime }</span>
									</c:otherwise>
								</c:choose>

							</c:forEach>

							</div>

						</div>

					</c:forEach>

					<c:if test="${empty slot }">
						<div class="ne-empty">
							<div class="ne-empty-title">예약 가능한 시간이 없습니다</div>
							<div class="ne-empty-desc">다른 날짜를 확인해 주세요.</div>
						</div>
					</c:if>

				</div>

				<!-- 리뷰 -->
				<div class="review-wrap">
	
					<c:if test="${not empty review }">
	
					<div class="ne-title">리뷰</div>

					<div class="review-total">

						<div class="ne-sc">
							<div class="ne-sc-title">리뷰 통계 (${count }개)</div>

							<div class="review">
								<span>만족도</span>
								<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${total.satisfaction }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${total.satisfaction +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
							</div>

							<div class="review">
								<span>체감난이도</span>
								<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${total.difficulty }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${total.difficulty +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
							</div>

							<div class="review">
								<span>체감공포도</span>
								<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${total.horror }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${total.horror +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
							</div>

							<div class="review">
								<span>체감활동도</span>
								<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${total.activity }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${total.activity +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
							</div>

							<div class="review">
								<span>몰입도</span>
								<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${total.immersion }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${total.immersion +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
							</div>

						</div>

					</div>
				</c:if>
					<div class="review-list">

						<c:forEach var="dto" items="${review }">

							<div class="ne-sc">
								<div class="ne-sc-title">${dto.nickName }</div>

								<div class="review">
									<span>만족도</span>
									<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${dto.satisfaction }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${dto.satisfaction +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
								</div>

								<div class="review">
									<span>체감난이도</span>
									<span class="ne-star" style="color: #dec316;">
								<c:forEach begin="1" end="${dto.difficulty }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
								</c:forEach>
								
								<c:forEach begin="${dto.difficulty +1}" end="5">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
								</c:forEach></span>
								</div>

								<div class="review">
									<span>체감공포도</span>
									<span class="ne-star" style="color: #dec316;">
									<c:forEach begin="1" end="${dto.horror }">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
									</c:forEach>
									
									<c:forEach begin="${dto.horror +1}" end="5">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
									</c:forEach></span>
								</div>

								<div class="review">
									<span>체감활동도</span>
									<span class="ne-star" style="color: #dec316;">
									<c:forEach begin="1" end="${dto.activity }">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
									</c:forEach>
									
									<c:forEach begin="${dto.activity +1}" end="5">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
									</c:forEach></span>
								</div>

								<div class="review">
									<span>몰입도</span>
									<span class="ne-star" style="color: #dec316;">
									<c:forEach begin="1" end="${dto.immersion }">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16"> <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/></svg>
									</c:forEach>
									
									<c:forEach begin="${dto.immersion +1}" end="5">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16"><path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/></svg>
									</c:forEach></span>
								</div>

								<div class="comment">
									<p>${dto.reviewComment }</p>
								</div>

							</div>

						</c:forEach>

						<c:if test="${empty review }">
							<div class="ne-empty" style="grid-column: 1 / -1;">
								<div class="ne-empty-title">아직 작성된 리뷰가 없습니다</div>
							</div>
						</c:if>

					</div>

				</div>

			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
