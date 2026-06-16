<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No Exit - 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/dist/css/reservation.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#resBtn").on("click", function(){
		const partyId = $(this).data("party-id");

 		$.ajax({
			url: "reservation/action"
			, type: "POST"
			, data: {partyId, partyId}
 			, success: function(res){
 				alert(res.message);
 				if(res.success){
 					location.href="/mypage/reservations";
 				}else{
 					location.href="/party/board/"+partyId;
 				}
 			}
 			 , error: function(){
		            alert('오류가 발생했습니다.');
		        }
		});
	});
	
	
});

</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
	<main class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex justify-content-between ">
			<div class="col-md-8 ne-wrap">
				<div class="themeWrap content-box-yellow mb-2 d-flex align-items-center">
					<div class="icon">🔐</div>
					<div class="themeInfo">
						<p class="cafeName">${bookerInfo.cafeName }</p>
						<p class="themeName">${bookerInfo.roomName }</p>
						<p class="reservDate">${bookerInfo.openAt } </p>
					</div>
				</div>
				<div class="reservWrap content-box mb-2">
					<div class="ne-title">
						예약자 정보
					</div>
					<form name="reservForm" method="post">
						<div class="d-flex justify-content-between align-items-center mb-4">
							<div>
							<!-- 수정 불가 리드온리로 구성 이러면 예약자 목록?파티원 목록 뿌려주는거로 바꾸는것도 고려해보기  -->
								<label for="name" class="label">이름</label><br>
								<input type="text" id="name" name="name" class="ne-box" readonly="readonly" value="${bookerInfo.bookerName }"/>
							</div>
							<div>
								<label for="phone" class="label">연락처</label><br>
								<input type="tel" id="phone" name="phone" class="ne-box" readonly="readonly" value="${bookerInfo.bookerTel }"/>
							</div>
						</div>
						<div class="mb-2">
							<p class="label">총 방문 인원</p>
							<div class="d-flex justify-content-between align-items-center mt-1" style="width: 20%;">
								<span class="personCount">${bookerInfo.totalMember }</span>
								<span style="font-size: 14px; color: #666;">명</span>
							</div>
						</div>
					</form>
				</div>
				<div class="content-box reservInfo mb-3">
					<div class="ne-title">
						예약 안내사항
					</div>
					<ul>
						<li>예약 확정 후 현장 결제로 진행됩니다.</li>
						<li>예약 10분 전까지 도착해주세요.</li>
						<li>예약 시간 24시간 이전까지만 예약 가능합니다.</li>
					</ul>
				</div>
				<div class="btnWrap">
					<button type="button" class="btn btn-primary" id="resBtn" data-party-id="${bookerInfo.partyId }">예약 확정하기</button>
				</div>
			</div>
			<div class="col-md-3 ne-wrap">
				<div class="payWrap content-box-yellow">
					<div class="ne-title mb-4">
						예약 정보
					</div>
					<div class="text-center mb-3">
						<img src="${contextPath.request.contextPath }/dist/images/${bookerInfo.roomImg }" alt="테마이미지" style="height: 250px;"/>
					<%-- 	${pageContext.request.contextPath}/dist/images/${bookerInfo.roomImg }--%>
						
						
					</div>
					<div class="d-flex justify-content-between mb-2">
						예약 테마명
						<span>${bookerInfo.roomName }</span>
					</div>
					<div class="d-flex justify-content-between mb-2">
						예약 날짜
						<span>${bookerInfo.openAt }</span>
					</div>
					<div class="d-flex justify-content-between mb-2">
						1인 기준가
						<span> 
							<fmt:formatNumber value="${bookerInfo.price }" pattern="#,###"/>
							원
						</span>
					</div>
					<div class="d-flex justify-content-between mb-2">
						총 인원
						<span>${bookerInfo.totalMember }명</span>
					</div>
					<div class="line"> </div>
					<div class="d-flex justify-content-between total">
						합계(현장결제)
						<span>
						<fmt:formatNumber value="${bookerInfo.price * bookerInfo.totalMember }" pattern="#,###"/>
						원
						</span>
					</div>
				</div>
				
			</div>
		</div>
		
	</main>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>