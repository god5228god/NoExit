<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 출석체크</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/attendance.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">

	function attendOk(num){
		if(confirm('출석 처리 하시겠습니까?')){
			//const url = "${pageContext.request.contextPath}/owner/attendance/check/" + num;
			//location.href=url;
		}
	}
	
	function noshowOk(num){
		if(confirm('노쇼 처리 하시겠습니까?')){
			//const url = "${pageContext.request.contextPath}/owner/attendance/noshow/" + num;
			//location.href=url;
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
				<div class="title">출석 체크</div>
				<div class="d-flex justify-content-between">
					<div class="resList">
						<div class="inputBox d-flex">
							<input type="date" class="ne-box" value="2026-06-05" />
							<select name="" id="" class="ne-box">
								<option>전체 카페</option>
								<option>카페1</option>
								<option>카페2</option>
							</select>
							<select name="" id="" class="ne-box">
								<option>전체 테마</option>
								<option>테마1</option>
								<option>테마2</option>
							</select>
						</div>
						<table class="ne-table">
							<thead>
								<tr>
									<th>시간</th>
									<th>카페</th>
									<th>테마</th>
									<th>예약자</th>
									<th>인원</th>
									<th>상태</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="fw-bold">10:00</td>
									<td>카페1</td>
									<td>테마1</td>
									<td>사용자1</td>
									<td>2명</td>
									<td><span class="status-wait">대기</span></td>
									<td>
										<button type="button" class="btn btn-primary" onclick="attendOk(1)">출석</button>
										<button type="button" class="btn ne-btn-deact" onclick="noshowOk(1)">노쇼</button>
									</td>
								</tr>
								<tr>
									<td class="fw-bold">12:00</td>
									<td>카페2</td>
									<td>테마2</td>
									<td>사용자2</td>
									<td>2명</td>
									<td><span class="status-done">출석</span></td>
									<td>-</td>
								</tr>
								<tr>
									<td class="fw-bold">14:00</td>
									<td>카페1</td>
									<td>테마2</td>
									<td>사용자3</td>
									<td>3명</td>
									<td><span class="status-noshow">노쇼</span></td>
									<td>-</td>
								</tr>
								<tr>
									<td class="fw-bold">16:00</td>
									<td>카페2</td>
									<td>테마1</td>
									<td>사용자4</td>
									<td>5명</td>
									<td><span class="status-wait">대기</span></td>
									<td>
										<button type="button" class="btn btn-primary" onclick="attendOk(4)">출석</button>
										<button type="button" class="btn ne-btn-deact" onclick="noshowOk(4)">노쇼</button>
									</td>
								</tr>
								<tr>
									<td class="fw-bold">18:00</td>
									<td>카페2</td>
									<td>테마2</td>
									<td>사용자5</td>
									<td>2명</td>
									<td><span class="status-wait">대기</span></td>
									<td>
										<button type="button" class="btn btn-primary" onclick="attendOk(5)">출석</button>
										<button type="button" class="btn ne-btn-deact" onclick="noshowOk(5)">노쇼</button>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="paginate">							
							<span class="active">1</span>
							<a href="#">2</a>
							<a href="#">3</a>					
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
