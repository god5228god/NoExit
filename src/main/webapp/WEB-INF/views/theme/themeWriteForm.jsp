<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테마 <c:choose><c:when test="${mode == 'update'}">수정</c:when><c:otherwise>등록</c:otherwise></c:choose></title>
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
<%@ include file="/WEB-INF/views/common/header.jsp" %>

 <div class="container my-5" style="max-width: 720px;">

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">
			테마 <c:choose><c:when test="${mode == 'update'}">수정</c:when><c:otherwise>등록 신청</c:otherwise></c:choose>
		</div>

		<form action="${pageContext.request.contextPath}/owner/theme/write" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mode" value="${mode}">
			<c:if test="${mode == 'update'}">
				<input type="hidden" name="themeId" value="${dto.themeId}">
			</c:if>

			<div class="row mb-3">
				<div class="col-8">
					<label for="themeName" class="form-label">테마명<span class="form-required">*</span></label>
					<input type="text" id="themeName" name="themeName" class="form-control" maxlength="100" value="${dto.themeName}" placeholder="테마명을 입력해주세요" required>
				</div>
				<div class="col-4">
					<label for="cafeId" class="form-label">카페<span class="form-required">*</span></label>
					<select id="cafeId" name="cafeId" class="form-select" required>
						<option value="">-- 카페 선택 --</option>
						<c:forEach var="cafe" items="${cafeList}">
							<option value="${cafe.cafeId}" <c:if test="${dto.cafeId == cafe.cafeId}">selected</c:if>>${cafe.cafeName}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="genre" class="form-label">장르<span class="form-required">*</span></label>
					<select id="genre" name="genre" class="form-select" required>
						<option value="">-- 장르 선택 --</option>
						<c:forEach var="genre" items="${genreList}">
							<option value="${genre.genreId}" <c:if test="${dto.genre == genre.genreId}">selected</c:if>>${genre.genreName}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col">
					<label for="adult" class="form-label">성인 전용 여부<span class="form-required">*</span></label>
					<select id="adult" name="adult" class="form-select" required>
						<c:forEach var="c" items="${commonList}">
							<option value="${c.commonId}" <c:if test="${dto.adult == c.commonId}">selected</c:if>>
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
					<input type="number" id="duration" name="duration" class="form-control" value="${dto.duration}" placeholder="예: 60" required>
					<div class="ne-hint">분 단위 숫자로만 입력</div>
				</div>
				<div class="col">
					<label for="price" class="form-label">가격(1인 기준)<span class="form-required">*</span></label>
					<input type="number" id="price" name="price" class="form-control" min="0" max="999999" value="${dto.price}" required>
					<div class="ne-hint">원 단위 숫자로만 입력</div>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="minPlayers" class="form-label">최소 인원수<span class="form-required">*</span></label>
					<input type="number" id="minPlayers" name="minPlayers" class="form-control" min="1" max="99" value="${dto.minPlayers}" placeholder="최소 인원" required>
				</div>
				<div class="col">
					<label for="maxPlayers" class="form-label">최대 인원수<span class="form-required">*</span></label>
					<input type="number" id="maxPlayers" name="maxPlayers" class="form-control" min="1" max="999" value="${dto.maxPlayers}" placeholder="최대 인원" required>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col">
					<label for="difficulty" class="form-label">난이도<span class="form-required">*</span></label>
					<select id="difficulty" name="difficulty" class="form-select" required>
						<option value="1" <c:if test="${dto.difficulty == 1}">selected</c:if>>★☆☆☆☆ (1단계)</option>
						<option value="2" <c:if test="${dto.difficulty == 2}">selected</c:if>>★★☆☆☆ (2단계)</option>
						<option value="3" <c:if test="${dto.difficulty == 3}">selected</c:if>>★★★☆☆ (3단계)</option>
						<option value="4" <c:if test="${dto.difficulty == 4}">selected</c:if>>★★★★☆ (4단계)</option>
						<option value="5" <c:if test="${dto.difficulty == 5}">selected</c:if>>★★★★★ (5단계)</option>
					</select>
				</div>
				<div class="col">
					<label for="horror" class="form-label">공포도<span class="form-required">*</span></label>
					<select id="horror" name="horror" class="form-select" required>
						<option value="1" <c:if test="${dto.horror == 1}">selected</c:if>>없음 (1단계)</option>
						<option value="2" <c:if test="${dto.horror == 2}">selected</c:if>>약간 (2단계)</option>
						<option value="3" <c:if test="${dto.horror == 3}">selected</c:if>>보통 (3단계)</option>
						<option value="4" <c:if test="${dto.horror == 4}">selected</c:if>>높음 (4단계)</option>
						<option value="5" <c:if test="${dto.horror == 5}">selected</c:if>>극악 (5단계)</option>
					</select>
				</div>
				<div class="col">
					<label for="activity" class="form-label">활동성<span class="form-required">*</span></label>
					<select id="activity" name="activity" class="form-select" required>
						<option value="1" <c:if test="${empty dto || dto.activity == 1}">selected</c:if>>낮음 (1단계)</option>
						<option value="2" <c:if test="${dto.activity == 2}">selected</c:if>>보통 (2단계)</option>
						<option value="3" <c:if test="${dto.activity == 3}">selected</c:if>>높음 (3단계)</option>
					</select>
				</div>
			</div>

			<div class="mb-3">
				<label for="description" class="form-label">테마 설명</label>
				<textarea id="description" name="description" rows="4" class="form-control" placeholder="테마의 줄거리, 분위기, 주의사항 등을 작성해주세요">${dto.description}</textarea>
			</div>

			<div class="mb-3">
				<label for="themeImageFile" class="form-label">테마 이미지 포스터<c:if test="${mode != 'update'}"><span class="form-required">*</span></c:if></label>
				<input type="file" id="themeImageFile" name="themeImageFile" class="form-control" accept="image/*" <c:if test="${mode != 'update'}">required</c:if>>
				<div class="ne-hint">
					<c:choose>
						<c:when test="${mode == 'update'}">새 이미지를 선택하지 않으면 기존 이미지 유지</c:when>
						<c:otherwise>테마 메인에 노출될 포스터 이미지를 업로드하세요.</c:otherwise>
					</c:choose>
				</div>
			</div>

			<c:if test="${not empty errorMessage}">
				<div class="text-danger mb-2">${errorMessage}</div>
			</c:if>
			<div class="text-end mt-4">
				<button type="submit" class="btn btn-primary">
					<c:choose><c:when test="${mode == 'update'}">수정</c:when><c:otherwise>등록</c:otherwise></c:choose>
				</button>
				<button type="button" class="btn btn-outline-primary" onclick="history.back()">취소</button>
			</div>

		</form>
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>
