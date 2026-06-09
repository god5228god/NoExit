<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>themelist.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<c:set var="path" value="${pageContext.request.contextPath }" />

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
	grid-template-columns: 4fr 1fr;
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
	display: flex;
	flex-direction: column;
	font-size: 10px;
}

.filter-item input
{
	width: 60px;
}

.theme-list
{
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.theme-item
{
	display: grid;
	gap: 10px;
	grid-template-columns: 3fr 2fr;
	border: 1px solid black;
	border-radius: 15px;
	padding: 5px;
}

.theme-image
{
	background: #f5f5f5;
}

.theme-info
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

.theme-add
{
	display: flex;
	justify-content: center;
}

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

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

	let schType = "${schType}";
	let kwd = "${kwd}";
	let lastId = 0;
	let minPrice = "${minPrice}";
	let maxPrice = "${maxPrice}";
	let minLevel = "${minLevel}";
	let maxLevel = "${maxLevel}";
	let minHorror = "${minHorror}";
	let maxHorror = "${maxHorror}";
	
	function search()
	{
		const f = document.searchForm;
		
		if(!f.kwd.value.trim())
		{
			alert("키워드를 입력하세요");
			f.kwd.focus();
			return;
		}
		
		f.action = '${path}/theme/list';
		
		f.submit();
	}

	$(function()
	{
		$("#addList").click(function()
		{
			//alert("확인");
			
			let params = new URLSearchParams(
			{
				kwd: kwd,
				schType: schType,
				lastId: lastId
				
			}).toString();
			
			$.ajax(
			{
				"type":"POST"
				, "url":"${path}/theme/list"
				, "data":params
				, "dataType":"json"
				, "success":function(data)
				{
					if(data == null || data.length == 0)
					{
						$("#addList").remove();
						return;
					}
					
					renderList(data);
					
					lastId = data[data.length-1].themeId;
					
					//console.log(typeof data, data);
				}
				, "error":function(e)
				{
					alert("에러 발생");
					console.log(e.responseText);
				}
			});
		});
		
		$("#addList").click();
	});
	
	function renderList(list)
	{
		list.forEach(function(item)
		{
			$(".theme-list").append(renderTheme(item));
		});
	}

	function renderTheme(item)
	{
		return "<a href='${path}/theme/info/" + item.themeId + "' class='theme-item'>" 
			+ "<div class='theme-image'>" + "<span>" + item.imagePath + "</span></div>"
			+ "<div class='theme-info'>" 
			+ getItem('카페명',item.cafeName)
			+ getItem('테마명',item.themeName)
			+ getItem('테마 장르',item.genre)
			+ getItem('테마 시간',item.duration + "분")
			+ getItem('테마 가격',item.price + "￦")
			+ getItem('난이도',showStart(item.difficulty))
			+ getItem('공포도',showStart(item.horror))
			+ "<div class='info-item'>"
			+ "<span>인원</span>"
			+ "<span>" + item.minPlayers + " ~ " + item.maxPlayers + "</span>"
			+ "</div>" 
			+ "</div>"
			+ "</a>"
	}		

	function showStart(n)
	{
		n = Number(n);
		
		return "★".repeat(n) + "☆".repeat(5-n);
	}
	
	function getItem(title,value)
	{
		return "<div class='info-item'>" + "<span>" + title + "</span>" + "<span>" + value + "</span>" + "</div>";
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
								<option value="C.CAFE_NAME" ${schType == 'C.CAFE_NAME' ? 'selected' : '' }>카페명</option>
								<option value="A.ROOM_NAME" ${schType == 'A.ROOM_NAME' ? 'selected' : '' }>테마명</option>
							</select>
							
							<input type="text" name="kwd" placeholder="검색 키워드" value="${kwd }">
							
							<button type="button" onclick="search()" class="btn btn-primary">검색</button>
							<button type="button" onclick="window.location.href='${path}/theme/list'" class="btn btn-outline-primary">초기화</button>
							
						</form>
					</div>
					
					<div class="search-filter">
						<span>필터</span>
						
						<div class="filter-item">
							<span>가격</span>
							<input type="text" name="minPrice" placeholder="최소 가격">
							~
							<input type="text" name="maxPrice" placeholder="최대 가격"> 
						</div>
						
						<div class="filter-item">
							<span>레벨</span>
							<input type="text" name="minLevel" placeholder="최소 난이도">
							~
							<input type="text" name="maxLevel" placeholder="최대 난이도"> 
						</div>
						
						<div class="filter-item">
							<span>공포</span>
							<input type="text" name="minHorror" placeholder="최소 공포">
							~
							<input type="text" name="maxHorror" placeholder="최대 공포"> 
						</div>
						
					</div>	
					
				</div>
				
				<div class="theme-list">
				<%-- 
					<a href="${path }/theme/info/1" class="theme-item">
					
						<div class="theme-image">
							<span>테마이미지</span>
						</div>
						
						<div class="theme-info">
						
							<div class="info-item">
								<span>테마명</span>
								<span>그레이</span>
							</div>
							
							<div class="info-item">
								<span>테마 장르</span>
								<span>추리</span>
							</div>
							
							<div class="info-item">
								<span>테마 시간</span>
								<span>60분</span>
							</div>
							
							<div class="info-item">
								<span>테마 가격</span>
								<span>30000</span>
							</div>
							
							<div class="info-item">
								<span>난이도</span>
								<span>★★★★★</span>
							</div>
							
							<div class="info-item">
								<span>공포도</span>
								<span>★★★★★</span>
							</div>
							
							<div class="info-item">
								<span>인원</span>
								<span>2 ~ 4</span>
							</div>
							
						</div>
					
					</a>
				
					<a href="${path }/theme/info/1" class="theme-item">
					
						<div class="theme-image">
							<span>테마이미지</span>
						</div>
						
						<div class="theme-info">
						
							<div class="info-item">
								<span>테마명</span>
								<span>그레이</span>
							</div>
							
							<div class="info-item">
								<span>테마 장르</span>
								<span>추리</span>
							</div>
							
							<div class="info-item">
								<span>테마 시간</span>
								<span>60분</span>
							</div>
							
							<div class="info-item">
								<span>테마 가격</span>
								<span>30000</span>
							</div>
							
							<div class="info-item">
								<span>난이도</span>
								<span>★★★★★</span>
							</div>
							
							<div class="info-item">
								<span>공포도</span>
								<span>★★★★★</span>
							</div>
							
							<div class="info-item">
								<span>인원</span>
								<span>2 ~ 4</span>
							</div>
							
						</div>
					
					</a>  --%>
				
					<%-- <a href="${path }/theme/info/1" class="theme-item">
					
						<div class="theme-image">
							<span>테마이미지</span>
						</div>
						
						<div class="theme-info">
						
							<div class="info-item">
								<span>테마명</span>
								<span>그레이</span>
							</div>
							
							<div class="info-item">
								<span>테마 장르</span>
								<span>추리</span>
							</div>
							
							<div class="info-item">
								<span>테마 시간</span>
								<span>60분</span>
							</div>
							
							<div class="info-item">
								<span>테마 가격</span>
								<span>30000</span>
							</div>
							
							<div class="info-item">
								<span>난이도</span>
								<span>★★★★★</span>
							</div>
							
							<div class="info-item">
								<span>공포도</span>
								<span>★★★★★</span>
							</div>
							
							<div class="info-item">
								<span>인원</span>
								<span>2 ~ 4</span>
							</div>
							
						</div>
					
					</a> --%>
				
				</div>
				
				<div class="theme-add">
					
					<button type="button" class="btn btn-primary" id="addList">더보기</button>	
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>