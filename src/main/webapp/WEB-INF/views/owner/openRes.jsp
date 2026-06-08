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

	function deleteOk(){
		if(confirm('정말 비활성화 하시겠습니까?')){
			//const url = "${pageContext.request.contextPath}/owner/res/delete/${dto.num}?;
			location.href=url;
		}
	}
	
	$(function(){
		
		$("#cafeSelect").on('change', function(){
			const cafeId = $(this).val();

			$("#themeSelect").empty().append('<option value="" disabled selected>-- 테마 선택 --</option>');
			
			if(!cafeId)
				return;
		
			
			$.ajax({
				  url: '/openRes/theme'
				, type: 'GET'
				, data: {cafeId:cafeId}
				, success: function(res){
					  res.forEach(function(room){
					        $("#themeSelect").append('<option value="' + room.roomId + '">' + room.roomName + '</option>');
					    });
				}
			});
		
		});
		
		
		// 예약시간 등록 버튼 클릭
		$('#openResBtn').on('click', function(){

		    const cafeId  = $('#cafeSelect').val();
		    const roomId  = $('#themeSelect').val();
		    const date    = $('#openDate').val();
		    const hour    = $('select[name="hour"]').val();
		    const min     = $('select[name="min"]').val();

		    // 유효성 체크
		    if(!cafeId || cafeId == '') { alert('카페를 선택해주세요.'); return; }
		    if(!roomId || roomId == '') { alert('테마를 선택해주세요.'); return; }
		    if(!date)                   { alert('날짜를 선택해주세요.'); return; }

		    $.ajax({
		          url: '/openRes/open'
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
		                location.reload();
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
	
	// 목록 조회 함수
	function loadList(schDate, schCafe) {
	    $.ajax({
	          url: '/openRes/list'
	        , type: 'GET'
	        , data: { schDate: schDate, schCafe: schCafe || '' }
	        , success: function(res) {
	            const tbody = $('tbody');
	            tbody.empty();
	            
	            if(res.length == 0) {
	                tbody.html('<tr><td colspan="5" class="text-center">등록된 슬롯이 없습니다.</td></tr>');
	                return;
	            }
	            
	            res.forEach(function(item) {
	                tbody.append(
	                    '<tr>' +
	                    '<td>' + item.cafeName + '</td>' +
	                    '<td>' + item.roomName + '</td>' +
	                    '<td>' + item.openDate + '</td>' +
	                    '<td class="fw-bold">' + item.openTime + '</td>' +
	                    '<td><button type="button" class="btn ne-btn-deact">비활성화</button></td>' +
	                    '</tr>'
	                );
	            });
	        }
	    });
	}

	$(function(){
	    // 페이지 로드시 오늘 날짜 목록 조회
	    loadList('${schDate}', null);
	    
	    // 날짜 변경시
	    $('input[name="schDate"]').on('change', function(){
	        loadList($(this).val(), $('select[name="schCafe"]').val());
	    });
	    
	    // 카페 변경시
	    $('select[name="schCafe"]').on('change', function(){
	        loadList($('input[name="schDate"]').val(), $(this).val());
	    });
	    
	    // 등록 성공 후
	    // success 안에서 location.reload() 대신
	    // loadList(date, cafeId); 로 바꾸면 페이지 새로고침 없이 목록 갱신
	});
	
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
							<input type="date" id="openDate" name="date" class="ne-box selectBox" value="${schDate }"/>
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
								 
								 	<select name="schCafe" class="selectBox ne-box">
								 		<option value="">전체 카페</option>
								 		<c:forEach var="list" items="${cafeList }">
									 		<option value="${list.cafeId }">${list.cafeName }</option>
								 		</c:forEach>
								 	</select>
								 	<input type="date" class="ne-box" name="schDate" value="${schDate }"/>
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
							<c:forEach var="list" items="${openList.list }">
								<tr>
									<td>${list.cafeName }</td>
									<td>${list.roomName }</td>
									<td>${list.openDate }</td>
									<td class="fw-bold">${list.openTime }</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk()">비활성화</button>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test="${empty openList.list }">
							<div class="text-center">등록된 슬롯이 없습니다.</div>
						</c:if>
						${openList.paging }
					</div>
				</div>
			</div>
		</div>

	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>