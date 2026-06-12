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

/* ── 레이아웃 ──────────────────────────────────── */
.container {
	display: flex;
	flex-direction: column;
	gap: 1.25rem;
	padding: 1.5rem 0;
}

/* ── 검색 + 필터 ───────────────────────────────── */
.search-wrap {
	display: grid;
	grid-template-columns: 3fr 1fr;
	gap: 1rem;
	align-items: start;
}

.search-form form {
	display: flex;
	gap: .5rem;
	align-items: center;
}
.search-form select { max-width: 120px; }
.search-form input[name="kwd"] { flex: 1; }

/* 필터 카드 */
.search-filter { padding: 1rem 1.1rem; }
.search-filter .filter-title {
	font-size: .8rem;
	font-weight: 700;
	color: var(--ne-text-2);
	margin-bottom: .65rem;
}
.filter-item {
	display: flex;
	align-items: center;
	gap: .35rem;
	margin-bottom: .6rem;
}
.filter-item > .filter-label {
	font-size: .78rem;
	font-weight: 600;
	color: var(--ne-text-2);
	min-width: 32px;
	flex-shrink: 0;
}
.filter-item input {
	width: 100%;
	min-width: 0;
	padding: .3rem .5rem;
	border: 1.5px solid var(--ne-border-dark);
	border-radius: var(--ne-radius-xs);
	font-size: .76rem;
	color: var(--ne-text);
}
.filter-item input:focus {
	outline: none;
	border-color: var(--ne-primary);
}
.filter-item .filter-tilde { color: var(--ne-text-3); font-size: .76rem; }

/* ── 테마 목록 ─────────────────────────────────── */
.theme-list {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 1.25rem;
}

.theme-item {
	display: grid;
	grid-template-columns: 5fr 4fr;
	gap: 1rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius);
	box-shadow: var(--ne-shadow-sm);
	padding: .85rem;
	transition: box-shadow .18s, transform .18s;
	color: inherit;
	text-decoration: none;
}
.theme-item:hover {
	box-shadow: var(--ne-shadow);
	transform: translateY(-2px);
	color: inherit;
}

.theme-item .theme-image {
	border-radius: var(--ne-radius-md);
	overflow: hidden;
	background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
	aspect-ratio: 3 / 4;
}
.theme-item .theme-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.theme-item .theme-info {
	display: flex;
	flex-direction: column;
	gap: .3rem;
	min-width: 0;
}
.theme-item .theme-info .info-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: .84rem;
	gap: .5rem;
}
.theme-item .theme-info .info-item > span:first-child {
	color: var(--ne-text-2);
	font-size: .8rem;
	flex-shrink: 0;
}
.theme-item .theme-info .info-item > span:last-child {
	font-weight: 600;
	text-align: right;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.theme-item .theme-info .info-item .ne-star {
	color: var(--ne-primary);
	letter-spacing: 1px;
}

/* ── 더보기 ────────────────────────────────────── */
.theme-add {
	display: flex;
	justify-content: center;
	margin-top: .5rem;
}
.theme-add .btn { min-width: 200px; }

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

		/* if(!f.kwd.value.trim())
		{
			alert("키워드를 입력하세요");
			f.kwd.focus();
			return;
		} */

		f.action = '${path}/theme/list';

		f.submit();
	}

	$(function()
	{
		$("#addList").click(function()
		{
			let params = new URLSearchParams(
			{
				kwd: kwd,
				schType: schType,
				lastId: lastId,
				minPrice:minPrice,
			    maxPrice:maxPrice,
			    minLevel:minLevel,
			    maxLevel:maxLevel,
			    minHorror:minHorror,
			    maxHorror:maxHorror
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
		+ "<div class='theme-image'><img src='" + (item.imagePath && item.imagePath.charAt(0) === '/' ? '${path}' + item.imagePath : '${path}/dist/images/' + item.imagePath)
		+ "'></div>"
		+ "<div class='theme-info'>"
			+ getItem('카페명',item.cafeName)
			+ getItem('테마명',item.themeName)
			+ getItem('장르',item.genre)
			+ getItem('시간',item.duration + "분")
			+ getItem('가격',Number(item.price).toLocaleString() + "원")
			+ getStar('난이도',item.difficulty)
			+ getStar('공포도',item.horror)
			+ getItem('인원',item.minPlayers + "명 ~ " + item.maxPlayers + "명")
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

	function getStar(title,n)
	{
		return "<div class='info-item'>" + "<span>" + title + "</span>" + "<span class='ne-star'>" + showStart(n) + "</span>" + "</div>";
	}

</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">

				<!-- 검색 + 필터 -->
				<div class="search-wrap">

					<div class="search-form ne-sc">
						<form action="" method="get" name="searchForm" id="searchForm">

							<select name="schType" class="form-select">
								<option value="C.CAFE_NAME" ${schType == 'C.CAFE_NAME' ? 'selected' : '' }>카페명</option>
								<option value="A.ROOM_NAME" ${schType == 'A.ROOM_NAME' ? 'selected' : '' }>테마명</option>
							</select>

							<input type="text" name="kwd" class="form-control" placeholder="검색 키워드" value="${kwd }">

							<button type="button" onclick="search()" class="btn btn-primary">검색</button>
							<button type="button" onclick="window.location.href='${path}/theme/list'" class="btn btn-outline-primary">초기화</button>

						</form>
					</div>

					<div class="search-filter ne-sc">
						<div class="filter-title">필터</div>

						<div class="filter-item">
							<span class="filter-label">가격</span>
							<input type="number" name="minPrice" value="${minPrice }" placeholder="최소" form="searchForm">
							<span class="filter-tilde">~</span>
							<input type="number" name="maxPrice" value="${maxPrice }" placeholder="최대" form="searchForm">
						</div>

						<div class="filter-item">
							<span class="filter-label">난이도</span>
							<input type="number" min="1" max="5" name="minLevel" value="${minLevel }" placeholder="최소" form="searchForm">
							<span class="filter-tilde">~</span>
							<input type="number" min="1" max="5" name="maxLevel" value="${maxLevel }" placeholder="최대" form="searchForm">
						</div>

						<div class="filter-item">
							<span class="filter-label">공포</span>
							<input type="number" min="1" max="5" name="minHorror" value="${minHorror }" placeholder="최소" form="searchForm">
							<span class="filter-tilde">~</span>
							<input type="number" min="1" max="5" name="maxHorror" value="${maxHorror }" placeholder="최대" form="searchForm">
						</div>

					</div>

				</div>

				<!-- 테마 목록 -->
				<div class="theme-list"></div>

				<!-- 더보기 -->
				<div class="theme-add">
					<button type="button" class="btn btn-primary" id="addList">더보기</button>
				</div>

			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
