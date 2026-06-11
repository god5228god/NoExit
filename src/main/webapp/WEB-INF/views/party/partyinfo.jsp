<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partyinfo.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

/* ── 레이아웃 ──────────────────────────────────── */
.container {
	display: flex;
	gap: 1.5rem;
	padding: 2rem 0;
	align-items: flex-start;
}
.party-info-wrap { flex: 1; }
.party-apply-wrap { width: 320px; flex-shrink: 0; }

/* ── 파티 정보 ─────────────────────────────────── */
.party-name {
	font-size: 1.4rem;
	font-weight: 800;
	margin-bottom: 1rem;
	display: flex;
	align-items: center;
	gap: .5rem;
	flex-wrap: wrap;
}

/* 테마 정보 칩 라인 */
.theme-info {
	display: flex;
	flex-wrap: wrap;
	gap: .4rem;
	margin-bottom: 1rem;
}
.theme-info .ne-tag { font-weight: 600; }

/* 파티 조건 */
.party-condition {
	margin-bottom: 1.25rem;
}
.party-condition .party-comment {
	margin-top: .6rem;
	padding: .75rem 1rem;
	background: var(--ne-bg);
	border-radius: var(--ne-radius-sm);
	font-size: .88rem;
	line-height: 1.6;
	color: var(--ne-text-2);
}

/* 파티 현황 */
.party-crew { display: flex; flex-direction: column; gap: .4rem; }
.crew {
	display: grid;
	grid-template-columns: 1fr auto auto auto auto;
	align-items: center;
	gap: .75rem;
	padding: .7rem 1rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-sm);
	font-size: .88rem;
}
.crew .crew-name { font-weight: 700; }
.crew .crew-sub { color: var(--ne-text-2); font-size: .84rem; }

/* ── 파티 신청 (사이드 카드) ───────────────────── */
.party-apply-wrap .apply-comment {
	width: 100%;
	padding: .55rem .8rem;
	border: 1.5px solid var(--ne-border-dark);
	border-radius: var(--ne-radius-sm);
	font-size: .9rem;
	color: var(--ne-text);
	margin-bottom: .8rem;
	transition: border-color .15s, box-shadow .15s;
}
.party-apply-wrap .apply-comment:focus {
	outline: none;
	border-color: var(--ne-primary);
	box-shadow: 0 0 0 .2rem rgba(253, 180, 0, .2);
}
.party-apply-wrap .btn { width: 100%; }

</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript">

	document.addEventListener("DOMContentLoaded",function()
	{
		const applyComment = document.querySelector("[name='applyComment']");

		if(applyComment)
		{
			applyComment.addEventListener("keydown",function(evt)
			{
				if(evt.key == "Enter")
				{
					evt.preventDefault();

					partyApply();
				}
			});
		}
	});

	function partyApply()
	{
		const f = document.partyApplyForm;

		let comment = f.applyComment.value.trim();

		if(!comment)
		{
			alert("신청 메시지를 작성하세요");
			f.applyComment.focus();
			return;
		}

		if(!confirm("신청하시겠습니까?"))
		{
			return;
		}

		f.action = "${path}/party/apply/${dto.partyId}";

		f.submit();
	}

</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">

				<!-- 파티 정보 -->
				<div class="party-info-wrap">

					<div class="ne-sc">

						<div class="ne-sc-title">파티 정보</div>

						<div class="party-name">
							${dto.partyName }
							<c:choose>
								<c:when test="${dto.slotStatus == 1 }">
									<span class="ne-st ne-st-sm ne-st-green">예약 가능</span>
								</c:when>
								<c:otherwise>
									<span class="ne-st ne-st-sm ne-st-gray">예약 불가</span>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="theme-info">
							<span class="ne-tag ne-tag-sm">${dto.cafeName }</span>
							<span class="ne-tag ne-tag-sm">${dto.themeName }</span>
							<span class="ne-tag ne-tag-sm">${dto.resDate }</span>
							<span class="ne-tag ne-tag-sm">${dto.resTime }</span>
							<span class="ne-tag ne-tag-sm">${dto.minPlayers }명 ~ ${dto.maxPlayers }명</span>
							<span class="ne-tag ne-tag-sm ne-tag-primary"><fmt:formatNumber value="${dto.price }" pattern="#,###"/>원</span>
						</div>

						<div class="party-condition">
							<span class="ne-tag ne-tag-sm">${dto.genderName }</span>
							<c:if test="${not empty dto.partyComment }">
								<div class="party-comment">${dto.partyComment }</div>
							</c:if>
						</div>

						<div class="ne-divider"></div>

						<div class="party-crew">

							<div class="ne-title">파티 현황</div>

							<c:forEach var="crew" items="${crewList }">

								<div class="crew">
									<span class="crew-name">${crew.nickName }</span>
									<span class="crew-sub">${crew.age }세</span>
									<span class="crew-sub">
									<c:choose>
										<c:when test="${crew.gender == 'F' }">여</c:when>
										<c:when test="${crew.gender == 'M' }">남</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
									</span>
									<span class="ne-mannero">🌡️ ${crew.temp }</span>

									<c:choose>
										<c:when test="${crew.position == 'HOST' }">
											<span class="ne-st ne-st-sm ne-st-dark">파티장</span>
										</c:when>
										<c:otherwise>
											<span class="ne-st ne-st-sm ne-st-primary">파티원</span>
										</c:otherwise>
									</c:choose>

								</div>

							</c:forEach>

						</div>

					</div>

				</div> <!-- .party-info-wrap -->

				<!-- 파티 신청 -->
				<c:if test="${dto.partyStatus == 'open'}">

					<div class="party-apply-wrap">

						<div class="ne-sc ne-sticky">

							<div class="ne-sc-title">파티 신청</div>

							<form action="" name="partyApplyForm" method="post">
								<input type="text" class="apply-comment" placeholder="신청 메시지" name="applyComment" maxlength="30">
							</form>

							<button type="button" class="btn btn-primary" onclick="partyApply()">신청하기</button>

						</div>

					</div> <!-- .party-apply-wrap -->

				</c:if>

			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
