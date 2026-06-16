<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 예약현황</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/resList.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function(){
		
	    // 페이지 진입 시 첫 번째 카페 자동 선택 + 테마/목록 로드
	    const firstCafe = $("#schCafe option:first").val();
	    
	    if(firstCafe){
	        $("#schCafe").val(firstCafe);
	        loadTheme(firstCafe);
	    }
		
	    
	    // 목록 로드
	    loadList(0);
	    
	    // 카페 셀렉트 변경 시 테마 목록/예약 현황 목록 갱신
	    $("#schCafe").on("change", function(){
	        loadTheme($(this).val());
	        // 카페 변경 시 예약 목록 초기화
	        loadList(0);
	    });
	    
	    // 날짜 변경 시 예약 현황 목록 갱신
		$("#schDate").on("change", function(){
			loadList(0);
		});
	    
	    // 테마 변경 시 예약 현황 목록 갱신 
	    $("#schTheme").on("change", function(){
			loadList(0);	    	
	    });
	    
	    
	    // 더보기 버튼 컨트롤
	    let currentOffset = 0;
	    $("#moreBtn").on("click", function(){
	    	currentOffset += 3;
	    	loadList(currentOffset);
	    });
	    
	    // 예약 상세 버튼 
		// 처음 로드될 때는 .detailBtn이 존재하지 않기 때문에(동적으로 생성)
	    // 도큐먼트에 클릭 이벤트를 주고 .detailBtn인거를 찾기?
	    $(document).on("click",".detailBtn",function(){
	    	const btn = $(this);
	    	const resId = btn.data("reservation-id");
	    	
	    	$.ajax({
	    		  url: "/owner/resList/detail"
	    		, type: "POST"
	    		, data: {resId: resId}
	    		, success: function(item){
	    			$("#modal-name").text(item.bookerName);
	    			$("#modal-tel").text(item.bookerTel);
	    			$("#modal-member").text(item.totalMember);
	    		}
	    	});
	    	
	    	
	    	$("#detailModal").modal("show");
	    });
	    
	    
	});

	
	// 테마 목록 AJAX
	function loadTheme(cafeId){
		
	    $("#schTheme").empty().append('<option value="">전체 테마</option>');

	    if(!cafeId) return;

	    $.ajax({
	          url: '/owner/openRes/theme'
	        , type: 'GET'
	        , data: {cafeId: cafeId}
	        , success: function(res){
	            res.forEach(function(room){
	                $("#schTheme").append(
	                    '<option value="' + room.roomId + '">' + room.roomName + '</option>'
	                );
	            });
	        }
	    });
	}

	function loadList(offset){
	
	    const schDate = $("#schDate").val();
	    const cafeId  = $("#schCafe").val();
	    const roomId  = $("#schTheme").val();
	
	    if(!schDate || !cafeId) 
	    	return;
	
	    
	    $.ajax({
	          url: '/owner/resList/list'
	        , type: 'GET'
	        , data: {schDate: schDate, cafeId: cafeId
	        	, roomId: roomId, offset: offset}
	        , success: function(res){
	
	            const tbody = $("tbody");
	
	            if(offset === 0) 
	            	tbody.empty();  
	
	            if(res.length == 0 && offset === 0){
	                tbody.append('<tr><td colspan="5" class="text-center">예약 내역이 없습니다.</td></tr>');
	                $('#moreBtn').hide();
	                return;
	            }else if (res.length == 0 && offset > 0) {
	                // 더보기 중에 데이터가 더 없으면 버튼 숨기기
	                $('#moreBtn').hide();
	                return;
	            }
	
	            res.forEach(function(item, index){
	            	
	            	let rowNum = offset+index+1;
	            	
	                tbody.append(
	                    '<tr class="res_' + item.reservationId + '">' +
	                    '<td>' +  rowNum + '</td>' +
	                    '<td>' + item.cafeName + '</td>' +
	                    '<td>' + item.roomName + '</td>' +
	                    '<td style="font-size: 16px; font-weight: bold;">' + item.openAt + '</td>' +
	                    '<td><button type="button" class="btn btn-outline-primary detailBtn" data-reservation-id='
	                    + item.reservationId +
	                    '>예약자 상세</button></td>' +
	                    '<td><button type="button" class="btn ne-btn-deact" ' +
	                        'onclick="deleteOk(' + item.reservationId + ')">예약 취소</button></td>' +
	                    '</tr>'
	                );
	            });
	
	            // 3개 미만이면 더보기 숨김
	            if(res.length < 3){
	                $('#moreBtn').hide();
	            } else {
	                $('#moreBtn').show();
	            }
	        }
	    });
	}
	
	function deleteOk(resId){
	
		if(confirm('정말 예약을 취소하시겠습니까?')){
			
			$.ajax({
				url: "/owner/resList/delete"
				, type: "POST"
				, data: {resId, resId}
				, success: function(res){
						alert(res.message);
					if(res.success)
						$(".res_"+resId).remove();
				},
	            error: function() {
	                alert("서버 통신 중 오류가 발생했습니다.");
	            }
			});
		}
	}

		

</script>
</head>
<body>
	<div class="modal fade" id="detailModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">예약 상세</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					     <p><span class="text-muted">예약자 이름</span> &nbsp; <strong id="modal-name"></strong></p>
		                <p><span class="text-muted">예약자 연락처</span> &nbsp; <strong id="modal-tel"></strong></p>
		                <p><span class="text-muted">예약 인원</span> &nbsp; <strong id="modal-member"></strong>명</p>
				</div>
				<div class="modal-footer">
                	<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
            	</div>
			</div>
		</div>
	</div>


	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex">
			<aside class="col-md-2">
					<%@ include file="/WEB-INF/views/common/ownerSide.jsp"%>
			</aside>
			<div class="col-md-10 resWrap">
				<div class="title">예약 현황</div>
				<div class="d-flex justify-content-between">
					<div class="resList">
						<div class="inputBox d-flex">
							<input type="date" class="ne-box" value="${schDate }" id="schDate" />
							<select name="schCafe" id="schCafe" class="ne-box">
								<c:forEach var="list" items="${cafeList }">
									<option value="${list.cafeId }"  <c:if test="${list.cafeId == schCafe}">selected</c:if>>${list.cafeName }</option>
								</c:forEach>
							</select>
							<select name="schTheme" id="schTheme" class="ne-box">
								<option></option>
							</select>
						</div>
						<table class="ne-table">
							<thead>
								<tr>
									<th>번호</th>
									<th>카페</th>
									<th>테마</th>
									<th>예약일</th>
									<th colspan="2"></th>
								</tr>
							</thead>
							<tbody>
								 <c:choose>
							        <c:when test="${empty resList}">
							            <tr>
							                <td colspan="5" class="text-center">예약 내역이 없습니다.</td>
							            </tr>
							        </c:when>
							        <c:otherwise>
							            <c:forEach var="res" items="${resList}" varStatus="vs">
							                <tr class="res_${res.reservationId }">
							                    <td>${vs.count}</td>
							                    <td>${res.cafeName}</td>
							                    <td>${res.roomName}</td>
							                    <td>${res.openAt}</td>
							                    <td>
							                        <button type="button" class="btn btn-outline-primary">예약 상세</button>
							                        <button type="button" class="btn ne-btn-deact"
							                                onclick="deleteOk(${res.reservationId})">예약 취소</button>
							                    </td>
							                </tr>
							            </c:forEach>
							        </c:otherwise>
							    </c:choose>
							</tbody>
						</table>
						<div id="noRes" class="text-center" style="display: none;">등록된 예약이 없습니다.</div>
						<button type="button" id="moreBtn" class="btn ne-btn" style="display: none; width: 100%; margin: 0 auto;">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-down-circle-fill" viewBox="0 0 16 16">
  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293z"/>
</svg>
						</button>
						
					</div>
				</div>
			</div>
		</div>

	</main>
	

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>