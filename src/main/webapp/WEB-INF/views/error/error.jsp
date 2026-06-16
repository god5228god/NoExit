<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath }/dist/css/main.css" />
</head>
<body>
	<%-- <%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
			
				<h1>에러 페이지</h1><br>
			
				${errorMsg }

			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %> --%>
	
	<script type="text/javascript">
		
		alert("${errorMsg}");
		history.back();
	
	</script>
	
</body>
</html>