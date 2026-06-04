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
<script type="text/javascript">

	function deleteOk(){
		if(confirm('정말 비활성화 하시겠습니까?')){
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
				<div class="title">예약 등록</div>
				<div class="d-flex justify-content-between">
					<div class="resOpen">
						<div class="res-title">예약 시간 등록</div>
						<form method="post" name="resOpenForm">
							<div class="from-label">카페 선택</div>
							<select name="" id="" class="selectBox ne-box">
								<option value="" disabled selected>-- 카페 선택 --</option>
								<option>지구별</option>
								<option>우주별</option>
							</select>
							<div class="form-label">테마 선택</div>
							<select name="" class="selectBox ne-box">
								<option value="" disabled selected>-- 테마 선택 --</option>
								<option value="">어둠의 저택</option>
								<option value="">바이러스 연구소</option>
							</select>
							<div class="form-label">날짜 선택</div>
							<input type="date" id="openDate" class="ne-box selectBox"/>
							<div class="form-label">시간 선택</div>
							<div class="timeWrap ">
								<select name="" id="" class="ne-box">
									<option value="0">00</option>
									<option value="1">01</option>
									<option value="2">02</option>
									<option value="3">03</option>
									<option value="4">04</option>
									<option value="5">05</option>
									<option value="6">06</option>
									<option value="7">07</option>
									<option value="8">08</option>
									<option value="9">09</option>
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
								<select name="" id="" class="ne-box ms-2">
									<option value="0">00</option>
									<option value="5">05</option>
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
							<button type="button" class="btn btn-primary">예약시간 등록</button>
						</form>
					</div>
					<div class="resOpenList">
						<div class="topWrap">
							<div class="res-title d-flex justify-content-between align-items-center">
								<span>등록된 슬롯</span>
								 <form action="">
								 	<select name="" id="" class="selectBox ne-box">
								 		<option value="">전체 카페</option>
								 		<option value="">지구별</option>
								 		<option value="">우주별</option>
								 	</select>
								 	<input type="date" class="ne-box" value="2026-06-01" />
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
								<tr>
									<td>지구별</td>
									<td>어둠의 저택</td>
									<td>2026-06-01</td>
									<td class="fw-bold">10:00</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk()">비활성화</button>
									</td>
								</tr>
								<tr>
									<td>지구별</td>
									<td>어둠의 저택</td>
									<td>2026-06-01</td>
									<td class="fw-bold">15:00</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk()">비활성화</button>
									</td>
								</tr>
								<tr>
									<td>지구별</td>
									<td>어둠의 저택</td>
									<td>2026-06-01</td>
									<td class="fw-bold">18:10</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk()">비활성화</button>
									</td>
								</tr>
								<tr>
									<td>우주별</td>
									<td>바이러스 연구소</td>
									<td>2026-06-01</td>
									<td class="fw-bold">12:15</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk()">비활성화</button>
									</td>
								</tr>
								<tr>
									<td>우주별</td>
									<td>바이러스 연구소</td>
									<td>2026-06-01</td>
									<td class="fw-bold">15:45</td>
									<td>
										<button type="button" class="btn ne-btn-deact" onclick="deleteOk()">비활성화</button>
									</td>
								</tr>
								
								
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

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>