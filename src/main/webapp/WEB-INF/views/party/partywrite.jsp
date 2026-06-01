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

.write
{
	background-color: white;
	width: 40%;
	margin: 0 auto;     
	padding: 30px;     
	margin-top: 30px;
}

form[name='writeForm'] 
{  
	margin: 0 auto;
	text-align: center;
}

.write table 
{
	margin: 0 auto;
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="write">
					
					<form action="" name="writeForm">
						
						<table>
							<tr>
								<th>카페명</th>
								<td>
									바인딩 한 카페명
								</td>
							</tr>
							<tr>
								<th>테마명</th>
								<td>
									바인딩한 테마명
								</td>
							</tr>
							<tr>
								<th>예약일시</th>
								<td>
									바인딩한 일시
								</td>							
							</tr>
							<tr>
								<th>파티명</th>
								<td>
									<input type="text" name="partyName">
								</td>							
							</tr>
							<tr>
								<th>성별 조건</th>
								<td>
									<label>
										<input type="radio" value="0" name="gender" checked="checked"> 무관
									</label>
									<label>
										<input type="radio" value="1" name="gender"> 동성
									</label>
								</td>
							</tr>
							<tr>
								<th>한마디</th>
								<td>
									<input type="text" name="partyComment">
								</td>
							</tr>
						</table>
						
						<br>
						
						<button type="button">개설하기</button>
						 
					</form>
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>