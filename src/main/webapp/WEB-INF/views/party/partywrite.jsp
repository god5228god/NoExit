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

.container 
{
  width: 500px;
  margin-top: 40px;
  padding-top: 20px;
  padding-bottom: 20px;
  border: 1px solid black;
  border-radius: 8px;
}

.title-wrap .title 
{
  font-size: 22px;
  font-weight: bold;
}

.title-wrap hr 
{
  border-top: 1px solid #ccc;
}

.theme-info-wrap 
{
  display: flex;
  flex-direction: column;
  gap: 5px;
  margin-bottom: 20px;
  padding: 15px;
  background: #f5f5f5;
  border-radius: 5px;
}

.write-wrap form 
{
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.write-wrap span 
{
  font-size: 15px;
  font-weight: bold;
}

.write-wrap input[type="text"] 
{
  padding: 5px;
  border: 1px solid black;
  border-radius: 5px;
  font-size: 15px;
}

.write-btn 
{
  display: flex;
  justify-content: center;
  margin-top: 20px;
  gap: 5px;
}

</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript">
	
	function partyWrite()
	{
		const f = document.writeForm;
		
		let str = f.partyname.value.trim();
		
		if(!str)
		{
			alert("파티명을 입력해야 합니다.");
			f.partyname.focus();
			return;
		}
		
		str = f.partyComment.value.trim();
		
		if(!str)
		{
			alert("코멘트를 입력해야합니다.");
			f.partyComment.focus();
			return;
		}
		
		f.action = '${path}/party/write';
		f.submit();
	}
	
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="title-wrap">
					<span class="title">파티 개설</span>
					<hr>
				</div>
				
				<div class="theme-info-wrap">
					<span>카페명 : 우주별</span>	
					<span>테마명 : 그레이</span>
					<span>날짜 : 2026-06-01</span>
					<span>시간 : 18:00</span>
					<span>인원수 : 2 ~ 4</span>
					<span>가격 : 30000</span>
				</div>
				
				<div class="write-wrap">
					<form action="" class="write-form" method="post" name="writeForm">
						<span>파티명</span>
						<input type="text" name="partyname">
						<label>
						<span>동성만</span>
						<input type="checkbox" name="genderCondition" value="1">
						</label>
						<span>코멘트</span>
						<input type="text" name="partyComment">
						<input type="hidden" value="slotId" name="slotId">
					</form>
				</div>
				
				<div class="write-btn">
					<button type="button" class="btn btn-primary" onclick="partyWrite()">파티 개설</button>				
					<button type="button" class="btn btn-outline-primary" onclick="window.location.href='${path}/theme/info/1'">취소하기</button>
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>