<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partywrite.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="write">
					
					<form action="">
						
						<span>카페명 : </span><br>
						<span>테마명 : </span><br>
						<span>예약시간 : </span><br>
						파티명 : <input type="text"><br>
						성별 조건 : 무관 <input type="radio" value="0"> 동성만<input type="radio" value="1"> <br>
						한마디 : <input type="text"> <br>
						
						<button type="button">개설하기</button>
						 
					</form>
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>