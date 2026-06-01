<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 기록 페이지</title>
<style type="text/css">

	.main-body {
		display: flex;                		/* 사이드바와 본문을 가로로 배치 */
		min-height: calc(100vh - 100px); 	/* 화면 전체 높이에서 헤더 높이 뺀 만큼 차지 */
	}

	.main-content {
			width : 65%;
			padding-top : 120px;
			padding-left: 20px;
		}
	.recordMenu {
		display: flex;
		gap: 20px;
	}
		
	.card-body{
		display: flex;
		gap:10px;
	}


		
</style>
</head>
<body>

<!--  본문 헤더 영역 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<!-- 본문 바디 영역 -->
<div class="main-body">
<%@ include file="/WEB-INF/views/common/myside.jsp" %>

	<div class="main-content">
		<div class="ne-sc">
			
		<div class="ne-sc-title" style="font-size: 30px;">개인 기록</div>
			
			<div class="card" style="width: 74rem;">
				<div class="card-body">
			    	<p>테마 이미지<p>
			    	<div>
			    		<p class="room-name">테마 제목</p>
			    		<p class="room-date">플레이일시</p>
			    	</div>
			    </div>
			</div>
		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>