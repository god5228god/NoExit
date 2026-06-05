<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테마 등록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/dist/css/common.css">
</head>
<body>

<div class="container my-5" style="max-width: 720px;">

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">테마 등록 신청</div>

		<form action="${pageContext.request.contextPath}/theme/enroll" method="post" enctype="multipart/form-data">

			<div class="row mb-3">
				<div class="col-8">
					<label for="roomName" class="form-label">테마명<span class="form-required">*</span></label>
					<input type="text" id="roomName" name="roomName" class="form-control" maxlength="100" placeholder="테마명을 입력해주세요" required>
				</div>
				<div class="col-4">
					<label for="cafeId" class="form-label">카페<span class="form-required">*</span></label>
					<select id="cafeId" name="cafeId" class="form-select" required>
						<option value="">-- 카페 선택 --</option>
						<c:forEach var="cafe" items="${cafeList}">
							<option value="${cafe.cafeId}">${cafe.cafeName}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="genreId" class="form-label">장르<span class="form-required">*</span></label>
					<select id="genreId" name="genreId" class="form-select" required>
						<option value="">-- 장르 선택 --</option>
						<c:forEach var="genre" items="${genreList}">
							<option value="${genre.genreId}">${genre.genreName}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col">
					<label for="isAdult" class="form-label">성인 전용 여부<span class="form-required">*</span></label>
					<select id="isAdult" name="isAdult" class="form-select" required>
						<c:forEach var="c" items="${commonList}">
							<option value="${c.commonId}">
								<c:choose>
									<c:when test="${c.commonName == 'N'}">일반 (전체 이용가)</c:when>
									<c:when test="${c.commonName == 'Y'}">성인 전용 테마</c:when>
								</c:choose>
							</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="duration" class="form-label">소요시간(분)<span class="form-required">*</span></label>
					<input type="number" id="duration" name="duration" class="form-control" placeholder="예: 60" required>
					<div class="ne-hint">분 단위 숫자로만 입력</div>
				</div>
				<div class="col">
					<label for="price" class="form-label">가격(1인 기준)<span class="form-required">*</span></label>
					<input type="number" id="price" name="price" class="form-control" min="0" max="999999" required>
					<div class="ne-hint">원 단위 숫자로만 입력</div>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="minPlayers" class="form-label">최소 인원수<span class="form-required">*</span></label>
					<input type="number" id="minPlayers" name="minPlayers" class="form-control" min="1" max="99" placeholder="최소 인원" required>
				</div>
				<div class="col">
					<label for="maxPlayers" class="form-label">최대 인원수<span class="form-required">*</span></label>
					<input type="number" id="maxPlayers" name="maxPlayers" class="form-control" min="1" max="999" placeholder="최대 인원" required>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="difficulty" class="form-label">난이도<span class="form-required">*</span></label>
					<select id="difficulty" name="difficulty" class="form-select" required>
						<option value="1">★☆☆☆☆ (1단계)</option>
						<option value="2">★★☆☆☆ (2단계)</option>
						<option value="3" selected>★★★☆☆ (3단계)</option>
						<option value="4">★★★★☆ (4단계)</option>
						<option value="5">★★★★★ (5단계)</option>
					</select>
				</div>
				<div class="col">
					<label for="horrorLevel" class="form-label">공포도<span class="form-required">*</span></label>
					<select id="horrorLevel" name="horrorLevel" class="form-select" required>
						<option value="1" selected>없음 (1단계)</option>
						<option value="2">약간 (2단계)</option>
						<option value="3">보통 (3단계)</option>
						<option value="4">높음 (4단계)</option>
						<option value="5">극악 (5단계)</option>
					</select>
				</div>
				<div class="col">
					<label for="activityLevel" class="form-label">활동성<span class="form-required">*</span></label>
					<select id="activityLevel" name="activityLevel" class="form-select" required>
						<option value="1" selected>낮음 (1단계)</option>
						<option value="2">보통 (2단계)</option>
						<option value="3">높음 (3단계)</option>
					</select>
				</div>
			</div>

			<div class="mb-3">
				<label for="roomDesc" class="form-label">테마 설명</label>
				<textarea id="roomDesc" name="roomDesc" rows="4" class="form-control" placeholder="테마의 줄거리, 분위기, 주의사항 등을 작성해주세요"></textarea>
			</div>

			<div class="mb-3">
				<label for="uploadImg" class="form-label">테마 이미지 포스터<span class="form-required">*</span></label>
				<input type="file" id="uploadImg" name="uploadImg" class="form-control" accept="image/*" required>
				<div class="ne-hint">테마 메인에 노출될 포스터 이미지를 업로드하세요.</div>
			</div>

			<div class="text-end mt-4">
				<button type="submit" class="btn btn-primary">등록 신청</button>
				<button type="button" class="btn btn-outline-primary" onclick="history.back()">취소</button>
				
			</div>

		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
