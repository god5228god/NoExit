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

.container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  padding: 24px 0;
}

/* 패널 공통 */
.container > div {
  display: flex;
  flex-direction: column;
  min-height: 350px;
  max-height: 350px;
  overflow-y: auto;
  padding: 16px;
  background-color: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
}


/* 패널 제목 */
.container > div > .title {
  font-size: 16px;
  font-weight: 700;
  color: #1f2937;
  padding-bottom: 10px;
  margin-bottom: 12px;
  border-bottom: 1px solid #f3f4f6;
  position: sticky;
  top: -16px;
  background-color: #fff;
}

/* ===== 파티 정보 ===== */
/* 버튼 영역 (제목 아래) - theme와 구분선 */
.party-action {
  display: flex;
  gap: 8px;
  padding-bottom: 12px;
  margin-bottom: 12px;
  border-bottom: 1px solid #e5e7eb;
}

.party-action button {
  flex: 1;
  padding: 8px;
  border: none;
  border-radius: 8px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: opacity 0.15s;
}

.party-action button:hover { opacity: 0.85; }

.party-action .aprv-btn   { background-color: #6366f1; color: #fff; }
.party-action .modify-btn { background-color: #e5e7eb; color: #374151; }
.party-action .delete-btn { background-color: #fee2e2; color: #b91c1c; }

/* 정보 텍스트 (전부 span, 한 줄씩) */
.party-info .theme,
.party-info .party {
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-size: 13px;
  color: #374151;
  margin-bottom: 12px;
}

.party-info .theme span,
.party-info .party > span {
  word-break: break-word;   /* 긴 텍스트 줄바꿈 */
}

.party-info .host-comment {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.party-info .host-comment textarea {
  width: 100%;
  min-height: 60px;
  padding: 8px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-family: inherit;
  font-size: 13px;
  resize: vertical;
  box-sizing: border-box;
}

/* ===== 파티원 ===== */
.party-crew .crew {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 6px 8px;
  padding: 10px 12px;
  margin-bottom: 8px;
  background-color: #f9fafb;
  border-radius: 8px;
  font-size: 13px;
}

.party-crew .crew .nickname {
  font-weight: 600;
  color: #374151;
  word-break: break-word;   /* 긴 닉네임 줄바꿈 */
  min-width: 0;
}

.party-crew .crew .age,
.party-crew .crew .gender,
.party-crew .crew .temp {
  color: #6b7280;
}

.party-crew .crew .position,
.party-crew .crew .status {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 999px;
}

.party-crew .crew .position { background-color: #e0e7ff; color: #4338ca; }
.party-crew .crew .status   { background-color: #fef9c3; color: #854d0e; }

.party-crew .crew .ready,
.party-crew .crew .kick {
  padding: 4px 8px;
  border: none;
  border-radius: 6px;
  font-size: 12px;
  cursor: pointer;
}

.party-crew .crew .ready { margin-left: auto; background-color: #dcfce7; color: #15803d; }
.party-crew .crew .kick  { background-color: #fee2e2; color: #b91c1c; }

/* ===== 댓글 (채팅 스타일, 말풍선 → 작성자 순) ===== */
.comment-list {
  display: flex;
  flex-direction: column;
}

.comment-list br { display: none; }   /* 마크업의 <br>은 gap으로 대체 */

.comment-list .comment {
  display: inline-block;
  max-width: 75%;
  margin-top: 10px;
  padding: 8px 12px;
  border-radius: 12px;
  font-size: 13px;
  line-height: 1.4;
  word-break: break-word;
}

.comment-list .comment:first-child { margin-top: 0; }

.comment-list .writer {
  font-size: 11px;
  color: #9ca3af;
  margin-top: 2px;
}

/* 상대방 - 왼쪽 */
.comment-list .other-comment {
  align-self: flex-start;
  background-color: #f3f4f6;
  color: #374151;
}
.comment-list .other-writer { align-self: flex-start; }

/* 나 - 오른쪽 */
.comment-list .my-comment {
  align-self: flex-end;
  background-color: #6366f1;
  color: #fff;
}
.comment-list .my-writer { align-self: flex-end; }

.comment-list .comment-delete {
  align-self: flex-end;        /* 내 메시지 쪽(오른쪽) */
  margin-top: 10px;
  font-size: 11px;
  color: #9ca3af;
  cursor: pointer;
  /* 버튼 기본 스타일 제거 */
  border: none;
  background: none;
  padding: 0;
  font-family: inherit;
  /* 말풍선 스타일 제거(comment 클래스 대비) */
  max-width: none;
}

.comment-write {
  display: flex;
  gap: 8px;
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px solid #f3f4f6;
  /* 스크롤 시 패널 하단 고정 */
  position: sticky;
  bottom: -16px;
  background-color: #fff;
}

.comment-write .comment-input {
  flex: 1;
  min-width: 0;
  padding: 8px 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 13px;
  font-family: inherit;
  box-sizing: border-box;
}

.comment-write .comment-submit {
  flex-shrink: 0;
  padding: 8px 16px;
  border: none;
  border-radius: 8px;
  background-color: #6366f1;
  color: #fff;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.15s;
}

/* ===== 신청 현황 ===== */
.aprv-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.aprv-list .aprv {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 6px 8px;
  padding: 10px 12px;
  background-color: #f9fafb;
  border-radius: 8px;
  font-size: 13px;
}

.aprv-list .aprv .nickname {
  font-weight: 600;
  color: #374151;
  word-break: break-word;   /* 긴 닉네임 줄바꿈 */
  min-width: 0;
}

.aprv-list .aprv .age,
.aprv-list .aprv .gender,
.aprv-list .aprv .temp {
  color: #6b7280;
}

.aprv-list .aprv .comment {
  flex: 1 1 100%;           /* 한마디는 다음 줄 전체 폭, 길면 줄바꿈 */
  color: #4b5563;
  font-style: italic;
  word-break: break-word;
}

.aprv-list .aprv .aprv-success,
.aprv-list .aprv .aprv-fail 
{
  padding: 4px 12px;
  border: none;
  border-radius: 6px;
  font-size: 12px;
}

.aprv-list .aprv .aprv-success 
{
  margin-left: auto;            
  background-color: #dcfce7;
  color: #15803d;
}

.aprv-list .aprv .aprv-fail {
  background-color: #fee2e2;
  color: #b91c1c;
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="party-info">
					<span class="title">파티 정보</span>
					
					<div class="party-action">
					
						<button type="button" class="ne-st ne-st-blue">예약 확정</button>
						<button type="button" class="ne-st ne-st-green">파티 수정</button>
						<button type="button" class="ne-st ne-st-red">파티 해산</button>
					
					</div>
									
					<div class="theme"> 
						<span class="cafe-name">카페명 : 우주별</span>
						<span class="theme-name">테마명 : 그레이</span>
						<span class="time">일시 : 2026-06-02 14:00</span>
					</div>
					
					<div class="party">
						<span class="party-name">파티명 : 주열룸</span>
						<span class="party-condition">성별조건 : 동성만</span>
						<span class="host-comment">
							방장 한마디
							<textarea readonly="readonly">미쿠 좋아하는 사람만 오셈</textarea>
						</span>
					</div>
					
				</div>
				
				<div class="party-crew">
					<span class="title">파티원 (2/4)</span>
					
					<div class="crew">
						<span class="ne-st ne-st-green">윤주열</span>
						<span>29</span>
						<span>여</span>
						<span class="ne-st ne-st-red">-50</span>
						<span class="position">파티장</span>
					</div>
					
					<div class="crew-list">
						
						<div class="crew">
							<span class="ne-st ne-st-green">김주열</span>
							<span>9</span>
							<span>남</span>
							<span class="ne-st ne-st-red">36.5</span>
							<span class="position">파티원</span>
							<span class="status">준비완료/준비중</span>
							<button type="button" class="ready" onclick="">레디</button>
							<button type="button" class="kick" onclick="">강퇴/탈퇴</button>
						</div>
						
					</div>
					
				</div>
				 
				<div class="party-comment">
				 	<span class="title">댓글</span>
				 	
				 	<div class="comment-list">
				 		
						<span class="comment other-comment">미쿠 티셔츠 샀음</span>				 		
				 		<span class="writer other-writer">윤주열</span>
				 		
				 		<span class="comment my-comment">오 얼마임?</span>
				 		<button type="button" class="comment-delete">삭제하기</button>
				 		<span class="writer my-writer">김주열</span>
				 		
						<span class="comment other-comment">삭제된 메시지 입니다.</span>				 		
				 		<span class="writer other-writer">윤주열</span>
				 		
						<span class="comment other-comment">43000원</span>				 		
				 		<span class="writer other-writer">윤주열</span>
				 		
				 		<span class="comment my-comment">웰케 비쌈?</span>
				 		<button type="button" class="comment-delete">삭제하기</button>
				 		<span class="writer my-writer">김주열</span>
				 		
						<span class="comment other-comment">미쿠 티셔츠는 신이기 때문임</span>				 		
				 		<span class="writer other-writer">윤주열</span>
				 		
				 		<span class="comment my-comment">삭제된 메시지입니다.</span>
				 		<span class="writer my-writer">김주열</span>
				 		
				 	</div>
				 	
				 		
				 	<div class="comment-write">
				 		
				 		<input type="text" class="comment-input">
				 		
				 		<button type="button" class="comment-submit">입력</button>
				 		
				 	</div>
				 	
				</div>
				 
				<div class="party-aprv">
				 	<span class="title">신청 현황</span>
				 	
				 	<div class="aprv-list">
				 		
				 		<div class="aprv">
				 			<span class="nickname">최주열</span>
				 			<span class="age">19</span>
				 			<span class="gender">남</span>
				 			<span class="temp">50.5</span>
				 			<span class="comment">미쿠?</span>
				 			
			 				<button type="button" class="aprv-success" onclick="">승인</button>
							<button type="button" class="aprv-fail" onclick="">거절</button>
				 		</div>
				 	
				 		
				 	</div>
				 	
				</div>
				 
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>