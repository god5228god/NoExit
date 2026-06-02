<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>themedetail.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

	.container {
  padding: 24px 0;
}

/* ===== 상단 정보 (이미지 + 표) ===== */
.info {
  padding-top: 30px;
  display: flex;
  align-items: flex-start;
}

.image {
  flex-shrink: 0;
  width: 300px;
  height: 500px;
  margin-right: 30px;
  background-color: #f3f4f6;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #9ca3af;
  font-size: 14px;
}

/* 설명 표 */
.description {
  flex: 1;
  border-collapse: collapse;
  text-align: center;
}

.description th,
.description td {
  padding: 8px 12px;
  border-bottom: 1px solid #e5e7eb;
}

.description tr:last-child th,
.description tr:last-child td {
  border-bottom: none;
}

.description th {
  width: 110px;
  border-right: 1px solid #e5e7eb;
  background-color: #f9fafb;
  font-weight: 600;
  color: #374151;
  white-space: nowrap;
}

.description td {
  text-align: left;
  color: #1f2937;
  word-break: break-word;
}

/* ===== 예약 슬롯 ===== */
.schedule {
  margin: 24px 0;
}

.schedule .datetime-title {
  display: block;
  font-size: 18px;
  font-weight: 700;
  color: #1f2937;
  margin-bottom: 16px;
}

/* 날짜 그룹 */
.schedule .datetime {
  margin-bottom: 20px;
}

.schedule .datetime .date {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: #374151;
  margin-bottom: 8px;
}

.schedule .datetime hr {
  border: none;
  border-top: 1px solid #e5e7eb;
  margin: 0 0 12px;
}

/* 시간 버튼 그리드 */
.schedule .time {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(72px, 1fr));
  gap: 8px;
}

.schedule .btn-time {
  padding: 8px 14px;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  background: #fff;
  cursor: pointer;
  font-size: 13px;
  transition: all 0.15s;
}

.schedule .btn-time:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

/* ===== 리뷰 ===== */
.review {
  margin-top: 32px;
}

/* 리뷰 통계 + 개별 리뷰 카드 공통 */
.review .item {
  background-color: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  padding: 16px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
}

/* 리뷰 통계 (전체 폭) */
.review .total {
  margin-bottom: 24px;
}

.review .total-review,
.review .user-review {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
}

.review .total-review th,
.review .user-review th {
  width: 90px;
  text-align: left;
  padding: 6px 8px;
  color: #6b7280;
  font-weight: 500;
  white-space: nowrap;
}


/* 개별 리뷰 3열 그리드 */
.review .comment {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}
	
</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="theme">
					
					<div class="info">
						
						<div class="image">
							테마이미지
						</div>
						
						<table class="description">
							<tr>
								<th>카페명</th>
								<td>우주별</td>
							</tr>
							<tr>
								<th>카페연락처</th>
								<td>010-1234-1234</td>
							</tr>
							<tr>
								<th>카페위치</th>
								<td>홍대입구 근처 어딘가</td>
							</tr>
							<tr>
								<th>테마명</th>
								<td>그레이</td>
							</tr>
							<tr>
								<th>소요시간</th>
								<td>60분</td>
							</tr>
							<tr>
								<th>테마 소개</th>
								<td>주열님이 강력 추천하는 테마</td>
							</tr>
							<tr>
								<th>1인 가격</th>
								<td>30000</td>
							</tr>
							<tr>
								<th>난이도</th>
								<td>★★★★★</td>
							</tr>
							<tr>
								<th>활동도</th>
								<td>★★★★★</td>
							</tr>
							<tr>
								<th>공포도</th>
								<td>★★★★★</td>
							</tr>
							<tr>
								<th>인원 수</th>
								<td>2 ~ 4</td>
							</tr>
							<tr>
								<th>성인 유무</th>
								<td>Y/N</td>
							</tr>
						</table>
						
					</div>
					
					<div class="schedule">
						
						<span class="datetime-title">예약 슬롯</span>
						
						<div class="datetime">
							<span class="date">2026-06-01</span>
							<hr>
							
							<div class="time">
								
								<button type="button" class="btn-time" disabled="disabled">10:00</button>
								<button type="button" class="btn-time" disabled="disabled">12:00</button>
								<button type="button" class="btn-time" disabled="disabled">14:00</button>
								<button type="button" class="btn-time" disabled="disabled">16:00</button>
								<button type="button" class="btn-time" onclick="">18:00</button>
								
							</div>
							
						</div>
						
						<div class="datetime">
						
							<span class="date">2026-06-02</span>
							<hr>
							
							<div class="time">
								
								<button type="button" class="btn-time">10:00</button>
								<button type="button" class="btn-time" disabled="disabled">12:00</button>
								<button type="button" class="btn-time">14:00</button>
								<button type="button" class="btn-time" disabled="disabled">16:00</button>
								<button type="button" class="btn-time">18:00</button>
								
							</div>
							
						</div>
						
						<div class="datetime">
							<span class="date">2026-06-03</span>
							<hr>
							
							<div class="time">
								
								<button type="button" class="btn-time" disabled="disabled">10:00</button>
								<button type="button" class="btn-time">12:00</button>
								<button type="button" class="btn-time" disabled="disabled">14:00</button>
								<button type="button" class="btn-time">16:00</button>
								<button type="button" class="btn-time">18:00</button>
								<button type="button" class="btn-time">20:00</button>
								<button type="button" class="btn-time" disabled="disabled">22:00</button>
								
							</div>
							
						</div>
												
					</div>
					
					<div class="review">
						
						<div class="total">
														
							<div class="ne-sc item">
							  <div class="ne-sc-title">리뷰 통계 (1개)</div>
							  	
							  	<table class="total-review">
							  		<tr>
							  			<th>체감난이도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>체감공포도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>체감활동도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>몰입도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>만족도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  	</table>
							  
							</div>
							
						</div>
						
						<div class="comment">
						
							<div class="ne-sc item">
							  <div class="ne-sc-title">작성자닉네임</div>
							  	
							  	<table class="user-review">
							  		<tr>
							  			<th>체감난이도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>체감공포도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>체감활동도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>몰입도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>만족도</th>
							  			<td>★★★☆☆</td>
							  		</tr>
							  		<tr>
							  			<th>한줄 코멘트</th>
							  			<td>재밌음</td>
							  		</tr>
							  	</table>
							  
							</div>
							
						</div>
						
					</div>
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>