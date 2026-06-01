<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partydetail.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="info">
					
					<span>테마이미지</span><br>
					<span>테마명</span><br>
					<span>최소인원</span><br>
					<span>최대인원</span><br>
					<span>예약시간</span><br>
					<span>파티명</span><br>
					<span>성별조건</span><br>
					<span>개설일</span><br>
					<span>현재파티원</span><br>
					<span>한마디</span><br>
					<span>파티상태</span><br>
					
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