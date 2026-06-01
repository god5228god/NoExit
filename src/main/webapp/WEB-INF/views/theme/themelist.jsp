<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>themelist.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.list
{
	display: grid;
	grid-template-columns: repeat(2, 2fr);
	gap: 10px;
}

.ne-sc
{
	display: flex;
}

.image
{
	background-color: gray;
	flex: 0 0 50%;
}

.description
{
	text-align: center;
	flex: 0 0 1;
	min-width: 0;
	table-layout: fixed;
	width: 100%;
	text-align: center;
}

.search-form
{
	padding-bottom: 20px;
	position: relative;
	height: 150px;
}

.search
{
	text-align: center;
}

.search-type,
.search > .search-input,
.search > .btn 
{
	font-size: 18px;
	padding: 10px 14px;
	vertical-align: middle;
	margin-top: 40px;
}

.search > .search-input 
{
	width: 260px;
}

.filter
{
	position: absolute;
	top: 0;
	right: 0;
	width: 220px;          
	font-size: 12px;
	text-align: right;
	line-height: 1.8;
}

.search-input 
{
	width: 80px;
	font-size: 12px;
	padding: 2px 4px;
}

.ne-sc:hover
{
	background: none;        /* 배경 강조 제거 */
	box-shadow: none;        /* 그림자/광택(글로우) 제거 */
	color: inherit;          /* 글자색 변화 제거 */
	text-decoration: none;   /* 밑줄 제거 */
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="search-form">
					
					<form action="" class="search" method="post">
						
						<select class="search-type">
							<option value="cafeName">카페명</option>
							<option value="themeName">테마명</option>
						</select>
						
						<input type="text" class="search-input" placeholder="검색키워드">
						
						<button type="button" class="btn btn-primary">검색</button>
						
						<br>
						
						<div class="filter">
							필터
							<br>
							평점
							<input type="text" class="search-input" name="minRating" placeholder="최소 평점">
							<input type="text" class="search-input" name="maxRating" placeholder="최대 평점">
							<br>
							공포도
							<input type="text" class="search-input" name="minHorror" placeholder="최소 공포도">
							<input type="text" class="search-input" name="maxHorror" placeholder="최대 공포도">
							<br>
							가격
							<input type="text" class="search-input" name="minPrice" placeholder="최소 가격">
							<input type="text" class="search-input" name="maxPrice" placeholder="최대 가격">
							<br>
						</div>
						
					</form>
					
				</div>
				
				<div class="list">
					
					<a class="ne-sc" href="" >
						
						<div class="image">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>카페명</th>
									<td>우주별</td>		
								</tr>
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>평점</th>
									<td>★★★★☆</td>
								</tr>
								<tr>
									<th>공포도</th>
									<td>★★★★☆</td>
								</tr>
								<tr>
									<th>시간</th>
									<td>60분</td>	
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>인원</th>
									<td>2 ~ 4</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
							</table>
					</a>
		
					
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>