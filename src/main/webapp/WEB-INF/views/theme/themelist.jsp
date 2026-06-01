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
	grid-template-columns: repeat(5, 1fr);
	gap: 10px;
}

.description
{
	text-align: center;
}

th
{
	width: 100px;
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


	/*
	.list 
	{
	    margin-top: 50px;
	    width: 1000px;
	    background-color: orange;
	    display: grid;
	    grid-template-columns: repeat(5, 1fr);
	    gap: 10px;
	    padding: 10px;
	    box-sizing: border-box;
	}
	
	.item 
	{ 
		display: block; 
		text-decoration: none; 
		color: inherit;
		height: 200px; 
		background-color: green; 
		overflow-y: auto;
	}
	
	.image
	{
		width: 100%;
		height: 50%;
		background-color: white;
	}
	 */
</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="search-form">
					
					<form action="" class="search">
						
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
							활동도
							<input type="text" class="search-input" name="minAct" placeholder="최소 활동도">
							<input type="text" class="search-input" name="maxAct" placeholder="최대 활동도">
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
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
								</tr>							
							</table>
					</a>
					
					<a class="ne-sc" href="" >
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
								</tr>							
							</table>
					</a>
					
					<a class="ne-sc" href="" >
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
								</tr>							
							</table>
					</a>
					
					<a class="ne-sc" href="" >
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
								</tr>							
							</table>
					</a>
					
					<a class="ne-sc" href="" >
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
								</tr>							
							</table>
					</a>
					
					<a class="ne-sc" href="" >
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
								</tr>							
							</table>
					</a>
					
					<a class="ne-sc" href="" >
						
						<div class="ne-sc-title">테마 이미지</div>
							
							<table class="description">
								<tr>
									<th>방이름</th>
									<td>그레이</td>
								</tr>
								<tr>
									<th>장르</th>
									<td>추리</td>
								</tr>
								<tr>
									<th>가격</th>
									<td>30000</td>
								</tr>
								<tr>
									<th>최소인원</th>
									<td>2명</td>
								</tr>
								<tr>
									<th>최대인원</th>
									<td>4명</td>
								</tr>
								<tr>
									<th>성인유무</th>
									<td>N</td>
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