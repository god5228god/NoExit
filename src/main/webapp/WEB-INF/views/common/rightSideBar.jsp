<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 달력 레이아웃 CSS -->
<style>
	.fc-daygrid-day-frame {
	    height: 40px !important;
	    display: flex !important;
	    flex-direction: column !important;
	    justify-content: flex-start !important;
	    align-items: center !important;
	}
		
	.fc-daygrid-day-events {
	    order: 2 !important;
	    justify-content: center !important;
	}
		
	.fc-event-time, .fc-event-title {
	    display: none !important;
	    font-size: 0 !important;
	    line-height: 0 !important;
	    margin: 0 !important;
	    padding: 0 !important;
	}
	.fc-daygrid-event {
	    background: transparent !important;
	    border: none !important;
	    box-shadow: none !important;
	    padding: 0 !important;
	    margin: 0 !important;
	}
	.fc-daygrid-event-dot {
	
	    display: block !important;
	    border: none !important;
	    background-color: #0d6efd !important; 
	    width: 6px !important;
	    height: 6px !important;
	    border-radius: 50% !important;
	}
</style>

<!-- FULL CALENDAR CDN -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>

<script type="text/javascript">
	
	// DOM이 Loaded 되었을 때 실행
	document.addEventListener('DOMContentLoaded', function(){
		
		// 달력 div 영역
		let calendarEl = document.getElementById('calendar');
		
		
		// 달력 생성자 속성 구성----------------------------------------------------------------------
		let calendar = new FullCalendar.Calendar(calendarEl, {
			
			// 월별 달력
			initialView: 'dayGridMonth', 
			
	        // 상단 툴바 배치
	        headerToolbar: {
	        	center: 'title',
	            left: 'prev',
	            right: 'next'
	        },
	        
	        // 날짜 칸의 높이 자동 조절
	        height: 'auto', 
	        
	        
	        // 날짜 클릭 시 실행될 함수(풀 캘린더 내장 기능)
	        dateClick: function(info) {
	        	
	        	// 클릭한 날짜 문자열 파싱
	            let clickedDate = info.dateStr; 
	            console.log("선택한 날짜: " + clickedDate);

	            
	            // 클락한 날짜 정보 데이터 요청(ajax)
	            fetch(`${pageContext.request.contextPath}/reservation/detail?date=` + clickedDate)
	                .then(response => {
	                	
	                	// 예외처리
	                    if(!response.ok) throw new Error("예약 데이터 없음");
	                	
	                	// 성공 시 json 리턴
	                    return response.json();
	                })
	                .then(data => {
	                    // 백엔드에서 JSON 데이터를 정상적으로 받아왔을 때 모달 매핑
	                    
	                    // 모달 내부 텍스트 노드에 데이터 바인딩 (id 기준)
	                    document.getElementById('md-date').innerText = clickedDate;
	                    document.getElementById('md-time').innerText = data.createdAt;   // 예약일시
	                    document.getElementById('md-shop').innerText = data.cafeName;    // 카페이름
	                    document.getElementById('md-theme').innerText = data.roomName;   // 방이름
	                  // ※ 추가 데이터 구성 예정
	                    
	                    
	                    // 예약 모달 띄우기
	                    let myModal = new bootstrap.Modal(document.getElementById('reservationModal'));
	                    myModal.show();
	                })
	                .catch(error => {
	                    
	                	console.log("해당 날짜에 예약이 없거나 에러 발생");
	                    
	                    // 모달 테스트용 더미 예약 삽입-----------------------------------------------------
						document.getElementById('md-date').innerText = clickedDate;
	                    document.getElementById('md-time').innerText = "14:30";   
	                    document.getElementById('md-shop').innerText = "비트방탈출 강남점";    
	                    document.getElementById('md-theme').innerText = "강남 숨바꼭질";   
	                    
	                    let myModal = new bootstrap.Modal(document.getElementById('reservationModal'));
	                    myModal.show();
	                    //------------------------------------------------------------------------------------
	                    
	                    // ※ 예약 없는 날짜 클릭 무반응 처리 필요
	                });
	        },
	        
	        // css 테스트용 더미 데이터 
	        events: [
	            {
	                start: '2026-06-03T14:30:00',
	                display: 'list-item'
	            },
	            {
	                start: '2026-06-15',
	                display: 'list-item'
	            }
	        ]
	    }); //----------------------------------------------------------------------- 달력 생성자 속성 구성
	    
	    // 달력 생성
	    calendar.render();
	});
	

	</script>


</head>
<body>

<div class="right-sidebar">
		
	<!-- 달력 바인딩 영역 -->
	<div class="ne-sc m-0">
	    <div class="ne-sc-title">예약 캘린더</div>
	    
	    <div id="calendar" style="font-size: 14px;"></div>
	</div>
		
	
	<!-- 매너온도 섹션 -->
	<div class="ne-sc m-0">
	
		<!-- 매너온도 title -->
		<div class="ne-sc-title">매너 온도</div>
		
		<!-- 매너온도 뱃지 영역 -->
		<div class="d-flex align-items-center gap-2 mt-2">
			
			<!-- 매너온도 표기 영역 -->
			<span class="ne-mannero" style="font-size: 18px; padding: 0.4em 0.8em;">
				
				<!-- 부트스트랩 아이콘 영역	 -->				
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-fire" viewBox="0 0 16 16">
 						<path d="M8 16c3.314 0 6-2 6-5.5 0-1.5-.5-4-2.5-6 .25 1.5-1.25 2-1.25 2C11 4 9 .5 6 0c.357 2 .5 4-2 6-1.25 1-2 2.729-2 4.5C2 14 4.686 16 8 16m0-1c-1.657 0-3-1-3-2.75 0-.75.25-2 1.25-3C6.125 10 7 10.5 7 10.5c-.375-1.25.5-3.25 2-3.5-.179 1-.25 2 1 3 .625.5 1 1.364 1 2.25C11 14 9.657 15 8 15"/>
				</svg> ${userManner }°C
			</span>
		</div>
		
		<!-- 매너온도 텍스트 영역 -->
		<p class="ne-hint mt-3">매너온도는 매칭 시 참고 지표로 활용됩니다.<br>매너있는 플레이로 매너 온도를 높여보세요!</p>
	
	</div><!-- 매너온도 섹션 -->
	
</div><!-- 사이드 바 -->
	
	
	
<!-- 예약 조회 모달 (DB INSERT 후 TEST) -->
<div class="modal fade" id="reservationModal">
	<div class="modal-dialog modal-dialog-centered"> 
		<div class="modal-content">
			<div class="modal-header py-2">
				<h6 class="modal-title fw-bold" id="reservationModalLabel">예약 내역 상세</h6>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="font-size: 12px;"></button>
			</div>
			
			<div class="modal-body" style="font-size: 13px;">
				<div class="mb-2"><strong>날짜 :</strong> <span id="md-date" class="text-muted"></span></div>
				<div class="mb-2"><strong>시간 :</strong> <span id="md-time" class="badge bg-warning text-dark"></span></div>
				<div class="mb-2"><strong>매장 :</strong> <span id="md-shop" class="fw-bold"></span></div>
				<div><strong>테마 :</strong> <span id="md-theme" class="text-primary fw-bold"></span></div>
			</div>
		</div>
	</div>
</div>


</body>
</html>