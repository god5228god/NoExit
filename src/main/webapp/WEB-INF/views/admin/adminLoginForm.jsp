<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
    crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dist/css/common.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container my-5" style="max-width: 480px;">

    <a href="${pageContext.request.contextPath}/" class="d-block text-center mb-4 text-decoration-none">
        <strong style="font-size: 28px;">Noexit<br></strong>
        <span style="font-size: 28px;">[관리자 모드]</span>
    </a>

    <div class="ne-sc">
        <div class="ne-sc-title fs-5">관리자 로그인</div>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger small mt-3 mb-3">${errorMessage}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">

            <div class="mb-3">
                <label for="loginId" class="form-label">관리자 아이디</label>
                <input type="text" id="loginId" name="loginId" class="form-control" autocomplete="off">
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control">
            </div>

            <button type="submit" class="btn btn-dark w-100">관리자 로그인</button>
        </form>
    </div>

    <div class="text-center mt-3 small">
        <a href="${pageContext.request.contextPath}/user/login" class="text-muted">일반 로그인으로</a>
    </div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>