<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partywrite.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.container {
  max-width: 600px;
  margin: 0 auto;
  padding: 24px 0;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

/* 제목 */
.title span {
  font-size: 24px;
  font-weight: 700;
  color: #1f2937;
}

/* 테마 정보 */
.theme-info {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  padding: 16px 20px;
  background-color: #f9fafb;
  border-radius: 12px;
}

.theme-info span {
  font-size: 13px;
  padding: 4px 10px;
  background-color: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 999px;
  color: #4b5563;
}

/* 작성 카드 */
.write {
  background-color: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
}

.write form {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

/* 라벨 */
.write form span {
  font-size: 14px;
  font-weight: 600;
  color: #374151;
  margin-top: 8px;
}

/* 텍스트 입력 */
.write .text[type="text"] {
  width: 100%;
  padding: 12px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 14px;
  font-family: inherit;
  box-sizing: border-box;
}

.write .text[type="text"]:focus {
  outline: none;
  border-color: #6366f1;
  box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
}

/* 동성만 체크박스 행 */
.write .gender-condition {
  display: inline-flex;
  align-items: center;
  margin-top: 8px;
}

.write .text[type="checkbox"] {
  width: 18px;
  height: 18px;
  margin: 0 0 0 8px;
  vertical-align: middle;
  cursor: pointer;
  accent-color: #6366f1;
}

/* 작성 버튼 */
.write .btn {
  display: block;
  width: 100%;
  margin-top: 20px;
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

.write .btn:hover {
  background-color: #4f46e5;
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="title">
					<span>파티 개설</span>
				</div>
				
				<div class="theme-info">
					<span class="cafe-name">우주별</span>
					<span class="theme-name">그레이</span>
					<span class="time">2026-06-01 16:00</span>
					<span class="count">2 ~ 4</span>
					<span class="price">30000</span>
				</div>
				
				<div class="write">
					
					<form action="" name="writeForm">
						
						<span class="party-name">파티명</span>
						<input type="text" name="partyName" class="text">
						<span class="gender-condition">동성만</span>
						<input type="checkbox" name="gender" value="1" class="text">
						<span class="party-description">방장 한마디</span>
						<input type="text" name="comment" class="text">
					</form>
					
					<button type="button" class="btn" onclick="">작성하기</button>
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>