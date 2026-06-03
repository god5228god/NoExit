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

.container
{
	display: flex;
	flex-direction: column;
	gap: 10px;
	padding: 20px 0;
}

.theme-info-wrap
{
	display: grid;
	grid-template-columns : 2fr 3fr;
	gap: 20px;
}

.theme-image
{
	background-color: #f5f5f5;
}

.theme-info
{
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.info-item
{
	display: flex;
	justify-content: space-between;
 	padding: 5px;
  	background: #f5f5f5;
  	border-radius: 5px;
}

.theme-description 
{
  	display: flex;
  	flex-direction: column;
  	gap: 5px;
}

.theme-description span 
{
  	font-weight: bold;
}

.theme-description p 
{
  padding: 10px;
  border: 1px solid black;
  border-radius: 5px;
  background: #f5f5f5;
}

.slot-list 
{
  	display: flex;
  	flex-direction: column;
  	gap: 10px;
}

.slot-list > span
{
	font-weight: bold;
}

.slot 
{
  	display: flex;
  	align-items: center;
  	gap: 15px;
  	padding: 10px;
  	border: 1px solid black;
  	border-radius: 10px;
}

.slot-date 
{
  font-weight: bold;
}

.slot-time 
{
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.slot-time button, .slot-time span
{
  padding: 5px;
  border: 1px solid black;
  border-radius: 5px;
  cursor: pointer;
}

.slot-time span
{
	background: #d1d1d1;
}

.slot-time button
{
	background: white;
}

.slot-time button:hover
{
	background-color: orange;
}

.review-wrap > span
{
	font-weight: bold;
}

.review-total
{
	width: 30%;
}

.review 
{
  display: flex;
  justify-content: space-between;
}

.review-list
{
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;	
	gap : 10px;
}

.comment p 
{
  margin: 0;
  font-size: 14px;
  line-height: 1.5;
  color: #444;
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="theme-info-wrap">
					
					<div class="theme-image">
						<span>테마이미지</span>
					</div>
					
					<div class="theme-info">
						
						<div class="info-item">
							<span>카페명</span>
							<span>우주별</span>
						</div>
						
						<div class="info-item">
							<span>카페위치</span>
							<span>홍대입구 5분 거리</span>
						</div>
						
						<div class="info-item">
							<span>카페전화번호</span>
							<span>010-1234-11234</span>
						</div>
						
						<div class="info-item">
							<span>테마명</span>
							<span>그레이</span>
						</div>
						
						<div class="info-item">
							<span>테마 장르</span>
							<span>추리</span>
						</div>
						
						<div class="info-item">
							<span>테마 시간</span>
							<span>60분</span>
						</div>
						
						<div class="info-item">
							<span>난이도</span>
							<span>★★★★★</span>
						</div>
						
						<div class="info-item">
							<span>공포도</span>
							<span>★★★★☆</span>
						</div>
						
						<div class="info-item">
							<span>테마 가격</span>
							<span>30000</span>
						</div>
						
						<div class="info-item">
							<span>테마 인원</span>
							<span>2 ~ 4</span>
						</div>
						
					</div>
				</div>
				
				<div class="theme-description">
					<span>테마 소개</span>
					<p>1960년 대 뉴욕에서 당신은 탐정이 되어 사건의 실마리를 찾아 범인을 찾아내야 합니다. </p>
				</div>
							
				<div class="slot-list">
					
					<span>예약 목록</span>
					
					<div class="slot">
					
						<div class="slot-date">
							<span>2026-06-01</span>
						</div>
						
						<div class="slot-time">
							<span class="ne-st ne-st-gray">10:00</span>
							<button type="button" value="slotId" onclick="">12:00</button>
							<button type="button" value="slotId" onclick="">14:00</button>
							<button type="button" value="slotId" onclick="">16:00</button>
						</div>
						
					</div>
					
					<div class="slot">
					
						<div class="slot-date">
							<span>2026-06-02</span>
						</div>
						
						<div class="slot-time">
							<button type="button" value="slotId" onclick="">10:00</button>
							<button type="button" value="slotId" onclick="">12:00</button>
							<button type="button" value="slotId" onclick="">14:00</button>
							<button type="button" value="slotId" onclick="">16:00</button>
						</div>
						
					</div>
					
				</div>							
				
				<div class="review-wrap">
					
					<span>리뷰</span>
					
					<div class="review-total">
						
						<div class="ne-sc item">
							<div class="ne-sc-title">리뷰 통계 (1개)</div>
							  	
							 <div class="review">
							 	<span>만족도</span>
							 	<span>★★★☆☆</span>
							 </div>	 
							  
							 <div class="review">
							 	<span>체감난이도</span>
							 	<span>★★★☆☆</span>
							 </div>	
							   
							 <div class="review">
							 	<span>체감공포도</span>
							 	<span>★★★☆☆</span>
							 </div>	 
							  
							 <div class="review">
							 	<span>체감활동도</span>
							 	<span>★★★☆☆</span>
							 </div>	  
							  
							 <div class="review">
							 	<span>몰입도</span>
							 	<span>★★★☆☆</span>
							 </div>	  
							  
						</div>
						
					</div>
					
					<div class="review-list">
						
						<div class="ne-sc item">
						  	<div class="ne-sc-title">윤주열</div>
							
							 <div class="review">
							 	<span>만족도</span>
							 	<span>★★★☆☆</span>
							 </div>	 
							  
							 <div class="review">
							 	<span>체감난이도</span>
							 	<span>★★★☆☆</span>
							 </div>	
							   
							 <div class="review">
							 	<span>체감공포도</span>
							 	<span>★★★☆☆</span>
							 </div>	 
							  
							 <div class="review">
							 	<span>체감활동도</span>
							 	<span>★★★☆☆</span>
							 </div>	  
							  
							 <div class="review">
							 	<span>몰입도</span>
							 	<span>★★★☆☆</span>
							 </div>	
							
							<div class="comment">
								<p>장치가 다양하고 색다른 요소가 많이 있습니다. 방탈출 초보분들께 강추합니다.</p>
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