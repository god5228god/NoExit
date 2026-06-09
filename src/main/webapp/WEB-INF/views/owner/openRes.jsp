<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 예약등록</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/openRes.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		// 페이지 로드 시에 컨트롤러에서 넘겨준 schDate를 loadList()함수로 넘겨주기
		// 목록조회 ajax 처리하는 함수 loadList(schDate, schCafe)
		loadList("${schDate}", null);
		//-- 오늘날짜, 전체카페(null) 로 목록 조회
		
		// schDate 변경 시 목록 조회
		$("#selectDate").on("change", function(){
			loadList($(this).val(), $("#selectCafe").val());			
		});
		
		// schCafe 변경 시 목록 조회
		$("#selectCafe").on("change", function(){
			loadList($("#selectDate").val(), $(this).val());			
		});
		
		// 카페 셀렉트 변경 시 테마 셀렉트 변경 AJAX
		$("#cafeSelect").on("change", function(){
			
			const cafeId = $(this).val();
			
			$("#themeSelect").empty().append('<option value="" disabled selected>-- 테마 선택 --</option>');
			
			if(!cafeId)
				return;
			
			$.ajax({
				  url: '/owner/openRes/theme'
				, type: 'GET'
				, data: {cafeId:cafeId}
				, success: function(res){
					  res.forEach(function(room){
					        $("#themeSelect").append('<option value="' + room.roomId + '">' + room.roomName + '</option>');
					    });
				}
			});
			
		});
		// 예약 슬롯 등록 
		$("#openResBtn").on("click", function(){
			
			const cafeId  = $('#cafeSelect').val();
		    const roomId  = $('#themeSelect').val();
		    const date    = $('#openDate').val();
		    const hour    = $('select[name="hour"]').val();
		    const min     = $('select[name="min"]').val();
			
		 // 유효성 체크
		    if(!cafeId || cafeId == '') { alert('카페를 선택해주세요.'); return; }
		    if(!roomId || roomId == '') { alert('테마를 선택해주세요.'); return; }
		    if(!date)                   { alert('날짜를 선택해주세요.'); return; }

		 // 예약 슬롯 등록 폼 구성 AJAX 처리
		    $.ajax({
		          url: '/owner/openRes/open'
		        , type: 'POST'
		        , data: {
		              cafe:  cafeId
		            , theme: roomId
		            , date:  date
		            , hour:  hour
		            , min:   min
		          }
		        , success: function(res){
		            if(res.success){
		                alert(res.message);
		                // 등록 성공 후 등록한 건에 맞는 목록 조회 
		                $("#selectCafe").val(cafeId);
		                $("#selectDate").val(date);
		                loadList(date, cafeId);
		            } else {
		                alert(res.message);
		            }
		        }
		        , error: function(){
		            alert('오류가 발생했습니다.');
		        }
		    });
		    
		});
	});
	
	// 목록 조회 - AJAX
	function loadList(schDate, schCafe) {
	    $.ajax({
	          url: '/owner/openRes/list'
	        , type: 'GET'
	        , data: { schDate: schDate, schCafe: schCafe}
	        , success: function(res) {
	        	
	        	if(res.length==0){
	        		$('#emptyList').show();
	        	}else{
	        		$('#emptyList').hide();
	        	}
	        	
	            const tbody = $('tbody');
	            tbody.empty();
	            
	            res.forEach(function(item) {
	                tbody.append(
	                    '<tr>' +
	                    '<td>' + item.cafeName + '</td>' +
	                    '<td>' + item.roomName + '</td>' +
	                    '<td>' + item.openDate + '</td>' +
	                    '<td class="fw-bold">' + item.openTime + '</td>' +
	                    '<td><button type="button" class="btn ne-btn-deact" onclick="deleteOk('+item.resOpenId+')">슬롯 삭제</button></td>' +
	                    '</tr>'
	                );
	            });
	        }
	    });
	}
	
	
	// 비활성화 버튼 클릭
	function deleteOk(resOpenId){
	
		if(confirm("정말 삭제하시겠습니까?")){
			
			// 예약 슬롯 비활성화 폼 구성 AJAX 처리
		    $.ajax({
		          url: '/owner/openRes/delete'
		        , type: 'POST'
		        , data: {
		              resOpen:  resOpenId
		          }
		        , success: function(res){
		            if(res.success){
		                alert(res.message);
		                // 비활성화 성공 후 목록 조회 
		             	// 현재 선택된 날짜/카페로 목록 갱신
		                loadList($('#selectDate').val(), $('#selectCafe').val());
		            } else {
		                alert(res.message);
		            }
		        }
		        , error: function(){
		            alert('오류가 발생했습니다.');
		        }
		    });
			
		}
	}
	
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container d-flex">
			<aside class="col-md-2">
					<%@ include file="/WEB-INF/views/common/ownerSide.jsp"%>
			</aside>
			<div class="col-md-10 resWrap">
				<div class="title">예약 등록</div>
				<div class="d-flex justify-content-between">
					<div class="resOpen">
						<div class="res-title">예약 시간 등록</div>
						<form method="post" name="resOpenForm">
							<div class="form-label">카페 선택</div>
							<select name="cafe" class="selectBox ne-box" id="cafeSelect">
								<option value="" disabled selected>-- 카페 선택 --</option>
								<c:forEach var="list" items="${cafeList }">
									<option value="${list.cafeId }">${list.cafeName }</option>
								</c:forEach>
							</select>
							<div class="form-label">테마 선택</div>
							<select name="theme" class="selectBox ne-box" id="themeSelect">
								<option value="" disabled selected>-- 테마 선택 --</option>
							</select>
							<div class="form-label">날짜 선택</div>
							<input type="date" id="openDate" name="date" class="ne-box selectBox" value="${minDate }"
							min="<%= java.time.LocalDate.now().plusDays(1).toString() %>"/>
							<div class="form-label">시간 선택</div>
							<div class="timeWrap ">
								<select name="hour" class="ne-box">
									<option value="00">00</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
								</select> 시 
								<select name="min" class="ne-box ms-2">
									<option value="00">00</option>
									<option value="05">05</option>
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
									<option value="25">25</option>
									<option value="30">30</option>
									<option value="35">35</option>
									<option value="40">40</option>
									<option value="45">45</option>
									<option value="50">50</option>
									<option value="55">55</option>
								</select> 분
							</div>
							<button type="button" class="btn btn-primary" id="openResBtn">예약시간 등록</button>
						
						</form>
					</div>
					<div class="resOpenList">
						<div class="topWrap">
							<div class="res-title d-flex justify-content-between align-items-center">
								<span>등록된 슬롯</span>
								 <form action="">
								 
								 	<select name="schCafe" class="selectBox ne-box" id="selectCafe">
								 		<option value="">전체 카페</option>
								 		<c:forEach var="list" items="${cafeList }">
									 		<option value="${list.cafeId }">${list.cafeName }</option>
								 		</c:forEach>
								 	</select>
								 	<input type="date" class="ne-box" name="schDate" value="${schDate }" id="selectDate"
								 	min="<%= java.time.LocalDate.now().toString() %>"/>
								 </form>						
							</div>
						</div>
						<table class="ne-table">
							<thead>
								<tr>
									<th>카페</th>
									<th>테마</th>
									<th>날짜</th>
									<th>시간</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="list" items="${openList}">
								<tr>
									<td>${list.cafeName }</td>
									<td>${list.roomName }</td>
									<td>${list.openDate }</td>
									<td class="fw-bold">${list.openTime }</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk(${list.resOpenId})">비활성화</button>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						
						<div class="text-center" id="emptyList" style="display: none; margin-top: 10px;">등록된 슬롯이 없습니다.</div>
						
					</div>
				</div>
			</div>
		</div>

	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>