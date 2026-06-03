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
</style>
</head>
<body>
	<header class="ne-header d-flex justify-content-around align-items-center bg-white shadow-sm">
		<div class="nav-left">
			<ul class="d-flex m-0 gap-3">
				<li><a href="#" >PARTY</a></li>
				<li><a href="#">THEME</a></li>
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
				<li><a href="#">CAFE</a></li>
				<li><a href="#">LOGIN</a></li>
			</ul>
		</div>
	</header>



</body>
</html>