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

	.comment
	{
		display: grid;
		grid-template-columns: repeat(3, 1fr);
	    gap: 10px;
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
						
						<span>테마이미지</span><br>				
						<span>카페명</span><br>
						<span>카페연락처</span><br>
						<span>카페위치</span><br>
						<span>테마명</span><br>
						<span>테마소개</span><br>
						<span>소요시간</span><br>
						<span>1인 가격</span><br>
						<span>난이도</span><br>
						<span>활동도</span><br>
						<span>공포도</span><br>
						<span>최소인원</span><br>
						<span>최대인원</span><br>
						<span>성인유무</span><br>
						
					</div>
					
					<br>
					
					<div class="schedule">
						
						<span>날짜</span>
						<span>시간</span>
						<span>시간</span>
						<span>시간</span>
						<span>시간</span>
						
						<br>
						<span>날짜</span>
						<span>시간</span>
						<span>시간</span>
						<span>시간</span>
						<span>시간</span>
						
						<br>
									
					</div>
					
					<br>
						
						<button type="button">파티 개설</button>
						
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