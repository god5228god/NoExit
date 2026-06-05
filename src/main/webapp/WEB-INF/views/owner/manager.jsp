<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NoExit - 매니저관리</title>
<link rel="stylesheet"
	href='${pageContext.request.contextPath }/dist/css/manager.css' />
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">

	function deactOk(num){
		if(confirm('정말 비활성화 하시겠습니까?')){
			//const url = "${pageContext.request.contextPath}/owner/manager/deact/" + num;
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
				<div class="title">매니저 관리</div>
				<div class="d-flex justify-content-between">
					<div class="resList">
						<div class="inputBox d-flex justify-content-between">
							<div class="d-flex">
								<select name="" id="" class="ne-box">
									<option>전체 카페</option>
									<option>지구별</option>
									<option>우주별</option>
								</select>
								<select name="" id="" class="ne-box">
									<option>전체 상태</option>
									<option>활성</option>
									<option>비활성</option>
								</select>
							</div>
							<button type="button" class="btn btn-primary">매니저 등록</button>
						</div>
						<table class="ne-table">
							<thead>
								<tr>
									<th>번호</th>
									<th>이름</th>
									<th>담당 카페</th>
									<th>연락처</th>
									<th>입사일</th>
									<th>상태</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>홍길동</td>
									<td>지구별</td>
									<td>010-1234-5678</td>
									<td>2025-03-12</td>
									<td><span class="status-active">활성</span></td>
									<td>
										<button type="button" class="btn btn-outline-primary">수정</button>
										<button type="button" class="btn ne-btn-deact" onclick="deactOk(1)">비활성화</button>
									</td>
								</tr>
								<tr>
									<td>2</td>
									<td>김민준</td>
									<td>우주별</td>
									<td>010-2222-3333</td>
									<td>2025-07-01</td>
									<td><span class="status-active">활성</span></td>
									<td>
										<button type="button" class="btn btn-outline-primary">수정</button>
										<button type="button" class="btn ne-btn-deact" onclick="deactOk(2)">비활성화</button>
									</td>
								</tr>
								<tr class="cancle">
									<td>3</td>
									<td>윤주열</td>
									<td>지구별</td>
									<td>010-4544-4544</td>
									<td>2024-11-20</td>
									<td><span class="status-inactive">비활성</span></td>
									<td>-</td>
								</tr>
								<tr>
									<td>4</td>
									<td>이서연</td>
									<td>우주별</td>
									<td>010-7777-8888</td>
									<td>2026-01-05</td>
									<td><span class="status-active">활성</span></td>
									<td>
										<button type="button" class="btn btn-outline-primary">수정</button>
										<button type="button" class="btn ne-btn-deact" onclick="deactOk(4)">비활성화</button>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="paginate">						
							<span class="active">1</span>
							<a href="#"> 2 </a>
							<a href="#"> 3 </a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>
