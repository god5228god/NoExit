<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No Exit - 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/dist/css/reservation.css" />

<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function() {
		
		const defaultNum = parseInt($(".personCount").text());
		// 테마의 최대 인원 가져오기
		//const maxNum;
		
		$(".circle").click(function(){
			
			const op = $(this).data('action');

			let currentNum = parseInt($(".personCount").text());
			
			// ※ 테마의 최대 인원수까지만 증가할 수 있도록 구성
			//	  기본세팅(파티인원수)까지만 감소할 수 있도록 구성
			if(op=="plus"){
				/* if(currentNum <= maxNum){
					currentNum++;
				}  */
				currentNum++;
			}else{
				if(currentNum>1 && currentNum > defaultNum){
					currentNum--;
				}				
			}
			
			$(".personCount").text(currentNum);
			
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
						<p class="cafeName">홍대 방탈출 공장</p>
						<p class="themeName">어둠의 저택</p>
						<p class="reservDate">2026-06-02(화) 14:00 </p>
					</div>
				</div>
				<div class="reservWrap content-box mb-2">
					<div class="ne-title">
						예약자 정보
					</div>
					<form name="reservForm" method="post">
						<div class="d-flex justify-content-between align-items-center mb-4">
							<div>
								<label for="name" class="label">이름 <span>*</span></label><br>
								<input type="text" id="name" name="name" class="ne-box" maxlength="13"/>
							</div>
							<div>
								<label for="phone" class="label">연락처 <span>*</span></label><br>
								<input type="tel" id="phone" name="phone" class="ne-box" placeholder="하이픈 제외 입력 (ex. 01012345678)" maxlength="11"/>
							</div>
						</div>
						<div class="mb-2">
							<p class="label">총 방문 인원</p>
							<div class="d-flex justify-content-between align-items-center mt-1" style="width: 20%;">
								<button type="button" class="circle" data-action="minus">-</button>
								<span class="personCount">4</span>
								<button type="button" class="circle" data-action="plus">+</button>
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
					<button type="button" class="btn btn-primary">예약 확정하기</button>
				</div>
			</div>
			<div class="col-md-3 ne-wrap">
				<div class="payWrap content-box-yellow">
					<div class="ne-title mb-4">
						예약 정보
					</div>
					<div class="text-center mb-3">
						<img src="https://placehold.co/120x160" alt="테마이미지" />
					</div>
					<div class="d-flex justify-content-between mb-2">
						예약 테마명
						<span>어둠의 저택</span>
					</div>
					<div class="d-flex justify-content-between mb-2">
						예약 날짜
						<span>2026-06-02 14:00</span>
					</div>
					<div class="d-flex justify-content-between mb-2">
						1인 기준가
						<span>25,000원</span>
					</div>
					<div class="d-flex justify-content-between mb-2">
						총 인원
						<span>2명</span>
					</div>
					<div class="line"> </div>
					<div class="d-flex justify-content-between total">
						합계(현장결제)
						<span>50,000원</span>
					</div>
				</div>
				
			</div>
		</div>
		
	</main>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>