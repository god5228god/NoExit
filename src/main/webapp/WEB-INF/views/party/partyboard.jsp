<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partyboard.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">


<style type="text/css">
/* ===== 변수 ===== */
:root {
	--bg: #f4f5f7;
	--surface: #ffffff;
	--border: #e3e6ea;
	--text: #2b2f36;
	--muted: #6b7280;
	--primary: #5b6ef5;
	--primary-dark: #4453d8;
	--danger: #ef4444;
	--success: #22a565;
	--radius: 12px;
	--shadow: 0 1px 3px rgba(0,0,0,.08), 0 1px 2px rgba(0,0,0,.04);
}

/* ===== 레이아웃 ===== */
.party-room {
	margin-top: 20px;
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-template-areas:
		"info    guest"
		"comment apply";
	gap: 16px;
	margin-bottom: 20px;
}

.party-info,
.party-guest,
.party-apply,
.party-comment
{
	background: var(--surface);
	border: 1px solid var(--border);
	border-radius: var(--radius);
	box-shadow: var(--shadow);
	padding: 16px;
	color: var(--text);
}

.party-info, .party-guest
{
	height: 300px;
}

.party-comment {
	grid-area: comment;
	height: 400px;        /* min-height → height (고정) */
	display: flex;
	flex-direction: column;
	align-items: stretch;
}

.party-info    { grid-area: info; }
.party-guest   { grid-area: guest; }
.party-apply   { grid-area: apply; }
.party-comment {
	grid-area: comment;
	min-height: 320px;
	display: flex;
	flex-direction: column;
	align-items: stretch;
}

/* 영역 제목 (각 div 첫 span) */
.party-info  > span,
.party-guest > span,
.party-apply > span,
.party-comment > span {
	display: block;
	font-weight: 700;
	font-size: 15px;
	margin-bottom: 12px;
	padding-bottom: 8px;
	border-bottom: 2px solid var(--border);
}

/* ===== 테이블 공통 ===== */
table {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
	font-size: 14px;
}

.party th, .party td,
.apply th, .apply td,
.guest th, .guest td {
	padding: 10px 8px;
	border-bottom: 1px solid var(--border);
}

.party th,
.apply thead th,
.guest thead th {
	background: #f7f8fa;
	color: var(--muted);
	font-weight: 600;
}

.apply tbody tr:hover,
.guest tbody tr:hover {
	background: #fafbfc;
}

/* ===== 버튼 ===== */
button 
{
	cursor: pointer;
	border: 1px solid var(--border);
	background: var(--surface);
	color: var(--text);
	padding: 6px 12px;
	border-radius: 8px;
	font-size: 13px;
	transition: .15s;
}
button:hover { background: #f0f1f4; }

.party-info button { margin-right: 6px; margin-top: 12px; }

/* ===== 댓글 ===== */
.comment-show 
{
	display: flex;
	flex-direction: column;
	gap: 10px;
	background: #fafbfc;
	border: 1px solid var(--border);
	width: 100%;
	flex: 1;
	min-height: 200px;
	overflow-y: auto;
	padding: 12px;
	box-sizing: border-box;
}

.msg { display: flex; gap: 6px; align-items: center; }
.msg.other { justify-content: flex-start; }
.msg.mine  { justify-content: flex-end; }

.msg .writer {
	font-size: 12px;
	color: var(--muted);
	white-space: nowrap;
}

.msg .comment {
	padding: 8px 12px;
	border-radius: 14px;
	max-width: 70%;
	word-break: break-word;
	font-size: 14px;
	line-height: 1.4;
}

.msg.other .comment { background: #eceef1;}
.msg.mine  .comment { background: var(--primary); color:#fff; }

.msg button {
	padding: 2px 6px;
	font-size: 11px;
	color: var(--muted);
}

.comment-input {
	display: flex;
	gap: 8px;
	margin-top: 12px;
}
.comment-input input {
	flex: 1;
	padding: 10px 12px;
	border: 1px solid var(--border);
	font-size: 14px;
}

.comment-input button {
	background: var(--primary);
	border-color: var(--primary);
	color: #fff;
}

/* 스크롤 박스: 높이는 원하는 값으로 조절 */
.party-guest .table-scroll,
.party-apply .table-scroll
 {
	height: 300px;
	overflow-y: auto;
	border: 1px solid var(--border);
	border-radius: 8px;
}

.party-guest .table-scroll
{
	height: 150px;
}

/* 스크롤해도 헤더 고정 */
.apply thead th,
.guest thead th {
	position: sticky;
	top: 0;
	z-index: 1;
	background: #f7f8fa;   /* 투명 방지 */
}

.info-control {
	display: flex;
	justify-content: center;
	gap: 8px;
	margin-top: 12px;
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="party-room">
				
					<div class="party-info">
					
						<span>파티 정보</span>
					
						<!-- 파티명 / 파티한마디 / 테마 / 시간 / 수정하기버튼 -->
						<table class="party">
							<tr>
								<th>파티명</th>
								<td>주열룸</td>
								<th>파티장</th>
								<td>윤주열</td>
							</tr>
							<tr>
								<th>테마명</th>
								<td colspan="3">그레이</td>
							</tr>
							<tr>
								<th>일시</th>
								<td colspan="3">2026-06-03 18:00</td>
							</tr>
							<tr>
								<th>방장 한마디</th>
								<td colspan="3">미쿠미쿠</td>
							</tr>
						</table>
						
						<div class="info-control">
							
							<button type="button" class="ne-st ne-st-blue">예약 확정</button>
							<button type="button" class="ne-st ne-st-green">파티 수정</button>
							<button type="button" class="ne-st ne-st-red">파티 해산</button>
							
						</div>
						
					</div> <!-- .party-info -->
					
					
					<div class="party-apply">
					
						<span>신청 목록</span>
					
						<div class="table-scroll">

							<!-- 파티 신청자 닉네임 / 매너온도 / 한마디 / 방장은 승인/거절 버튼 -->
							<table class="apply">
								<thead>
									<tr>
										<th class="">닉네임</th>
										<th class="">매너온도</th>
										<th class="">성별</th>
										<th class="">나이</th>
										<th class="">한마디</th>
										<th>버튼</th>
									</tr>
								</thead>
								
								<tbody>
									<tr>
										<td>윤주열</td>
										<td>-50</td>
										<td>여</td>
										<td>7</td>
										<td>미쿠 좋아하심?</td>
										<td>
											<button type="button" class="ne-st ne-st-green">승인</button>
											<button type="button" class="ne-st ne-st-red">거절</button>
										</td>
									</tr>
									
									<tr>
										<td>김주열</td>
										<td>36.5</td>
										<td>남</td>
										<td>19</td>
										<td>ㅎㅇ</td>
										<td>
											<button type="button" class="ne-st ne-st-green">승인</button>
											<button type="button" class="ne-st ne-st-red">거절</button>
										</td>
									</tr>
									<tr>
										<td>김주열</td>
										<td>36.5</td>
										<td>남</td>
										<td>19</td>
										<td>ㅎㅇ</td>
										<td>
											<button type="button" class="ne-st ne-st-green">승인</button>
											<button type="button" class="ne-st ne-st-red">거절</button>
										</td>
									</tr>
									<tr>
										<td>김주열</td>
										<td>36.5</td>
										<td>남</td>
										<td>19</td>
										<td>ㅎㅇ</td>
										<td>
											<button type="button" class="ne-st ne-st-green">승인</button>
											<button type="button" class="ne-st ne-st-red">거절</button>
										</td>
									</tr>
									<tr>
										<td>김주열</td>
										<td>36.5</td>
										<td>남</td>
										<td>19</td>
										<td>ㅎㅇ</td>
										<td>
											<button type="button" class="ne-st ne-st-green">승인</button>
											<button type="button" class="ne-st ne-st-red">거절</button>
										</td>
									</tr>
									<tr>
										<td>김주열</td>
										<td>36.5</td>
										<td>남</td>
										<td>19</td>
										<td>ㅎㅇ</td>
										<td>
											<button type="button" class="ne-st ne-st-green">승인</button>
											<button type="button" class="ne-st ne-st-red">거절</button>
										</td>
									</tr>
								</tbody>
								
							</table>
							
						</div>
						
					</div> <!-- .party-apply -->
					
					
					<div class="party-comment">
					
						<span>파티 댓글</span>
					
						<!-- 댓글 창 / 댓글 작성 창 -->
						<div class="comment-show">
							
							<div class="msg other">
								<span class="writer">윤주열</span>
								<span class="comment">미쿠 티셔츠 샀음</span>
							</div>
							
							<div class="msg mine">
								<button type="button" class="ne-st ne-st-red" style="font-size: small;">삭제</button>
								<span class="comment">오 얼마임?</span>
								<span class="writer">김주열</span>
							</div>
							
							<div class="msg other">
								<span class="writer">윤주열</span>
								<span class="comment">50만원</span>
							</div>
							<div class="msg other">
								<span class="writer">윤주열</span>
								<span class="comment">삭제된 댓글입니다.</span>
							</div>
							<div class="msg other">
								<span class="writer">윤주열</span>
								<span class="comment">50만원</span>
							</div>
							<div class="msg other">
								<span class="writer">윤주열</span>
								<span class="comment">50만원</span>
							</div>
							<div class="msg other">
								<span class="writer">윤주열</span>
								<span class="comment">50만원</span>
							</div>
							
							<div class="msg mine">
								<button type="button" class="ne-st ne-st-red" style="font-size: small;">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
						</div>
						
						<div class="comment-input">
							
							<input type="text" placeholder="댓글"> 
							<button type="button" class="ne-st ne-st-blue">작성</button>
						</div>
					
					</div> <!-- .party-comment -->
					
					
					<div class="party-guest">
					
						<span>파티원</span>
					
						<div class="table-scroll">
					
							<!-- 각각의 파티원 닉네임 / 레디 상태 / 탈퇴-레디 버튼 -->
							<table class="guest">
								<thead>
									<tr>
										<th>닉네임</th>
										<th>성별</th>
										<th>나이</th>
										<th>레디상태</th>
										<th>버튼</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>윤주열</td>
										<td>여</td>
										<td>9</td>
										<td>준비 중</td>
										<td>
											<button type="button" class="ne-st ne-st-green">Ready</button>
											<button type="button" class="ne-st ne-st-red">탈퇴하기</button>
											<!-- <button type="button" class="btn-danger">강퇴하기</button> -->
										</td>
									</tr>
									<tr>
										<td>최주열</td>
										<td>남</td>
										<td>39</td>
										<td>준비완료</td>
										<td>
											<button type="button" class="ne-st ne-st-green">Ready</button>
											<button type="button" class="ne-st ne-st-red">탈퇴하기</button>
											<!-- <button type="button" class="btn-danger">강퇴하기</button> -->
										</td>
									</tr>
								</tbody>
							</table>
						
						</div>
					
					</div> <!-- .party-guest -->
					
					
				</div> <!-- .party-room -->
				
				 
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>