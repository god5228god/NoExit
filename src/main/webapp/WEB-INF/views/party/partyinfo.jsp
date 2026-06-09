<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partyinfo.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.container 
{
  display: flex;
  padding-top: 20px;
  padding-bottom: 20px;
  gap: 20px;
  align-items: flex-start;
} 

.party-info-wrap 
{
  padding: 20px;
  border: 1px solid black;
  border-radius: 5px;
  width: 60%;
}

.party-apply-wrap 
{
  padding: 20px;
  border: 1px solid black;
  border-radius: 5px;
  width: 30%;
}

.title 
{
  font-size: 20px;
  font-weight: bold;
}

hr 
{
  border-top: 1px solid #ccc;
}

.party-info-wrap > div 
{
  display: flex;
  flex-direction: column;
  gap: 5px;
  margin-bottom: 15px;
  padding: 10px;
  background: #f5f5f5;
  border-radius: 5px;
}

.party-name 
{
  font-size: 20px;
  font-weight: bold;
}

.theme-info
{
  flex-direction: row !important;
  flex-wrap: wrap;
}

.party-condition 
{
  flex-wrap: wrap;
}

.party-crew 
{
 	display: flex;
 	flex-direction: column;
 	gap: 5px;
}

.crew 
{
	display: grid;
	grid-template-columns: 25% 12.5% 12.5% 12.5% 12.5% 12.5% 12.5%;
}

.crew span
{
	text-align: left;
}

.party-apply-wrap form 
{
  margin-bottom: 12px;
}

.apply-comment 
{
  width: 100%;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 15px;
}

.party-apply-wrap button 
{
  width: 100%;
  border-radius: 5px;
}

</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript">
	
	document.addEventListener("DOMContentLoaded",function()
	{
		const applyComment = document.querySelector("[name='applyComment']");
		
		applyComment.addEventListener("keydown",function(evt)
		{
			if(evt.key == "Enter")
			{
				evt.preventDefault();
				
				partyApply();
			}
		});
	});
	
	function partyApply()
	{
		const f = document.partyApplyForm;
		
		let comment = f.applyComment.value.trim();
		
		if(!comment)
		{
			alert("신청 메시지를 작성하세요");
			f.applyComment.focus();
			return;
		}
		
		if(!confirm("신청하시겠습니까?"))
		{
			return;
		}
		
		f.action = "${path}/party/apply/${dto.partyId}";
		
		f.submit();
	}
	
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="party-info-wrap">
					
					<span class="title">파티 정보</span>
					<hr>
					
					<div class="party-name">
						<span>${dto.partyName }</span>
					</div>
					
					<div class="theme-info">
						<span>${dto.cafeName }&nbsp;&nbsp;</span>
						<span>${dto.themeName }&nbsp;&nbsp;</span>
						<span>${dto.themeDate }&nbsp;&nbsp;</span>
						<span>${dto.themeTime }&nbsp;&nbsp;</span>
						<span>${dto.minPlayers }명 ~ ${dto.maxPlayers }명&nbsp;&nbsp;</span>
						<span>${dto.price }원&nbsp;&nbsp;</span>
						<span>
							<c:choose>
								<c:when test="${dto.slotStatus == 1 }">
									예약 가능
								</c:when>
								<c:otherwise>
									예약 불가
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					
					<div class="party-condition">
						<span>${dto.genderName }</span>
						<span>${dto.partyComment }</span>						
					</div> 
					
					<div class="party-crew">
					
						<span>파티 현황</span>
						
						<c:forEach var="crew" items="${crewList }">
							
							<div class="crew">
								<span>${crew.nickName }</span>
								<span>${crew.age }세</span>
								<span>
								<c:choose>
									<c:when test="${crew.gender == 'F' }">여</c:when>
									<c:when test="${crew.gender == 'M' }">남</c:when>
									<c:otherwise>성별확인불가</c:otherwise>
								</c:choose>
								</span>
								<span>🌡️${crew.temp }</span>
								
								<c:choose>
									<c:when test="${crew.position == 'HOST' }">
										<span class="ne-st ne-st-green">파티장</span>
									</c:when>
									<c:otherwise>
										<span class="ne-st ne-st-blue">파티원</span>
									</c:otherwise>
								</c:choose>
								
							</div>
							
						</c:forEach>
						
						<!-- 
						<div class="crew">
							<span>윤주열</span>
							<span>29세</span>
							<span>남자</span>
							<span>🌡️36.5</span>
							<span class="ne-st ne-st-green">파티장</span>
						</div>
						
						<div class="crew">
							<span>김주열</span>
							<span>29세</span>
							<span>남자</span>
							<span>🌡️36.5</span>
							<span class="ne-st ne-st-blue">파티원</span>
						</div> -->
					</div> 
					
				</div> <!-- .party-info-wrap -->
				
				<c:if test="${dto.partyStatus == 'open'}">
						
					<div class="party-apply-wrap">
						
						<span class="title">파티 신청</span>
						<hr>
						
						<form action="" name="partyApplyForm" method="post">
							<input type="text" class="apply-comment" placeholder="신청 메시지" name="applyComment" maxlength="30">
						</form>
						 
						<button type="button" class="btn btn-primary" onclick="partyApply()">신청하기</button>
						 
					</div> <!-- .party-apply-wrap -->
					
				</c:if>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>