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

	.info
	{
		padding-top: 30px;
		display: flex;
	}
	
	.image
	{
		width: 300px;
		height: 500px;
		background-color: white; 
		margin-right: 30px;
	}
	
	.description
	{
		text-align: center;
		border-collapse: collapse;
	}


	.description th,
	.description td { border-bottom: 1px solid #ccc; }
	
	.description tr:last-child th,
	.description tr:last-child td { border-bottom: none; }
	
	.description th,
	.description td { padding: 6px 10px; }
		
	.description th
	{	
		width: 50px;
		border-right: 1px solid #ccc;
		background-color: #e5e7eb;
	}
	
	.description td
	{
		width: 700px;
	}

	.comment
	{
		display: grid;
		grid-template-columns: repeat(3, 1fr);
	    gap: 10px;
	}
	
	.schedule .date,
	.schedule .time
	{
		display: flex;
		flex-wrap: wrap;
		gap: 8px;
	}
	
	
	.schedule .date 
	{ 
		margin-bottom: 16px; 
	}
	
	.schedule .time
	{
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(72px, 1fr));
	}
	
	.schedule button
	{
		padding: 8px 14px;
		border: 1px solid #ccc;
		border-radius: 6px;
		background: #fff;
		cursor: pointer;
		font-size: 13px;
	}
	
	.schedule button:hover 
	{
	 	background: #f3f3f3; 
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
					
					<br>
					
					<div class="schedule">
						
						<div class="date">
							
							<button type="button">2026-06-01</button>
							<button type="button">2026-06-02</button>
							<button type="button">2026-06-03</button>
							<button type="button">2026-06-04</button>
							<button type="button">2026-06-05</button>
							
						</div>
									
						<div class="time">
							
							<button type="button">10:00</button>
							<button type="button">12:00</button>
							<button type="button">14:00</button>
							<button type="button">16:00</button>
							<button type="button">18:00</button>
							
						</div>									
									
					</div>
					
					<br>
						
					<br><br>
					
					<div class="review">
						
						<div class="total">
														
							<div class="ne-sc item">
							  <div class="ne-sc-title">리뷰 통계</div>
							  	
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
						
						<br>
						
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