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
	/* background-color: #f5f5f5; */
	width: 100%;
	height: 100%;
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
				
				<div class="theme-info-wrap">
					
					<div class="theme-image">
						<img src="${pageContext.request.contextPath}/uploads/theme/${dto.imagePath}" style="width:100%; height: 100%;">
					</div>
					
					<div class="theme-info">
						
						<div class="info-item">
							<span>카페명</span>
							<span>${dto.cafeName }</span>
						</div>
						
						<div class="info-item">
							<span>카페위치</span>
							<span>${dto.cafeLocation }</span>
						</div>
						
						<div class="info-item">
							<span>카페전화번호</span>
							<span>${dto.cafePhone }</span>
						</div>
						
						<div class="info-item">
							<span>테마명</span>
							<span>${dto.themeName }</span>
						</div>
						
						<div class="info-item">
							<span>테마 장르</span>
							<span>${dto.genre }</span>
						</div>
						
						<div class="info-item">
							<span>테마 시간</span>
							<span>${dto.duration }분</span>
						</div>
						
						<div class="info-item">
							<span>난이도</span>
							<span><c:forEach begin="1" end="${dto.difficulty }">★</c:forEach><c:forEach begin="${dto.difficulty +1}" end="5">☆</c:forEach>
							</span>
						</div>
						
						<div class="info-item">
							<span>공포도</span>
							<span><c:forEach begin="1" end="${dto.horror }">★</c:forEach><c:forEach begin="${dto.horror +1}" end="5">☆</c:forEach>
							</span>
						</div>
						
						<div class="info-item">
							<span>활동도</span>
							<span><c:forEach begin="1" end="${dto.activity }">★</c:forEach><c:forEach begin="${dto.activity +1 }" end="5">☆</c:forEach>
							</span>
						</div>
						
						<div class="info-item">
							<span>테마 가격</span>
							<span>${dto.price }</span>
						</div>
						
						<div class="info-item">
							<span>테마 인원</span>
							<span>${dto.minPlayers }명 ~ ${dto.maxPlayers }명</span>
						</div>
						
						<div class="info-item">
							<span>성인 전용</span>
							<span>${dto.adult == 1 ? 'Y' : 'N'}</span>
						</div>
						
					</div>
				</div>
				
				<div class="theme-description">
					<span>테마 소개</span>
					<p>${dto.description } </p>
				</div>
							
				<div class="slot-list">
					
					<span>예약 목록</span>
					
					<c:forEach var="date" items="${slot }">
						
						<div class="slot">
							
							<div class="slot-date">
								<span>${date.key }</span>
							</div>
							
							<div class="slot-time">
								
							<c:forEach var="time" items="${date.value }">
								
								<c:choose>
									<c:when test="${time.status == 1 }">
										<button type="button" data-slot="${time.slotId }" class="slot-btn">
											${time.resTime }
										</button>
									</c:when>
									<c:otherwise>
										<span class="ne-st ne-st-gray">
											${time.resTime }
										</span>
									</c:otherwise>
									
								</c:choose>		
								
							</c:forEach>
							
							</div>
														
						</div>
						
					</c:forEach>
					
					<!-- 
					<div class="slot">
					
						<div class="slot-date">
							<span>2026-06-01</span>
						</div>
						
						<div class="slot-time">
							<span class="ne-st ne-st-gray">10:00</span>
							<button type="button" data-slot="1" class="slot-btn">12:00</button>
							<button type="button" data-slot="2" class="slot-btn">14:00</button>
							<button type="button" data-slot="3" class="slot-btn">16:00</button>
							<button type="button" data-slot="4" class="slot-btn">18:00</button>
							<button type="button" data-slot="5" class="slot-btn">20:00</button>
						</div>
						
					</div>
					
					<div class="slot">
					
						<div class="slot-date">
							<span>2026-06-02</span>
						</div>
						
						<div class="slot-time">
							<button type="button" data-slot="6" class="slot-btn">12:00</button>
							<button type="button" data-slot="7" class="slot-btn">14:00</button>
							<button type="button" data-slot="8" class="slot-btn">16:00</button>
							<button type="button" data-slot="9" class="slot-btn">18:00</button>
						</div>
						
					</div> -->
					
				</div>							
				
				<div class="review-wrap">
					
					<span>리뷰</span>
					
					<div class="review-total">
						
						<div class="ne-sc item">
							<div class="ne-sc-title">리뷰 통계 (${count }개)</div>
							  	
							 <div class="review">
							 	<span>만족도</span>
							 	<span><c:forEach begin="1" end="${total.satisfaction }">★</c:forEach><c:forEach begin="${total.satisfaction +1 }" end="5">☆</c:forEach>
							 	</span>
							 </div>	 
							 
							 <div class="review">
							 	<span>체감난이도</span>
							 	<span><c:forEach begin="1" end="${total.difficulty }">★</c:forEach><c:forEach begin="${total.difficulty +1 }" end="5">☆</c:forEach></span>
							 </div>	
							   
							 <div class="review">
							 	<span>체감공포도</span>
							 	<span><c:forEach begin="1" end="${total.horror }">★</c:forEach><c:forEach begin="${total.horror +1 }" end="5">☆</c:forEach></span>
							 </div>	 
							  
							 <div class="review">
							 	<span>체감활동도</span>
							 	<span><c:forEach begin="1" end="${total.activity }">★</c:forEach><c:forEach begin="${total.activity +1 }" end="5">☆</c:forEach></span>
							 </div>	  
							  
							 <div class="review">
							 	<span>몰입도</span>
							 	<span><c:forEach begin="1" end="${total.satisfaction }">★</c:forEach><c:forEach begin="${total.immersion +1 }" end="5">☆</c:forEach></span>
							 </div>	  
							  
						</div>
						
					</div>
					
					<div class="review-list">
						
						<c:forEach var="dto" items="${review }">
							
							<div class="ne-sc item">
								<div class="ne-sc-title">${dto.nickName }</div>
								
								<div class="review">
									<span>만족도</span>
									<span><c:forEach begin="1" end="${dto.satisfaction }">★</c:forEach><c:forEach begin="${dto.satisfaction +1 }" end="5">☆</c:forEach>
									</span>
								</div>
								
								<div class="review">
									<span>체감난이도</span>
									<span><c:forEach begin="1" end="${dto.difficulty }">★</c:forEach><c:forEach begin="${dto.difficulty +1 }" end="5">☆</c:forEach>
									</span>
								</div>
								
								<div class="review">
									<span>체감공포도</span>
									<span><c:forEach begin="1" end="${dto.horror }">★</c:forEach><c:forEach begin="${dto.horror +1 }" end="5">☆</c:forEach>
									</span>
								</div>
								
								<div class="review">
									<span>체감활동도</span>
									<span><c:forEach begin="1" end="${dto.activity }">★</c:forEach><c:forEach begin="${dto.activity +1 }" end="5">☆</c:forEach>
									</span>
								</div>
								
								<div class="review">
									<span>몰입도</span>
									<span><c:forEach begin="1" end="${dto.immersion }">★</c:forEach><c:forEach begin="${dto.immersion +1 }" end="5">☆</c:forEach>
									</span>
								</div>
								
								<div class="comment">
									<p>${dto.reviewComment }</p>
								</div>
								
							</div>
							
						</c:forEach>
						
						<!-- <div class="ne-sc item">
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
							
						</div> -->
						
					</div>
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>