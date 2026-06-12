<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myparty.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

/* ── 레이아웃 ──────────────────────────────────── */
.container {
	display: flex;
	flex-direction: column;
	gap: 1.25rem;
	padding: 1.5rem 0;
}

.header { text-align: center; }
.header .title { font-weight: 800; font-size: 1.4rem; }

/* 2×2 그리드 — 위: 활성 / 아래: 비활성 */
.body {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 1.25rem;
}

/* 각 패널 (ne-sc 위에 고정 높이만 부여) */
.body > div {
	height: 420px;
	display: flex;
	flex-direction: column;
	gap: .5rem;
}
.panel-title {
	display: flex;
	align-items: center;
	gap: .4rem;
	font-weight: 700;
	font-size: .92rem;
	color: var(--ne-text);
	padding-bottom: .5rem;
	margin-bottom: .25rem;
	border-bottom: 2px solid var(--ne-primary);
}

/* ── 리스트 ────────────────────────────────────── */
.apply-list,
.current-party-list,
.end-party-list,
.kick-party-list {
	display: flex;
	flex-direction: column;
	gap: .5rem;
	overflow-y: auto;
	flex: 1;
}

.apply-item,
.current-item,
.end-item,
.kick-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: .5rem;
	padding: .65rem .85rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-sm);
}

/* 비활성(종료·강퇴) 항목은 살짝 차분하게 */
.end-item,
.kick-item { background: var(--ne-bg); }

.apply-info,
.current-info,
.end-info,
.kick-info {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: .3rem .55rem;
	font-size: .84rem;
	min-width: 0;
}
.apply-info span:first-child,
.current-info span:first-child,
.end-info span:first-child,
.kick-info span:first-child {
	font-weight: 700;
	color: var(--ne-text);
}
.apply-info span,
.current-info span,
.end-info span,
.kick-info span { color: var(--ne-text-2); }

/* ── 액션 버튼 ─────────────────────────────────── */
.action-btn {
	flex-shrink: 0;
	border: 1.5px solid var(--ne-border-dark);
	border-radius: var(--ne-radius-sm);
	padding: .3rem .7rem;
	font-size: .8rem;
	font-weight: 600;
	color: var(--ne-text-2);
	background: #ffffff;
	cursor: pointer;
	transition: all .13s;
}
.action-btn:hover {
	border-color: var(--ne-primary);
	background: var(--ne-primary-light);
	color: var(--ne-primary-dark);
}
/* 취소 등 부정 액션 */
.action-btn.danger {
	border-color: #fca5a5;
	color: var(--ne-red);
}
.action-btn.danger:hover {
	background: var(--ne-red-bg);
	color: var(--ne-red);
}

.main-body {
		display: flex;                		
		width: 100%;
		box-sizing: border-box;
		padding-left: 2rem;
		padding-right: 2rem;
		gap: 1.5rem;
	}

	.main-content {
		flex-grow: 1;
		min-width: 0;
	}
	
	.right-sidebar {
		width: 340px;                    
		flex-shrink: 0;                  
		display: flex;
		flex-direction: column;
	}
	
	.record-item-body {
		display: flex;
		gap: 1.5rem;
		align-items: center;
	}
	
	.clickable-card {
		cursor: pointer;
		transition: transform 0.2s, box-shadow 0.2s;
	}
	.clickable-card:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(0,0,0,0.08);
	}
	
	.ne-sc-title {
		display: flex;
		justify-content: space-between;
	}

</style>

<c:set var="path" value="${pageContext.request.contextPath }" />

<script type="text/javascript">
	
	function applyCancel(btn)
	{
		if(confirm("신청 취소하시겠습니까?"))
		{
			window.location.href = "${path}/party/apply/cancel/" + btn.value;		
		}
	}
	
	function onBoard(btn)
	{
		window.location.href = "${path}/party/board/" + btn.value;
	}
	
</script>

</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="main-body ne-body-offset">
	
	<%@ include file="/WEB-INF/views/common/leftSideBar.jsp" %>

	<div class="main-content">
	
		<div class="ne-sc">
			<main class="ne-main-content ne-body-offset">
				<div class="ne-container">
					<div class="container">

						<div class="body">
		
							<div class="party-apply ne-sc">
								<div class="panel-title">파티 신청 현황</div>
		
								<div class="apply-list">
		
									<c:forEach var="apply" items="${myPartyApplyList }">
								
									<div class="apply-item">
										<div class="apply-info">
											<span>${apply.partyName }</span>
											<span>${apply.themeName }</span>
											<span>${apply.resDate }</span>
											<span>${apply.resTime }</span>
										</div>
										<div class="apply-status">
											<button type="button" class="action-btn danger" value="${apply.applyId }" onclick="applyCancel(this)">취소</button>
										</div>
									</div> 
									
									</c:forEach>
								</div>
							</div>
		
							<div class="current-party ne-sc">
								<div class="panel-title">현재 파티</div>
		
								<div class="current-party-list">
									<c:forEach var="party" items="${myPartyList }">
										<c:if test="${party.partyStatus != 'close' }">
											<div class="current-item">
												<div class="current-info">
													<span>${party.partyName }</span>
													<span>${party.themeName }</span>
													<span>${party.resDate }</span>
													<span>${party.resTime }</span>
												</div>
												<div class="current-btn">
													<button type="button" class="action-btn" value="${party.partyId }" onclick="onBoard(this)">보드</button>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
		
							<!-- 아래 줄: 비활성 -->
							<div class="end-party ne-sc">
								<div class="panel-title">
									종료된 파티
									<span class="ne-st ne-st-sm ne-st-gray">완료</span>
								</div>
		
								<div class="end-party-list">
									<c:forEach var="party" items="${myPartyList }">
										<c:if test="${party.partyStatus == 'close' }">
											<div class="end-item">
												<div class="end-info">
													<span>${party.partyName }</span>
													<span>${party.themeName }</span>
													<span>${party.resDate }</span>
													<span>${party.resTime }</span>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
		
							<div class="kick-party ne-sc">
								<div class="panel-title">
									강퇴된 파티
									<span class="ne-st ne-st-sm ne-st-red">강퇴</span>
								</div>
								<div class="kick-party-list">
									<c:forEach var="party" items="${myPartyKickList }">
										<div class="kick-item">
											<div class="kick-info">
												<span>${party.partyName }</span>
												<span>${party.themeName }</span>
												<span>${party.resDate }</span>
												<span>${party.resTime }</span>
											</div>
											<div class="kick-info">
												<span>${party.kickDate }</span>
												<span>${party.kickTime }</span>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
		
						</div>
		
					</div>
				</div>
			</main>
		</div>
	</div>

<%@ include file="/WEB-INF/views/common/rightSideBar.jsp" %>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>