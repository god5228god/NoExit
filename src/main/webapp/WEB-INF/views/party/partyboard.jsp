<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>partyboard.jsp</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">

.container
{
	display: grid;
	grid-template-columns: 3fr 2fr;
	padding-top: 20px;	
	padding-bottom: 20px;
	gap: 20px;
}

.left-wrap
{
	display: flex;
	flex-direction: column;;
	gap: 10px;
}

.left-wrap > div
{
	border: 1px solid black;
	border-radius: 5px;
	
	 display: flex;
	 flex-direction: column;
	 gap: 5px;
	 margin: 5px;
	 padding: 5px;
	 overflow-y: auto;
}

.title
{
	font-weight: bold;
	font-size: 15px;
}

.title + hr
{
	margin: 0;
	border-top: 1px solid black;
}


/* 파티 정보 */
.party-info-wrap 
{
  height: 250px;
}

.party-info-wrap span
{
	background: #f5f5f5;
}

.party-name 
{
  font-size: 20px;
  font-weight: bold;
}

.theme-info,
.party-condition,
.party-action
{
	display: flex;
  	flex-wrap: wrap;
  	gap: 5px;
}

.party-condition 
{
  	flex-direction: column;
}

.party-action
{
	justify-content: center;
}


/* comment */
.party-comment
{
	height: 450px;
}

.comment-list,
.comment-item,
.comment-write-form
{
	margin: 5px;
	padding: 5px;
	display: flex;
	gap: 5px;
}

.comment-list
{
	flex-direction: column;
	height: 400px;
	overflow-y: auto; 
	border: 1px solid #ddd;
	border-radius: 5px;
}

.comment-item
{
	align-items: center;
	max-width: 80%;
}

.comment-write-form
{
	justify-content: center;
}

.other
{
	margin-right: auto;
}

.mine
{
	margin-left: auto;
}

.writer
{
	font-size: 12px;
	
	padding: 2px 8px;
	border-radius: 15px;
	
	background: orange;
}

.comment
{
	font-size: 15px;
	padding: 6px 10px;	
	border: 1px solid #f5f5f5;
	border-radius: 10px;
	background: #f5f5f5;
}

.comment-delete
{
	font-size: 10px;
	border: none;
	background: none;
	color: #999;
}


.right-wrap > div
{
	display: flex;
	flex-direction: column;		
	gap: 5px;
	padding: 5px;
	margin: 5px;
	border: 1px solid black;
	border-radius: 5px;
	overflow-y: auto;
}

/* crew */
.party-crew
{
	font-size: 15px;
	height: 220px;
}

.party-crew-list,
.crew,
.crew-action
{
	margin: 5px;
	display: flex;
	gap: 5px;
}

.party-crew-list
{
	flex-direction: column;
	height: 120px;
	overflow-y: auto; 
}

.crew
{
	justify-content: space-between;
}

.crew-action
{
	justify-content: center;
}


/* 파티 신청 */
.party-apply
{
	height: 500px;
}

.party-apply-list,
.apply-item,
.apply-info,
.apply-action
{
	display: flex;
	gap: 5px;
}

.party-apply-list,
.apply-item
{
	flex-direction: column;
}

.apply-item
{
	border: 1px solid black;
	border-radius: 5px;
	margin: 5px;
	padding: 5px;
}

.apply-action
{
	justify-content: center;
}

</style>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">
				
				<div class="left-wrap">
					
					<div class="party-info-wrap">
						
						<span class="title">파티 정보</span>
						<hr>
						
						<div class="party-name">
							<span>주열룸</span>
						</div>
						
						<div class="theme-info">
							<span>우주별&nbsp;&nbsp;</span>
							<span>그레이&nbsp;&nbsp;</span>
							<span>2026-06-01&nbsp;&nbsp;</span>
							<span>18:00&nbsp;&nbsp;</span>
							<span>2명 ~ 4명</span>
						</div>
						
						<div class="party-condition">
							<span>성별 동성/무관</span>
							<span>미쿠 좋아하는 사람만 오셈</span>						
						</div> 
						
						<div class="party-action">
							
							<button type="button" class="btn btn-primary">예약하기</button>
							<button type="button" class="btn btn-outline-primary">파티 수정</button>
							<button type="button" class="btn ne-btn-deact">파티 해산</button>
							
						</div>
						
					</div>
					
					
					<div class="party-comment">
					
						<span class="title">파티 댓글</span>
						<hr>
					
						<div class="comment-list">
							
							<div class="comment-item other">
								<span class="writer">윤주열</span>
								<span class="comment">미쿠 티셔츠 샀음</span>
							</div>
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">오 얼마임?</span>
								<span class="writer">김주열</span>
							</div>
							
							<div class="comment-item other">
								<span class="writer">윤주열</span>
								<span class="comment">삭제된 댓글입니다.</span>
							</div>
							
							<div class="comment-item other">
								<span class="writer">윤주열</span>
								<span class="comment">5억</span>
							</div>
							
							<div class="comment-item mine">
								<span class="comment">삭제된 댓글입니다.</span>
								<span class="writer">김주열</span>
							</div>
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete">삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
						</div>
					
						<div class="comment-write-form">
						
							<input type="text" name="partyComment" placeholder="댓글">
							<button type="button" class="btn btn-primary">작성</button>		
						
						</div>
								
					</div>
										
				</div>
				 
				 
				<div class="right-wrap">
					
					<div class="party-crew">
						
						<span class="title">파티원</span>
						<hr>
						
						<div class="party-crew-list">
							<div class="crew">
								
								<div class="crew-info">
									<span>윤주열</span>
									<span>29세</span>
									<span>남자</span>
									<span>🌡️36.5</span>
								</div>
								
								<div class="crew-status">
									<span class="ne-st ne-st-amber">준비 완료</span>
									<span class="ne-st ne-st-green">파티장</span>
								</div>
								
							</div>
							
							<div class="crew">
							
								<div class="crew-info">
									<span>김주열</span>
									<span>29세</span>
									<span>남자</span>
									<span>🌡️36.5</span>
								</div>
								
								<div class="crew-position">
									<span class="ne-st ne-st-red">준비 중</span>
									<span class="ne-st ne-st-blue">파티원</span>
								</div>
								
							</div>
						</div> 
						
						<div class="crew-action">
							
							<button type="button" class="btn btn-primary">레디</button>
							
						</div>
						
					</div>
										
					<div class="party-apply">
						
						<span class="title">파티 신청</span>
						<hr>
						
						<div class="party-apply-list">
							
							<div class="apply-item">
								
								<div class="apply-info">
									
									<span>최주열</span>
									<span>15세</span>
									<span>여자</span>
									<span>🌡️47.2</span>
									
								</div>
								
								<div class="apply-comment">
									
									<p>안녕하세요!</p>
																	
								</div>
								
								<div class="apply-action">
									
									<button type="button" class="btn btn-primary">승인</button>
									<button type="button" class="btn btn-outline-primary">거절</button>
									
								</div>
								
							</div>
							
							<div class="apply-item">
								
								<div class="apply-info">
									
									<span>최주열</span>
									<span>15세</span>
									<span>여자</span>
									<span>🌡️47.2</span>
									
								</div>
								
								<div class="apply-comment">
									
									<p>안녕하세요!</p>
																	
								</div>
								
								<div class="apply-action">
									
									<button type="button" class="btn btn-primary">승인</button>
									<button type="button" class="btn btn-outline-primary">거절</button>
									
								</div>
								
							</div>
							
							<div class="apply-item">
								
								<div class="apply-info">
									
									<span>최주열</span>
									<span>15세</span>
									<span>여자</span>
									<span>🌡️47.2</span>
									
								</div>
								
								<div class="apply-comment">
									
									<p>안녕하세요!</p>
																	
								</div>
								
								<div class="apply-action">
									
									<button type="button" class="btn btn-primary">승인</button>
									<button type="button" class="btn btn-outline-primary">거절</button>
									
								</div>
								
							</div>
							
							<div class="apply-item">
								
								<div class="apply-info">
									
									<span>최주열</span>
									<span>15세</span>
									<span>여자</span>
									<span>🌡️47.2</span>
									
								</div>
								
								<div class="apply-comment">
									
									<p>안녕하세요!</p>
																	
								</div>
								
								<div class="apply-action">
									
									<button type="button" class="btn btn-primary">승인</button>
									<button type="button" class="btn btn-outline-primary">거절</button>
									
								</div>
								
							</div>
							
							<div class="apply-item">
								
								<div class="apply-info">
									
									<span>최주열</span>
									<span>15세</span>
									<span>여자</span>
									<span>🌡️47.2</span>
									
								</div>
								
								<div class="apply-comment">
									
									<p>안녕하세요!</p>
																	
								</div>
								
								<div class="apply-action">
									
									<button type="button" class="btn btn-primary">승인</button>
									<button type="button" class="btn btn-outline-primary">거절</button>
									
								</div>
								
							</div>
							
						</div>
						
					</div>
					
				</div>
				 
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>