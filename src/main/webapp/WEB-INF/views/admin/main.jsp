<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href='${pageContext.request.contextPath }/dist/css/common.css'>
<style type="text/css">
	header{
		width: 100%;
		height: 100px;
	}



	.left-sidebar-wrapper{
		display: flex;
		margin-top: 10px;
	
	}
	
	.ne-card{
		margin: 10px;
	}

	.ne-sc{
		width:100%;
	}
	.ne-card-accent{
		margin:10px;
	}
	
	.ne-card ne-card-accent{
		display:flex;
	}

	.card-flex{
		display: flex;
	}
	
	.cafe-name{
		margin: 10px;
	}
	
	
	.ne-sc-title{
		display: flex;
	}


</style>

</head>
<body>
	<header class="ne-header d-flex justify-content-around align-items-center bg-white shadow-sm">
		<div class="nav-left">
			<ul class="d-flex m-0 gap-3">
				<li><strong>관리자 페이지</strong></li>
			</ul>
		</div>
		
		<div class="logo">
			<h1 class="m-0">
				<a href="${pageContext.request.contextPath }/" class="no-hover">
					<img src="${pageContext.request.contextPath }/dist/images/logo.png" alt="로고이미지" style="height: 40px;" />
				</a>
			</h1>
		</div>
		<div class="nav-right">
			<ul class="d-flex m-0 gap-3">
				<li><a href="${pageContext.request.contextPath }/admin/login">LOGOUT</a></li>
			</ul>
		</div>
	</header>



<div class="left-sidebar-wrapper">
	<nav class="ne-side-nav" >
		
		
		<div class="ne-side-nav-section">관리자 메뉴</div>
		<a href="/mypage/record" id="record" class="">카페 조회 및 숨김</a>
		<a href="/mypage/party" id="party"  class="">테마 · 리뷰 조회 및 숨김</a>
		<a href="/mypage/reservations" id="reservations"  class="">전체 회원 목록 조회</a>
		<a href="/" id="home">홈으로</a>	
	</nav>
	
	<div class ="ne-sc"><!-- 메인 섹션 구성 -->
	
		<div class="ne-card ne-card-accent">
			<div class="ne-sc-title">
				<h3 class="m-0 mb-1 fw-bold" style="padding:10px;" >최근 개설 카페 요약</h3>
			</div>
			<div class= "card-flex">
				<div class= "ne-card">
					<h4 class = "cafe-name">카페명 바인딩</h4>			
				</div>
				<div class= "ne-card">
					<h4 class = "cafe-name">카페명 바인딩</h4>			
				</div>
				<div class= "ne-card">
					<h4 class = "cafe-name">카페명 바인딩</h4>			
				</div> 			
			</div>
		</div>
		

		<div class="ne-card ne-card-accent">
			
			<div class="ne-cafe-count ne-count">
				<div class="ne-sc-title">
					<h3 class="m-0 mb-1 fw-bold" style="padding:10px;" >전체 테마 수</h3>
				</div>
				<div class="ne-cafe-count" style="border-color: red; width: 50px; height: 50px;">
					으아아아아
				</div>
			</div>
			
			<div class="ne-theme-count ne-count">
				<div class="ne-sc-title">
					<h3 class="m-0 mb-1 fw-bold" style="padding:10px;" >전체 카페 수</h3>
				</div>
			</div>
			
			<div class="ne-theme-count ne-count">
				<div class="ne-sc-title">
					<h3 class="m-0 mb-1 fw-bold" style="padding:10px;" >전체 회원 수</h3>
				</div>
			</div>	
		</div>
	
	</div><!-- 메인 섹션 구성 -->
</div>










	<%@ include file="/WEB-INF/views/common/footer.jsp" %>




</body>
</html>