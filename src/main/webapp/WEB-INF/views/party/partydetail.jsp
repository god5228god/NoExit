<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partydetail.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.container {
  display: flex;
  gap: 24px;
  align-items: flex-start;
  padding: 24px 0;
}

.party-info {
  flex: 0 0 600px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.party-apply {
  flex: 1;
  position: sticky;
  top: 24px;
}

/* 공통 카드 */
.party-info > div,
.party-apply {
  background-color: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
}

/* 파티명 */
.party-name span {
  font-size: 24px;
  font-weight: 700;
  color: #1f2937;
}

/* 테마 정보 */
.theme-info {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.theme-info .theme {
  font-size: 13px;
  padding: 4px 10px;
  background-color: #f3f4f6;
  border-radius: 999px;
  color: #4b5563;
}

/* 파티장 정보 */
.party-host {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  color: #374151;
}

.party-host *
{
  font-size: 13px;
  padding: 4px 10px;
  background-color: #f3f4f6;
  border-radius: 999px;
}

.party-host .temp 
{
  font-weight: 700;
  color: #f97316;
}

.party-host .name {
  font-weight: 600;
}

.party-host .gender,
.party-host .age {
  color: #6b7280;
}

/* 모집 조건 */
.party-condition {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.party-condition .comment {
  font-size: 14px;
  color: #374151;
  line-height: 1.5;
}

.party-condition .gender-condition {
  font-size: 13px;
  color: #6b7280;
}

/* 파티 현황 */
.party-crew > span {
  display: block;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 12px;
  color: #1f2937;
}

.party-crew .crew {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 12px;
  border-radius: 8px;
  background-color: #f9fafb;
  margin-bottom: 8px;
}

.party-crew .crew .nickname {
  font-weight: 500;
  color: #374151;
}

.party-crew .crew .position {
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 999px;
  background-color: #e0e7ff;
  color: #4338ca;
}

/* 파티 신청 */
.party-apply > span {
  display: block;
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 16px;
  color: #1f2937;
}

.party-apply form {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.party-apply textarea {
  width: 100%;
  min-height: 120px;
  padding: 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  resize: vertical;
  font-size: 14px;
  font-family: inherit;
  box-sizing: border-box;
}

.party-apply textarea:focus {
  outline: none;
  border-color: #6366f1;
  box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
}

.party-apply .btn {
  padding: 12px;
  border: none;
  border-radius: 8px;
  background-color: #6366f1;
  color: #fff;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.15s;
}

}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="party-info">
						
					<div class="party-name">
						<span>주열룸</span>
					</div>	
					
					<div class="theme-info">
						<span class="theme">우주별</span>
						<span class="theme">그레이</span>
						<span class="theme">2026-06-01 16:00</span>
					</div>
					
					<div class="party-host">
						<span class="temp">36.5</span>
						<span class="name">윤주열</span>
						<span class="gender">남</span>
						<span class="age">49</span>
					</div>
					
					<div class="party-condition">
						<span class="comment">미쿠 좋아하는 사람만 오셈</span>
						<span class="gender-condition">무관/동성</span>
					</div>
					
					<div class="party-crew">
						<span>파티현황</span>
						<div class="crew">
							<span class="nickname">윤주열</span>
							<span class="position">파티장</span>
						</div>
						<div class="crew">
							<span class="nickname">김주열</span>
							<span class="position">파티원</span>
						</div>
					</div>
											
				</div>
				
				<div class="party-apply">
					<span>파티 신청</span>
					
					<form action="" name="party-aprv">
						
						<textarea name="aprv-comment" placeholder="신청 메시지"></textarea>
						
						<button type="button" class="btn">신청하기</button>
					</form>
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>