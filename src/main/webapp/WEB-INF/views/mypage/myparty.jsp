<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myparty.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.container
{
	display: flex;
	flex-direction: column;
	gap:10px;
}

.header
{
	text-align: center;
	margin-top: 10px;
}

.header > .title
{
	font-weight: bold;
}

.body
{
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
	gap: 10px;
}

.body > div
{
	height: 600px;
	
	border: 1px solid black;
	border-radius: 5px;
	padding: 10px;
	
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.body > div > span:first-child 
{
	font-weight: bold;
	font-size: 15px;	
}

.apply-list,
.current-party-list,
.end-party-list
{
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.apply-item,
.current-item,
.end-item
{
	display: flex;
	justify-content: space-between;
	border: 1px solid black;
	border-radius: 5px;
	padding: 5px;
}

.action-btn
{
	border: 1px solid black;
	border-radius: 5px;
	width: 50px;
	background: #f5f5f5;
}

.action-btn:hover 
{
	background: orange;
	font-weight: bold;	
}

</style>


</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="header">
					<span class="title">파티 정보</span>
				</div>
				
				<div class="body">
					
					<div class="party-apply">
						<span>파티 신청 현황</span>
						<hr>
						
						<div class="apply-list">
							
							<div class="apply-item">
								
								<div class="apply-info">
									
									<span>주열룸</span>
									<span>그레이</span>
									<span>06-03</span>
									<span>18:00</span>
									
								</div>
								
								<div class="apply-status">
									
									<button type="button" class="action-btn">취소</button>
									
								</div>
								
							</div>
							
						</div>
						
					</div>
					
					<div class="current-party">
						<span>현재 파티</span>
						<hr>
						
						<div class="current-party-list">
							
							<div class="current-item">
								
								<div class="current-info">
									<span>주열룸</span>
									<span>그레이</span>
									<span>06-03</span>
									<span>18:00</span>
								</div>
								
								<div class="current-btn">
									<button type="button" class="action-btn">보드</button>
								</div>
								
							</div>
							
						</div>
						
					</div>
					
					<div class="end-party">
						<span>종료된 파티</span>
						<hr>
						
						<div class="end-party-list">
						
							<div class="end-item">
								
								<div class="end-info">
									<span>주열룸</span>
									<span>그레이</span>
									<span>06-03</span>
									<span>18:00</span>
								</div>
								
								<div class="end-btn">
									<button type="button" class="action-btn">보드</button>
								</div>
							
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