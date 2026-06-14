<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partywrite.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

/* ── 레이아웃 ──────────────────────────────────── */
.container {
	width: 520px;
	margin: 2.5rem auto;
}

/* ── 테마 정보 박스 ────────────────────────────── */
.theme-info-wrap {
	display: flex;
	flex-direction: column;
	gap: .4rem;
	margin-bottom: 1.25rem;
}
.theme-info-wrap .info-row {
	display: flex;
	justify-content: space-between;
	font-size: .88rem;
}
.theme-info-wrap .info-row > span:first-child {
	color: var(--ne-text-2);
	font-weight: 600;
}
.theme-info-wrap .info-row > span:last-child {
	font-weight: 600;
}

/* ── 작성 폼 ───────────────────────────────────── */
.write-wrap form {
	display: flex;
	flex-direction: column;
	gap: .35rem;
}
.write-wrap .form-label {
	margin-top: .5rem;
	margin-bottom: 0;
}
.write-wrap .gender-check {
	display: flex;
	align-items: center;
	gap: .5rem;
	margin: .6rem 0;
	font-size: .9rem;
	cursor: pointer;
}
.write-wrap .gender-check input {
	width: 1.15em;
	height: 1.15em;
	accent-color: var(--ne-primary);
	cursor: pointer;
}

/* ── 버튼 ──────────────────────────────────────── */
.write-btn {
	display: flex;
	justify-content: center;
	gap: .5rem;
	margin-top: 1.5rem;
}
.write-btn .btn { min-width: 120px; }

</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>

<script type="text/javascript">

	$(function()
	{
		$(".info-row").on("change","[name='cafeName']",function()
		{
			// alert("확인");
			getThemeList(this.value);
		});
		
		$(".info-row").on("change","[name='themeName']",function()
		{
			getSlotList(this.value);
		})
		
		/* 	
		$(".info-row").on("change","[name='dateTime']",function()
		{
			if(this.length == 0)
			{
				//alert("없음");
				return;
			}
			
			//alert("확인");
		}) */
		
		$("[name='cafeName']").trigger("change");
	});

	 function partyUpdate()
	{
		const f = document.writeForm;

		let str = f.partyName.value.trim();

		if(!str)
		{
			alert("파티명을 입력해야 합니다.");
			f.partyName.focus();
			return;
		}

		str = f.partyComment.value.trim();

		if(!str)
		{
			alert("코멘트를 입력해야합니다.");
			f.partyComment.focus();
			return;
		}

		f.action = '${path}/party/update/' + ${party.partyId};
		f.submit();
	}

	function cancel()
	{
		let mode = '${mode}';

		if(mode == 'update')
		{
			window.location.href = '${path}/party/board/${party.partyId}'
		}
	} 
	
	function getThemeList(cafeId)
	{
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/theme/" + cafeId
			, "dataType":"json"
			, "success":function(data)
			{
				themeListInsert(data);
			}
			,"error":function(e)
			{
				alert("데이터 불러오기 실패");
				console.log(e.responseText);
			}
		});
	}
	
	function themeListInsert(data)
	{
		let themeList = document.querySelector("[name='themeName']");
		// 초기화해야함
		
		themeList.length = 0;
		
		data.forEach(function(item)
		{
			themeList.insertAdjacentHTML("beforeend",createTheme(item));
		});
		
		$("[name='themeName']").trigger("change");
	}
	
	function createTheme(item)
	{
		if(item.themeId  == ${dto.themeId})
			return "<option value=" + item.themeId + " style='color:orange;' selected>" + item.themeName + "</option>";
		else
			return "<option value=" + item.themeId + ">" + item.themeName + "</option>";
	}
	
	function getSlotList(themeId)
	{
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/slot/" + themeId
			, "dataType":"json"
			, "success":function(data)
			{
				slotListInsert(data);
				infoInsert(themeId);
			}
			, "error":function(e)
			{
				alert("데이터 불러오기 실패");
				console.log(e.responseText);
			}
		});
	}
	
	function slotListInsert(data)
	{
		let slotList = document.querySelector("[name='slotId']");
		// 초기화해야함
		
		slotList.length = 0;
		
		data.forEach(function(item)
		{
			slotList.insertAdjacentHTML("beforeend",createSlot(item));	
		});
		
		$("[name='dateTime']").trigger("change");
	}
	
	function createSlot(item)
	{
		if(item.slotId == ${dto.slotId})
			return "<option value=" + item.slotId + " style='color:orange;' selected>" + item.resDate + "</option>";
		else
			return "<option value=" + item.slotId + ">" + item.resDate + "</option>";
	}
	
	function infoInsert(slotId)
	{
		let players = document.querySelector("#players");
		let price = document.querySelector("#price");
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/time/" + slotId
			, "dataType":"json"
			, "success":function(data)
			{
				let info = data[0];
				
				//console.log(data);
				players.textContent = info.minPlayers + "명 ~ " + info.maxPlayers + "명";
				price.textContent = info.price + "원";
			}
			, "error":function(e)
			{
				alert("서버 오류");
				console.log(e.responseText);
			}
		});
	}
	
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">

				<div class="ne-sc">

					<div class="ne-sc-title">
						${mode == 'write' ? '파티 개설' : '파티 수정'}
					</div>

					<!-- 테마 정보 -->
					<div class="theme-info-wrap content-box-yellow">
						<%-- <div class="info-row"><span>카페명</span><span>${dto.cafeName }</span></div> --%>
						<div class="info-row"><span>카페명</span>
							<select name="cafeName">
								<c:forEach var="cafe" items="${cafeList }">
									<option value="${cafe.cafeId }" ${cafe.cafeId == dto.cafeId ? 'selected' : '' }
									style="${cafe.cafeId == dto.cafeId ? 'color:orange;' : ''}">
									${cafe.cafeName }</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="info-row"><span>테마명</span>
							<select name="themeName">
							<!-- 	<option value="themeCode">테마명1</option>
								<option value="themeCode">테마명1</option>
								<option value="themeCode">테마명1</option>
								<option value="themeCode">테마명1</option> -->
							</select>
						</div>
						
						<div class="info-row"><span>일시</span>
							<select name="slotId" form="writeForm">
							<!-- 	<option value="slotId">날짜/시간</option>
								<option value="slotId">날짜/시간</option>
								<option value="slotId">날짜/시간</option>
								<option value="slotId">날짜/시간</option> -->
							</select>
						</div>
						
						<div class="info-row"><span>인원수</span>
						<span id="players"></span>
						</div>
						<div class="info-row"><span>가격</span><span id="price"><fmt:formatNumber value="" pattern="#,###"/>원</span></div>
					</div>

					<!-- 작성 폼 -->
					<div class="write-wrap">
						<form action="" class="write-form" method="post" name="writeForm" id="writeForm">

							<label class="form-label">파티명 <span class="form-required">*</span></label>
							<input type="text" class="form-control" name="partyName" value="${party.partyName }" maxlength="20" placeholder="파티명을 입력하세요">

							<label class="gender-check">
								<input type="checkbox" name="genderId" value="1" ${party.genderId == 1 ? 'checked' : '' }>
								동성만 모집
							</label>

							<label class="form-label">코멘트 <span class="form-required">*</span></label>
							<input type="text" class="form-control" value="${party.partyComment }" name="partyComment" maxlength="30" placeholder="파티원에게 전할 내용을 입력하세요">
				
						</form>
					</div>

					<!-- 버튼 -->
					<div class="write-btn">
						<button type="button" class="btn btn-primary" onclick="partyUpdate()">${mode == 'write' ? '파티 개설' : '파티 수정' }</button>
						<button type="button" class="btn btn-outline-primary" onclick="cancel()">취소하기</button>
					</div>

				</div>

			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
