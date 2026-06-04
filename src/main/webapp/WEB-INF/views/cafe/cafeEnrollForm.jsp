<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페 등록</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/dist/css/common.css">
<script src="https://code.jquery.com/jquery.min.js"></script>	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

$(function(){

	$("#addrBtn").click(function(){
			execDaumPostCode();		
	});
	
	function execDaumPostCode(){
		new daum.Postcode({
			oncomplete: function(data){
				
				let fullAddr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
				
				$("#postalCode").val(data.zonecode); // 우편번호
				$("#address").val(fullAddr); // 기본주소
				
				$("#addressDetail").focus();
			}
			
		}).open({
			
				  left: (window.screen.width / 2) - (500 / 2)
				, top: (window.screen.height / 2) - (600 / 2)
				, popupName: 'postcodePopup'
			
		});
		
	}
});

</script>
	
</head>
<body>

<div class="container my-5" style="max-width: 720px;">

	<div class="ne-sc">
		<div class="ne-sc-title fs-5">카페 등록 신청</div>

		<form action="${pageContext.request.contextPath}/cafe/enroll" method="post">

			<div class="mb-3">
				<label for="cafeName" class="form-label">카페명<span class="form-required">*</span></label>
				<input type="text" id="cafeName" name="cafeName" class="form-control" maxlength="100" placeholder="카페명을 입력해주세요" required>
			</div>

			<div class="mb-3">
				<label for="brNo" class="form-label">사업자번호<span class="form-required">*</span></label>
				<input type="text" id="brNo" name="brNo" class="form-control" maxlength="10" pattern="[0-9]{10}" inputmode="numeric" placeholder="ex) 1234567890" required>
				<div class="ne-hint">하이픈(-) 없이 숫자 10자리</div>
			</div>

			<div class="mb-3">
				<label for="phone" class="form-label">전화번호<span class="form-required">*</span></label>
				<input type="text" id="phone" name="phone" class="form-control" maxlength="50" inputmode="numeric" placeholder="ex) 01012341234" required>
				<div class="ne-hint">하이픈(-) 없이 숫자만 입력</div>
			</div>

			<div class="mb-3">
				<label class="form-label">주소<span class="form-required">*</span></label>

				<div class="input-group mb-2">
					<input type="text" id="postalCode" name="postalCode" class="form-control" maxlength="5" placeholder="우편번호" style="max-width: 160px;" readonly required>
					<%-- 카카오 우편번호 API 연동 자리 --%>
					<button type="button" id="addrBtn" class="btn btn-outline-primary">주소 찾기</button>
				</div>

				<input type="text" id="address" name="address" class="form-control mb-2" maxlength="100" placeholder="기본 주소" readonly required>

				<input type="text" id="addressDetail" name="addressDetail" class="form-control" maxlength="200" placeholder="상세 주소">
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
