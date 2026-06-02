<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">
<style>

    .theme-enroll-wrap {
        max-width: 720px;
        margin: 40px auto;
        padding: 0 20px;
    }

    .theme-enroll-wrap .ne-sc {
        padding: 1.75rem 1.75rem 1.5rem;
    }

    .num-row {
        display: flex;
        align-items: center;
        gap: 12px;
    }
    .num-row > div {
        flex: 1;
    }

    .btn-row {
        display: flex;
        justify-content: flex-end;
        gap: 8px;
        margin-top: 1.5rem;
    }
    .btn-row .btn {
        min-width: 110px;
    }
</style>
</head>
<body>
<div class="theme-enroll-wrap">

    <div class="ne-sc">
        <div class="ne-sc-title">테마 등록 신청</div>

        <form action="${pageContext.request.contextPath}/theme/enroll" method="post" enctype="multipart/form-data">

            <!-- 1. 테마 기본 정보 -->
            <div class="mb-3">
                <label for="roomName" class="form-label">테마명<span class="form-required">*</span></label>
                <input type="text" id="roomName" name="roomName" class="form-control" maxlength="100" placeholder="테마명을 입력해주세요" required>
            </div>

            <div class="num-row mb-3">
                <div>
                    <label for="cafeId" class="form-label">소속 카페 ID<span class="form-required">*</span></label>
                    <input type="number" id="cafeId" name="cafeId" class="form-control" placeholder="카페 번호 입력" required>
                </div>
                <div>
                    <label for="genreId" class="form-label">장르(셀렉트박스)<span class="form-required">*</span></label>
                    <input type="number" id="genreId" name="genreId" class="form-control" placeholder="장르 번호 입력" required>
                </div>
                <div>
                    <label for="isAdult" class="form-label">성인 전용 여부<span class="form-required">*</span></label>
                    <select id="isAdult" name="isAdult" class="form-select" required>
                        <option value="0" selected>일반 (전체 이용가)</option>
                        <option value="1">성인 전용 테마</option>
                    </select>
                </div>
            </div>

           
            <div class="num-row mb-3">
                <div>
                    <label for="duration" class="form-label">소요시간(분)<span class="form-required">*</span></label>
                    <input type="number" id="duration" name="duration" class="form-control" placeholder="예: 60" required>
                    <div class="ne-hint">분 단위 숫자로만 입력</div>
                </div>
                <div>
                    <label for="price" class="form-label">가격(1인 기준)<span class="form-required">*</span></label>
                    <input type="number" id="price" name="price" class="form-control">
                    <div class="ne-hint">원 단위 숫자로만 입력</div>
                </div>
            </div>

            <div class="num-row mb-3">
                <div>
                    <label for="minPlayers" class="form-label">최소 인원수<span class="form-required">*</span></label>
                    <input type="number" id="minPlayers" name="minPlayers" class="form-control" min="1" max="99" placeholder="최소 인원" required>
                </div>
                <div>
                    <label for="maxPlayers" class="form-label">최대 인원수<span class="form-required">*</span></label>
                    <input type="number" id="maxPlayers" name="maxPlayers" class="form-control" min="1" max="999" placeholder="최대 인원" required>
                </div>
            </div>

           
            <div class="num-row mb-3">
                <div>
                    <label for="difficulty" class="form-label">난이도<span class="form-required">*</span></label>
                    <select id="difficulty" name="difficulty" class="form-select" required>
                        <option value="1">★☆☆☆☆ (1단계)</option>
                        <option value="2">★★☆☆☆ (2단계)</option>
                        <option value="3" selected>★★★☆☆ (3단계)</option>
                        <option value="4">★★★★☆ (4단계)</option>
                        <option value="5">★★★★★ (5단계)</option>
                    </select>
                </div>
                <div>
                    <label for="horrorLevel" class="form-label">공포도<span class="form-required">*</span></label>
                    <select id="horrorLevel" name="horrorLevel" class="form-select" required>
                        <option value="1" selected>없음 (1단계)</option>
                        <option value="2">약간 (2단계)</option>
                        <option value="3">보통 (3단계)</option>
                        <option value="4">높음 (4단계)</option>
                        <option value="5">극악 (5단계)</option>
                    </select>
                </div>
                <div>
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
                <textarea id="roomDesc" name="roomDesc" rows="4" class="form-control" placeholder="테마의 줄거리, 분위기, 주의사항 등을 상세히 작성해주세요"></textarea>
            </div>

            <div class="mb-3">
                <label for="uploadImg" class="form-label">테마 이미지 포스터<span class="form-required">*</span></label>
                <input type="file" id="uploadImg" name="uploadImg" class="form-control" accept="image/*" required>
                <div class="ne-hint">테마 메인에 노출될 포스터 이미지를 업로드하세요.</div>
            </div>

            <!-- 5. 하단 버튼 컨트롤 -->
            <div class="btn-row">
                <button type="button" class="btn btn-outline-primary" onclick="history.back()">취소</button>
                <button type="submit" class="btn btn-primary">등록 신청</button>
            </div>

        </form>
    </div>
</div>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>
</body>
</html>