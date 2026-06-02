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
	
	.body
	{
		margin-top: 10px;
		padding: 10px;
		background-color: blue;
		
		display: grid;
		grid-template-columns: 2fr 5fr;
	    gap: 10px;
	}
	
	.image
	{
		background-color: white;
	}
	
	.description
	{
		background-color: yellow;
	}
	
	.description th,
	.description td
	{
		text-align: center;
	}
	
	.description th
	{
		width: 30%;
	}
	
	.description td
	{
		width: 60%;
	}
	
</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class= "body">
					
					<div class="image">
						
						<span>테마이미지</span><br>	
						
					</div>
					
					<div class="description"> 
						
						<table>
							<tr>
								<th>테마명</th>
								<td>그레이</td>
							</tr>
							<tr>
								<th>예약일시</th>
								<td>2026-06-01 18:00</td>
							</tr>
							<tr>
								<th>파티명</th>
								<td>주열룸</td>
							</tr>
							<tr>
								<th>파티장</th>
								<td>윤주열 19 남</td>
							</tr>
							<tr>
								<th>성별 조건</th>
								<td>동성만</td>
							</tr>
							<tr>
								<th>현재 인원</th>
								<td>2명</td>
							</tr>
							<tr>
								<th>방장의 한마디</th>
								<td>미쿠 좋아하는 사람만</td>
							</tr>
						</table>
						
					</div>
					
				</div>
				
				<div class="action">
					
					<input type="text" name="comment" placeholder="신청 메시지"><br>
					<button type="button">신청하기</button> or
					<button type="button">취소하기</button>
					
				</div>	
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>