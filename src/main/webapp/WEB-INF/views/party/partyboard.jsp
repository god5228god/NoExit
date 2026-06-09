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
	height: 300px;
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
	height: 200px;
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
	height: 400px;
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

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript">
	
	let lastCommentId = 0;
	let partyId = '${partyId}';
	let userId = '${userId}';
	let position = '${position}';
	let status = '${status}';
	
	$(function()
	{
		let interval = setInterval(function()
		{
			//alert("1초");		
			//alert(partyId + " | " + position + " | " + status);
			
			let param = "lastCommentId=" + lastCommentId;
			
			$.ajax(
			{
				"type":"POST"
				, "url":"${path}/party/data/" + partyId
				, "data":param
				, "dataType":"json"
				, "success":function(data)
				{
					partyInfo(data.partyInfo);
					crewList(data.crewList);
					applyList(data.applyList);
					commentList(data.commentList);
				}
				,"error":function(e)
				{
					clearInterval(interval);  
		            if (e.status === 401) 
		            {
		                location.href = "/user/login";
		            } 
		            else if (e.status === 403 || e.status === 404) 
		            {
		                location.href = "/party/list";
		            } 
		            else 
		            {
		                console.log(e.responseText);   
		            }
				}
			}); 
			
		},5000);
		
		$("[name='partyComment']").on("keydown",function(evt)
		{
			if(evt.key == "Enter")
			{
				evt.preventDefault();
				
				commentWrite();
			}
		});
		
		// 댓글 삭제
		$(".comment-delete").click(function()
		{
			alert(this.getAttribute("data-comment-id"));
		});
		
		// 파티 승인
		$(".aprv-apply").click(function()
		{
			alert(this.getAttribute("data-apply-id"));
		});
		
		// 파티 거절
		$(".reject-apply").click(function()
		{
			alert(this.getAttribute("data-apply-id"));	
		});
	
		// 파티 탈퇴;
		$(".btn-out").click(function()
		{
			alert(this.getAttribute("data-apply-id"));
		});
		
		// 파티 강퇴
		$(".btn-kick").click(function()
		{
			alert(this.getAttribute("data-apply-id"));
		});
		
		partyName = document.querySelector("#partyName");
		cafeName = document.querySelector("#cafeName");
		themeDate = document.querySelector("#themeDate");
		themeTime = document.querySelector("#themeTime");
		themePlayers = document.querySelector("#themePlayers");
		themeStatus = document.querySelector("#themeStatus");
		genderName = document.querySelector("#genderName");
		partyComment = document.querySelector("#partyComment");
		partyCrewList = document.querySelector(".party-crew-list");
	});
	
	let partyName;
	let cafeName;
	let themeDate;
	let themeTime;
	let themePlayers;
	let themeStatus;
	let genderName;
	let partyComment;
	
	function partyInfo(data)
	{
		partyName.innerText= data.partyName;
		cafeName.innerText = data.cafeName;
		themeDate.innerText = data.themeDate;
		themeTime.innerText = data.themeTime;
		themePlayers.innerText = data.minPlayers + "명 ~ " + data.maxPlayers + "명";
		themeStatus.innerText = data.slotStatus == 1 ? "예약 가능" : "예약 불가" ;
		genderName.innerText = data.genderName;
		partyComment.innerText = data.partyComment;
	}
	
	let partyCrewList;
	
	function crewList(list)
	{
		 partyCrewList.innerHTML = "";
		 
	    list.forEach(function(item)
	    {
	        partyCrewList.insertAdjacentHTML("beforeend", createCrew(item));
	    });
	}
	
	function createCrew(item)
	{
		let html = "<div class='crew'>"
			 + "<div class='crew-info'>"
			 + "<span>" + item.nickName + "</span>"
			 + "<span>" + item.age + "세</span>"
			 + "<span>" + item.gender + "</span>"
			 + "<span>🌡️" + item.temp + "</span>"
			 + "</div>"
			 +"<div class='crew-position'>";
			 
		if(item.position == 'HOST')
		{
			html += "<span class='ne-st ne-st-green'>" + "파티장" + "</span>";
		}
		else
		{
			if(item.ready == 'READY')
			{
				html += "<span class='ne-st ne-st-amber'>준비 완료</span>";
			}
			else
			{
				html += "<span class='ne-st ne-st-red'>준비 중</span>";
			}
			
			html += "<span class='ne-st ne-st-blue'>파티원</span>";
			
			// 방장이면
			if(position=="HOST")
			{
				html += "<button class='btn ne-btn-deact btn-kick' data-apply-id='" + item.crewId + "'>강퇴</button>"; 
			}
			// 자기 자신이면
			else if(item.userId == userId)
			{
				html += "<button class='btn ne-btn-deact btn-out' data-apply-id='" + item.applyId + "'>탈퇴</button>";
			}
			
			html += "</div>";
			html += "</div>";
		}
		
		return item;
	}
	
	function applyList(applyList)
	{
		
	}
	
	function commentList(commentList)
	{
		
	}
	
	function commentWrite()
	{
		let comment = document.querySelector("[name='partyComment']");
		
		if(!comment.value.trim())
		{
			alert("메시지가 없습니다.");
			comment.focus();
			return;
		}
		
		alert("댓글 작성");
		comment.value = "";
		
		// ajax 댓글 작성
	}
			
	function deleteComment(commentId)
	{
		// ajax 삭제 요청
	}
	
	function onReady()
	{
		alert("레디");
		// ajax 레디 요청
	}
	
	function approveApply(applyId)
	{
		alert("승인");
		// ajax 승인 요청
	}
	
	function rejectApply(applyId)
	{
		alert("거절");
		// ajax 거절 요청
	}
	
	function reservation()
	{
		alert("예약");
		// 예약 페이지 이동
	}
	
	function partyUpdate()
	{
		alert("파티 수정");
		// 파티 수정 페이지 이동
	}
	
	function partyDelete()
	{
		alert("파티 해산");
		// confirm 만 물어보고 바로 delete 처리
		// 이후 마이 페이지로
	}
	
</script>

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
							<span id="partyName">주열룸</span>
						</div>
						
						<div class="theme-info">
							<span id="cafeName">우주별&nbsp;&nbsp;</span>
							<span id="themeName">그레이&nbsp;&nbsp;</span>
							<span id="themeDate">2026-06-01&nbsp;&nbsp;</span>
							<span id="themeTime">18:00&nbsp;&nbsp;</span>
							<span id="themePlayers">2명 ~ 4명</span>
							<span id="themeStatus">예약 가능/예약 불가</span>
						</div>
						
						<div class="party-condition">
							<span id="genderName">성별 동성/무관</span>
							<span id="partyComment">미쿠 좋아하는 사람만 오셈</span>						
						</div> 
						
						<div class="party-action">
							
							<button type="button" class="btn btn-primary" onclick="reservation()">예약하기</button>
							<button type="button" class="btn btn-outline-primary" onclick="partyUpdate()">파티 수정</button>
							<button type="button" class="btn ne-btn-deact" onclick="partyDelete()">파티 해산</button>
							
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
								<button type="button" class="comment-delete" data-comment-id="1">삭제</button>
								<span class="comment">오 얼마임?</span>
								<span class="writer">김주열</span>
							</div>
							
							<div class="comment-item other">
								<span class="writer">윤주열</span>
								<span class="comment">삭제된 댓글입니다</span>
							</div>
							
							<div class="comment-item other">
								<span class="writer">윤주열</span>
								<span class="comment">5억</span>
							</div>
							
							<div class="comment-item mine">
								<span class="comment">삭제된 댓글입니다</span>
								<span class="writer">김주열</span>
							</div>
							
							<div class="comment-item mine">
								<button type="button" class="comment-delete" data-comment-id="2" >삭제</button>
								<span class="comment">제 정신임?</span>
								<span class="writer">김주열</span>
							</div>
							
						</div>
					
						<div class="comment-write-form">
						
							<input type="text" name="partyComment" placeholder="댓글">
							<button type="button" class="btn btn-primary" onclick="commentWrite()">작성</button>		
						
						</div>
								
					</div>
										
				</div>
				 
				 
				<div class="right-wrap">
					
					<div class="party-crew">
						
						<span class="title">파티원</span>
						<hr>
						
						<div class="party-crew-list">
						
							<!-- <div class="crew">
								
								<div class="crew-info">
									<span>윤주열</span>
									<span>29세</span>
									<span>남자</span>
									<span>🌡️36.5</span>
								</div>
								
								<div class="crew-position">
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
									<span class="ne-st ne-st-amber">준비 완료</span>
									<span class="ne-st ne-st-blue">파티원</span>
									<button class="btn ne-btn-deact btn-out" data-apply-id="1">탈퇴</button>
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
									<button class="btn ne-btn-deact btn-kick" data-apply-id="2">강퇴</button>
								</div>
								
							</div> -->
							
						</div> 
						
						<div class="crew-action">
							
							<button type="button" class="btn btn-primary" onclick="onReady()">레디</button>
							
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
									
									<button type="button" class="btn btn-primary aprv-apply" data-apply-id="1">승인</button>
									<button type="button" class="btn btn-outline-primary reject-apply" data-apply-id="1">거절</button>
									
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