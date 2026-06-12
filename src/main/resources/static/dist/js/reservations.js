$(function(){
	

	$(".cancelBtn").click(function(){
			
		const btn = $(this);
		const openAt = btn.data("open-at");
		
		// 24시간 체크
		   const openDate = new Date(openAt.replace(" ", "T"));
		   const diff = openDate - new Date();
		   if(diff < 24 * 60 * 60 * 1000) {
		       alert("예약 시간 24시간 이전에는 취소가 불가합니다.");
		       return;
		   }
		   
		   // 모달에 데이터 세팅
		   $("#modal-cafe-name").text(btn.data("cafe-name"));
		   $("#modal-room-name").text(btn.data("room-name"));
		   $("#modal-open-at").text(openAt);
		   $("#modal-total-member").text(btn.data("total-member"));
		   $("#modal-party-name").text(btn.data("party-name"));
		   
		   $("#modalConfirmBtn")
		       .data("reservation-id", btn.data("reservation-id"))
		       .data("party-id", btn.data("party-id"));
		   
		   $("#cancelModal").modal("show");
	});

	
	$("#modalConfirmBtn").click(function(){
		
		const reservationId = $(this).data("reservation-id");
		
		$.ajax({
			  url: "/mypage/reservations/cancel"
			, type: "POST"
			, data: {reservationId: reservationId}
			, success: function(res){
				console.log("응답: ",res);
				if(res.success){
					alert(res.message);
					location.reload();
				} else{
					alert(res.message);
				}
				$("#cancelModal").modal("hide");
			}
			, error : function(){
				alert("오류가 발생했습니다.");
			}
		});
		
		
	});
	
});