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
								<option>전체 테마</option>
								<option>어둠의 저택</option>
								<option>바이러스 연구소</option>
							</select>
						</div>
						<table class="ne-table">
							<thead>
								<tr>
									<th>번호</th>
									<th>테마</th>
									<th>예약일</th>
									<th>예약자</th>
									<th>연락처</th>
									<th>인원</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">1</td>
									<td>어둠의 저택</td>
									<td>2026-06-01<br> 14:00</td>
									<td>홍길동</td>
									<td>010-4544-4544</td>
									<td>4명</td>
									<td>
										<button type="button" class="btn ne-btn-deact">예약취소</button>
									</td>
								</tr>
								<tr class="cancle">
									<td class="text-center">2</td>
									<td>바이러스 연구소</td>
									<td>2026-06-01 12:00</td>
									<td>윤주열</td>
									<td>010-1111-1111</td>
									<td>2명</td>
									<td>
										<!-- <button type="button" class="btn ne-btn-deact">예약취소</button> -->
									</td>
								</tr>
								<tr>
									<td class="text-center">3</td>
									<td>어둠의 저택</td>
									<td>2026-06-01 10:00</td>
									<td>김민준</td>
									<td>010-1234-1234</td>
									<td>3명</td>
									<td>
										<button type="button" class="btn ne-btn-deact">예약취소</button>
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