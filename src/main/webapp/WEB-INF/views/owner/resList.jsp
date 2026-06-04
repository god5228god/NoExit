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
<script type="text/javascript">

	function deleteOk(){
		
		if(confirm('정말 예약을 취소하시겠습니까?')){
			//const url = "${pageContext.request.contextPath}/owner/res/delete/${dto.num}?;
			location.href=url;
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
				<div class="title">예약 현황</div>
				<div class="d-flex justify-content-between">
					<div class="resList">
						<div class="inputBox d-flex">
							<input type="date" class="ne-box" value="2026-06-01" />
							<select name="" id="" class="ne-box">
								<option>전체 카페</option>
								<option>지구별</option>
								<option>우주별</option>
							</select>
							<select name="" id="" class="ne-box">
								<option>전체 테마</option>
								<option>어둠의 저택</option>
								<option>바이러스 연구소</option>
							</select>
						</div>
						<table class="ne-table">
							<thead>
								<tr>
									<th>번호</th>
									<th>카페</th>
									<th>테마</th>
									<th>예약일</th>
									<!-- <th>예약자</th>
									<th>연락처</th>
									<th>인원</th> -->
									<th colspan="2"></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>지구별</td>
									<td>어둠의 저택</td>
									<td style="font-size: 16px;">2026-06-01 14:00</td>
									<td>
										<button type="button" class="btn btn-outline-primary">예약 상세</button>
										 <button type="button" class="btn ne-btn-deact" onclick="deleteOk()">예약취소</button>
									</td>
									<!-- <td>홍길동</td>
									<td>010-4544-4544</td>
									<td>4명</td> -->
								</tr>
		<!-- 						<tr class="cancle">
									<td>우주별</td>
									<td>바이러스 연구소</td>
									<td>2026-06-01 12:00</td>
									<td>윤주열</td>
									<td>010-1111-1111</td>
									<td>2명</td>
									<td>
										<button type="button" class="btn ne-btn-deact">예약취소</button>
									</td>
								</tr>
								<tr>
									<td>지구별</td>
									<td>어둠의 저택</td>
									<td>2026-06-01 10:00</td>
									<td>김민준</td>
									<td>010-1234-1234</td>
									<td>3명</td>
									<td>
										<button type="button" class="btn ne-btn-deact">예약취소</button>
									</td>
								</tr> -->
								
							</tbody>
						</table>
						<div class="paginate">
							<a href="#"> 1 </a>
							<a href="#"> 2 </a>
							<span class="active">3</span>
							<a href="#"> 4 </a>
							<a href="#"> 5 </a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</main>
<!-- <div class="modal fade" id="recordDetailModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered"> 
		<div class="modal-content">
		
			<div class="modal-header">
				<h5 class="modal-title" id="md-record-theme">예약 상 </h5>
				<span id="md-record-status" class="ms-3"></span>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			
			<div class="modal-body p-4" style="font-size: 14px;">
				
				<div class="ne-price-box mb-4">
					<div class="ne-price-row">
						<span class="ne-text-muted">예약자명</span>
						<strong id="md-record-time" class="text-dark"></strong>
					</div>
					<div class="ne-price-row">
						<span class="ne-text-muted">전화번호</span>
						<strong id="md-record-hint" class="text-dark"></strong>
					</div>
					<div class="ne-price-row total">
						<span>인원</span>
						<span id="md-record-players" class="ne-price-total-amount"></span>
					</div>
				</div>
				
			</div>
			
			<div class="modal-footer py-2">
				<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div> -->
	

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>