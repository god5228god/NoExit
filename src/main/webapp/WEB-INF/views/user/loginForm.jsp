<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/dist/css/common.css">
<style>

body {
		display: flex;
		justify-content: center; 
		align-items: center;     
		min-height: 100vh;       
		margin: 0;
		background-color: #f8f9fa;
	}

	.auth-wrap {
		width: 100%;
		max-width: 540px;    
		margin: 0 auto;
		padding: 40px 30px;  
		background: #ffffff; 
		border-radius: 12px; 
		box-shadow: 0 4px 12px rgba(0,0,0,0.05);
	}

	.auth-logo {
		display: flex;
		align-items: baseline;
		justify-content: center;
		gap: 0;
		text-decoration: none;
		margin-bottom: 28px;
	}
	.auth-logo .logo-main {
		font-weight: 900;
		font-size: 2.4rem;
		letter-spacing: -2px;
		color: var(--ne-text);
		line-height: 1;
	}
	.auth-logo .logo-dot {
		display: inline-block;
		width: 11px;
		height: 11px;
		border-radius: 50%;
		background: var(--ne-primary);
		margin: 0 2px 6px;
	}

	.page-title {
		font-size: 1.3rem;
		font-weight: 800;
		color: var(--ne-text);
		padding-bottom: 0.6rem;
		margin-bottom: 1.5rem;
		border-bottom: 2px solid var(--ne-primary);
	}

	.btn-login {
		width: 100%;
		padding: 12px 0;
		font-size: 1rem;
		margin-top: 8px;
	}


	.auth-links {
		display: flex;
		justify-content: center;
		gap: 14px;
		margin-top: 20px;
		font-size: 0.80rem;
	}
	.auth-links a {
		color: var(--ne-text-2);
		text-decoration: none;
	}
	.auth-links a:hover {
		color: var(--ne-primary-dark);
	}
	.auth-links .sep {
		color: var(--ne-border-dark);
	}
</style>
</head>
<body>

<div class="auth-wrap">

	<a href="${pageContext.request.contextPath}/" class="auth-logo">
		<span class="logo-main">Noexit</span>
	</a>

	<h2 class="page-title">로그인</h2>

	<form action="${pageContext.request.contextPath}/user/login" method="post">

		<div class="mb-3">
			<label for="loginId" class="form-label">아이디</label>
			<input type="text" id="loginId" name="loginId" class="form-control">
		</div>

		<div class="mb-3">
			<label for="password" class="form-label">비밀번호</label>
			<input type="password" id="password" name="password" class="form-control" >
		</div>

		<button type="submit" class="btn btn-primary btn-login">로그인</button>

	</form>

	<div class="auth-links">
		<a href="${pageContext.request.contextPath}/user/enroll">회원가입</a>
		<span class="sep">|</span>
		<a href="${pageContext.request.contextPath}/user/findId">아이디 찾기</a>
		<span class="sep">|</span>
		<a href="${pageContext.request.contextPath}/user/findPw">비밀번호 찾기</a>
	</div>

</div>

</body>
</html>
