<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partylist.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.container
{
	display: flex;
	flex-direction: column;
	gap: 10px;
	padding-top: 10px;
}

.search-wrap
{
	display: grid;
	grid-template-columns : 4fr 1fr;
}

.search-form
{
	display: flex;
	justify-content: center;
	height: 80px;
	padding: 10px;
}

.search-form select,
.search-form input,
.search-form button
{
	height: 50px;
}

.search-filter
{
	font-size: 10px;
	display: flex;
	flex-direction: column;
}

.filter-item input
{
	width: 60px;
}


.party-list
{
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.party-item
{
	display: grid;
	grid-template-columns: 3fr 2fr;
	gap: 10px;
	border: 1px solid black;
	border-radius: 15px;
	padding: 5px;
}

.party-image
{
	background-color: #f5f5f5;
}

.party-info
{
	display: flex;
	flex-direction: column;
	gap: 5px;
}

.info-item
{
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
}

.party-add
{
	display: flex;
	justify-content: center;
}

</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript">
	
	document.addEventListener("DOMContentLoaded",function()
	{
		const kwdInput = document.querySelector("[name='kwd']");
		
		kwdInput.addEventListener("keydown",(evt)=>
		{
			if(evt.key == "Enter")
			{
				evt.preventDefault();
				
				search();
			}
		});
		
	})
	
	let schType = '${schType}';
	let kwd = "${kwd}";
	let lastId;
	let minDate = "${minDate}";
	let maxDate = "${maxDate}";
	let minTime = "${minTime}";
	let maxTime = "${maxTime}";
	
	function search()
	{
		const f = document.searchForm;
		
		if(!f.kwd.value.trim())
		{
			alert("키워드를 입력하세요");
			f.kwd.focus();
			return;
		}
		
		f.action = '${path}/party/list';
		
		f.submit();
	}

	function addList()
	{
		alert("추가");
	}
	
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="search-wrap">
					
					<div class="search-form">
						<form action="" method="get" name="searchForm">
							
							<select name="schType">
								<option value="themeName">테마명</option>
								<option value="partyName">파티명</option>
							</select>
							
							<input type="text" name="kwd" placeholder="검색 키워드">
							
							<button type="button" onclick="search()" class="btn btn-primary">검색</button>
							<button type="button" onclick="window.location.href='${path}/party/list'" class="btn btn-outline-primary">초기화</button>
							
						</form>
					</div>
					
					<div class="search-filter">
						<span>필터</span>
						
						<div class="filter-item">
							<span>날짜</span>
							<input type="text" name="minDate" placeholder="최소 날짜">
							~
							<input type="text" name="maxDate" placeholder="최대 날짜"> 
						</div>
						
						<div class="filter-item">
							<span>시간</span>
							<input type="text" name="minTime" placeholder="최소 시간">
							~
							<input type="text" name="maxTime" placeholder="최대 시간"> 
						</div>
						
					</div>	
					
				</div>
				
				<div class="party-list">
				
					<a href="" class="party-item">
					
						<div class="party-image">
							<span>테마이미지</span>
						</div>
						
						<div class="party-info">
						
							<div class="info-item">
								<span>테마명</span>
								<span>그레이</span>
							</div>
							
							<div class="info-item">
								<span>날짜</span>
								<span>06-12</span>
							</div>
							
							<div class="info-item">
								<span>시간</span>
								<span>18:00</span>
							</div>
							
							<div class="info-item">
								<span>파티명</span>
								<span>주열룸</span>
							</div>
							
							<div class="info-item">
								<span>평균 매너온도</span>
								<span>🌡️ 36.5</span>
							</div>
							
							<div class="info-item">
								<span>평균 나이</span>
								<span>29.3</span>
							</div>
							
							<div class="info-item">
								<span>현재 인원 수</span>
								<span>2</span>
							</div>
							
						</div>
					
					</a>
				
					<a href="" class="party-item">
					
						<div class="party-image">
							<span>테마이미지</span>
						</div>
						
						<div class="party-info">
						
							<div class="info-item">
								<span>테마명</span>
								<span>그레이</span>
							</div>
							
							<div class="info-item">
								<span>날짜</span>
								<span>06-12</span>
							</div>
							
							<div class="info-item">
								<span>시간</span>
								<span>18:00</span>
							</div>
							
							<div class="info-item">
								<span>파티명</span>
								<span>주열룸</span>
							</div>
							
							<div class="info-item">
								<span>평균 매너온도</span>
								<span>🌡️ 36.5</span>
							</div>
							
							<div class="info-item">
								<span>평균 나이</span>
								<span>29.3</span>
							</div>
							
							<div class="info-item">
								<span>현재 인원 수</span>
								<span>2</span>
							</div>
							
						</div>
					
					</a>
				
					<a href="" class="party-item">
					
						<div class="party-image">
							<span>테마이미지</span>
						</div>
						
						<div class="party-info">
						
							<div class="info-item">
								<span>테마명</span>
								<span>그레이</span>
							</div>
							
							<div class="info-item">
								<span>날짜</span>
								<span>06-12</span>
							</div>
							
							<div class="info-item">
								<span>시간</span>
								<span>18:00</span>
							</div>
							
							<div class="info-item">
								<span>파티명</span>
								<span>주열룸</span>
							</div>
							
							<div class="info-item">
								<span>평균 매너온도</span>
								<span>🌡️ 36.5</span>
							</div>
							
							<div class="info-item">
								<span>평균 나이</span>
								<span>29.3</span>
							</div>
							
							<div class="info-item">
								<span>현재 인원 수</span>
								<span>2</span>
							</div>
							
						</div>
					
					</a>
				
				</div>
				
				<div class="party-add">
					
					<button type="button" class="btn btn-primary" onclick="addList()">더보기</button>	
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>