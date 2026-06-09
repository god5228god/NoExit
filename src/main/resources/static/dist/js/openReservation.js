
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

// 목록 조회 - AJAX
function loadList(schDate, schCafe) {
    $.ajax({
          url: '/openRes/list'
        , type: 'GET'
        , data: { schDate: schDate, schCafe: schCafe}
        , success: function(res) {
            const tbody = $('tbody');
            tbody.empty();
            
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