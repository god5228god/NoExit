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

/* ── 레이아웃 ──────────────────────────────────── */
.container {
	display: grid;
	grid-template-columns: 3fr 2fr;
	gap: 1.25rem;
	padding: 1.5rem 0;
	align-items: start;
}

.left-wrap,
.right-wrap {
	display: flex;
	flex-direction: column;
	gap: 1.25rem;
}

/* 공통 패널 (ne-sc 위에 영역별 높이만 부여) */
.left-wrap > div,
.right-wrap > div {
	display: flex;
	flex-direction: column;
	gap: .5rem;
}
.panel-title {
	font-weight: 700;
	font-size: .9rem;
	color: var(--ne-text);
	padding-bottom: .5rem;
	margin-bottom: .25rem;
	border-bottom: 2px solid var(--ne-primary);
}

/* ── 파티 정보 ─────────────────────────────────── */
.party-name {
	font-size: 1.3rem;
	font-weight: 800;
	margin-bottom: .25rem;
}
.theme-info {
	display: flex;
	flex-wrap: wrap;
	gap: .35rem;
	margin-bottom: .25rem;
}
.theme-info span {
	font-size: .82rem;
	font-weight: 600;
	color: var(--ne-text-2);
	background: var(--ne-bg);
	border: 1px solid var(--ne-border-dark);
	border-radius: 20px;
	padding: .2em .7em;
}
.party-condition {
	display: flex;
	flex-direction: column;
	gap: .4rem;
	margin-bottom: .25rem;
}
.party-condition #genderName {
	align-self: flex-start;
	font-size: .82rem;
	font-weight: 600;
	color: var(--ne-primary-dark);
	background: var(--ne-primary-light);
	border: 1px solid var(--ne-primary-mid);
	border-radius: 20px;
	padding: .2em .7em;
}
.party-condition #partyComment {
	font-size: .88rem;
	color: var(--ne-text-2);
	line-height: 1.6;
	background: var(--ne-bg);
	border-radius: var(--ne-radius-sm);
	padding: .6rem .8rem;
}
.party-action {
	display: flex;
	flex-wrap: wrap;
	gap: .5rem;
	justify-content: center;
	margin-top: .5rem;
}

/* ── 댓글 (채팅) ───────────────────────────────── */
.comment-list {
	display: flex;
	flex-direction: column;
	gap: .6rem;
	height: 400px;
	overflow-y: auto;
	background: var(--ne-bg);
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-md);
	padding: .85rem;
}
.comment-item {
	display: flex;
	align-items: flex-end;
	gap: .4rem;
	max-width: 80%;
}
.comment-item.other { margin-right: auto; }
.comment-item.mine  { margin-left: auto; flex-direction: row; }

.writer {
	font-size: .72rem;
	font-weight: 700;
	color: var(--ne-text-2);
	flex-shrink: 0;
	padding-bottom: .15rem;
}
.comment {
	font-size: .88rem;
	line-height: 1.45;
	padding: .5rem .8rem;
	border-radius: 14px;
	background: #ffffff;
	border: 1px solid var(--ne-border-dark);
	word-break: break-all;
}
.comment-item.mine .comment {
	background: var(--ne-primary);
	border-color: var(--ne-primary);
	color: #111;
}
.write-date {
	font-size: .68rem !important;
	color: var(--ne-text-3);
	flex-shrink: 0;
	padding-bottom: .15rem;
}
.comment-delete {
	font-size: .68rem;
	border: none;
	background: none;
	color: var(--ne-text-3);
	cursor: pointer;
	flex-shrink: 0;
	padding-bottom: .15rem;
}
.comment-delete:hover { color: var(--ne-red); }

.comment-write-form {
	display: flex;
	gap: .5rem;
	margin-top: .5rem;
}
.comment-write-form input {
	flex: 1;
	padding: .5rem .8rem;
	border: 1.5px solid var(--ne-border-dark);
	border-radius: var(--ne-radius-sm);
	font-size: .9rem;
	color: var(--ne-text);
}
.comment-write-form input:focus {
	outline: none;
	border-color: var(--ne-primary);
	box-shadow: 0 0 0 .2rem rgba(253, 180, 0, .2);
}

/* ── 파티원 ────────────────────────────────────── */
.party-crew-list {
	display: flex;
	flex-direction: column;
	gap: .5rem;
	max-height: 240px;
	overflow-y: auto;
}
.crew {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: .5rem;
	padding: .6rem .85rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-sm);
}
.crew-info {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	gap: .3rem .55rem;
	font-size: .84rem;
}
.crew-info span:first-child { font-weight: 700; }
.crew-info span { color: var(--ne-text-2); }
.crew-position {
	display: flex;
	align-items: center;
	gap: .35rem;
	flex-shrink: 0;
}
.crew-action {
	display: flex;
	justify-content: center;
	margin-top: .5rem;
}

/* ── 파티 신청 ─────────────────────────────────── */
.party-apply-list {
	display: flex;
	flex-direction: column;
	gap: .6rem;
	max-height: 340px;
	overflow-y: auto;
}
.apply-item {
	display: flex;
	flex-direction: column;
	gap: .5rem;
	padding: .8rem .9rem;
	background: #ffffff;
	border: 1px solid var(--ne-border);
	border-radius: var(--ne-radius-md);
}
.apply-info {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	gap: .3rem .55rem;
	font-size: .84rem;
}
.apply-info span:first-child { font-weight: 700; }
.apply-info span { color: var(--ne-text-2); }
.apply-comment p {
	margin: 0;
	font-size: .86rem;
	line-height: 1.55;
	color: var(--ne-text-2);
	background: var(--ne-bg);
	border-radius: var(--ne-radius-sm);
	padding: .5rem .75rem;
}
.apply-action {
	display: flex;
	justify-content: center;
	gap: .5rem;
}
.apply-action .btn { flex: 1; }

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>

<script type="text/javascript">

	let lastCommentId = 0;
	let lastDeleteCommentId = 0;
	let partyId = '${partyId}';
	let userId = '${userId}';
	let position = '${position}';
	let status = '${status}';

	// AJAX 딜레이
	let delay = 100;
	
	let flag = false;
	
	$(function()
	{
		// 데이터 AJAX 로 바인딩
		let interval = setInterval(function()
		{
			let param = "lastCommentId=" + lastCommentId + "&lastDeleteCommentId=" + lastDeleteCommentId;

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
					commentsRemove(data.commentDeleteList);

					if(data.commentList != null && data.commentList.length > 0)
					{
						lastCommentId = data.commentList[data.commentList.length-1].commentId;
					}

					if(data.commentDeleteList != null && data.commentDeleteList.length > 0)
					{
						lastDeleteCommentId = data.commentDeleteList[data.commentDeleteList.length-1].deleteId;
					}
				}
				,"error":function(e)
				{
					clearInterval(interval);
					
					if (e.status === 401)
		            {
				  		alert("로그인 안함");
		                location.href = "${path}/user/login";
		            }
		            else if (e.status === 403)
		            {
		            	alert("강퇴당했습니다.");
		                location.href = "${path}/party/list";
		            }
		            else if(e.status === 404)
	            	{
		    			alert("유효하지 않은 파티입니다.");
		    			location.href = "${path}/party/list";
	            	}
		            else if(e.status == 500)
		            {
		            	alert("서버 오류가 발생했습니다.");
		            	console.log(e.responseText);
		            }
		            else
		            {
		            	alert(e.responseText);
		                console.log(e.responseText);
		            }
				}
			});

		},delay);

		$("[name='partyComment']").on("keydown",function(evt)
		{
			if(evt.key == "Enter")
			{
				evt.preventDefault();

				commentWrite();
			}
		});

		// 댓글 삭제
		$(".comment-list").on("click",".comment-delete",function()
		{
			// alert(this.getAttribute("data-comment-id"));
			this.disabled = true;
			deleteComment(this.getAttribute("data-comment-id"),this);
		});

		// 파티 승인
		$(".party-apply-list").on("click",".aprv-apply",function()
		{
			// alert(this.getAttribute("data-apply-id"));
			this.disabled = true;
			approveApply(this.getAttribute("data-apply-id"),this);
		});

		// 파티 거절
		$(".party-apply-list").on("click",".reject-apply",function()
		{
			//alert(this.getAttribute("data-apply-id"));
			this.disabled = true;
			rejectApply(this.getAttribute("data-apply-id"),this);
		});

		// 파티 탈퇴;
		$(".party-crew-list").on("click",".btn-out",function()
		{
			//alert(this.getAttribute("data-apply-id"));
			this.disabled = true;
			crewOut(this.getAttribute("data-apply-id"),this);
		});

		// 파티 강퇴
		$(".party-crew-list").on("click",".btn-kick",function()
		{
			//alert(this.getAttribute("data-apply-id"));
			this.disabled = true;
			crewKick(this.getAttribute("data-crew-id"),this);
		});

		partyName = document.querySelector("#partyName");
		cafeName = document.querySelector("#cafeName");
		themeName = document.querySelector("#themeName");
		resDate = document.querySelector("#resDate");
		resTime = document.querySelector("#resTime");
		themePlayers = document.querySelector("#themePlayers");
		themeStatus = document.querySelector("#themeStatus");
		genderName = document.querySelector("#genderName");
		partyComment = document.querySelector("#partyComment");
		partyCrewList = document.querySelector(".party-crew-list");
		partyApplyList = document.querySelector(".party-apply-list");
		partyCommentList = document.querySelector(".comment-list");
	});

	let partyName;
	let cafeName;
	let themeName;
	let resDate;
	let resTime;
	let themePlayers;
	let themeStatus;
	let genderName;
	let partyComment;

	// 파티 정보 바인딩 함수
	function partyInfo(data)
	{
		partyName.innerText= data.partyName;
		cafeName.innerText = data.cafeName;
		themeName.innerText = data.themeName;
		resDate.innerText = data.resDate;
		resTime.innerText = data.resTime;
		themePlayers.innerText = data.minPlayers + "명 ~ " + data.maxPlayers + "명";
		
		if(data.partyStatus == 'confirm')
			themeStatus.innerText = "예약 완료"
		else
			themeStatus.innerText = data.slotStatus == 1 ? "예약 가능" : "예약 불가" ;
		
		genderName.innerText = data.genderName;
		partyComment.innerText = data.partyComment;
	}

	let partyCrewList;

	// 파티원 목록 생성 함수
	function crewList(list)
	{
		 partyCrewList.innerHTML = "";

	    list.forEach(function(item)
	    {
	        partyCrewList.innerHTML += (createCrew(item));
	    });
	}

	// 개별 파티원 HTML 생성 함수
	function createCrew(item)
	{
		let html = "<div class='crew'>"
				 + "<div class='crew-info'>"
				 + "<span>" + item.nickName + "</span>"
				 + "<span>" + item.age + "세</span>"
				 + "<span>" + (item.gender == 'F' ? '여' : '남') + "</span>"
				 + "<span class='ne-mannero'>🌡️ " + item.temp + "</span>"
				 + "</div>"
				 + "<div class='crew-position'>";

		if(item.position == 'HOST')
		{
			html += "<span class='ne-st ne-st-sm ne-st-dark'>파티장</span>";
		}
		else
		{
			if(item.ready == 'READY')
			{
				html += "<span class='ne-st ne-st-sm ne-st-amber'>준비 완료</span>";
			}
			else
			{
				html += "<span class='ne-st ne-st-sm ne-st-red'>준비 중</span>";
			}

			html += "<span class='ne-st ne-st-sm ne-st-primary'>파티원</span>";

			// 방장이면
			if(position=="HOST")
			{
				html += "<button class='ne-btn-deact btn-kick' data-crew-id='" + item.crewId + "'>강퇴</button>";
			}
			// 자기 자신이면
			else if(item.userId == userId)
			{
				html += "<button class='ne-btn-deact btn-out' data-apply-id='" + item.applyId + "'>탈퇴</button>";
			}
		}

		html += "</div>";
		html += "</div>";

		return html;
	}

	let partyApplyList;

	// 신청 목록 생성 함수
	function applyList(list)
	{
		partyApplyList.innerHTML = "";

		list.forEach(function(item)
		{
			partyApplyList.innerHTML += createApply(item);
		});
	}

	// 개별 신청 HTML 생성 함수
	function createApply(item)
	{
		let html = "<div class='apply-item'>"
				 + "<div class='apply-info'>"
				 + "<span>" + item.nickName + "</span>"
				 + "<span>" + item.age + "세</span>"
				 + "<span>" + (item.gender == 'F' ? '여' : '남') + "</span>"
				 + "<span class='ne-mannero'>🌡️ " + item.temp + "</span>"
				 + "</div>" // .apply-info
				 + "<div class='apply-comment'>"
				 + "<p>" + item.applyComment + "</p>"
				 + "</div>"; // .apply-comment

		if('${position}' == 'HOST')
		{
			html += "<div class='apply-action'>"
				 +  "<button type='button' class='btn btn-primary aprv-apply' data-apply-id='" + item.applyId + "'>승인</button>"
				 +  "<button type='button' class='btn btn-outline-primary reject-apply' data-apply-id='" + item.applyId + "'>거절</button>"
				 +  "</div>"; // .apply-action
		}

		html += "</div>"; // .apply-item

		return html;
	}

	let partyCommentList;

	// 댓글 목록 생성 함수
	function commentList(list)
	{
		list.forEach(function(item)
		{
			partyCommentList.innerHTML += createComment(item);
		});
	}

	// 개별 댓글 HTML 생성 함수
	function createComment(item)
	{
		let html = "";

		if(item.userId == '${userId}')
		{
			html += "<div class='comment-item mine'>"
				 +  "<button type='button' class='comment-delete' data-comment-id='" + item.commentId + "'>삭제</button>"
				 +  "<span class='comment' data-comment-id='" + item.commentId + "'>" + item.partyComment + "</span>"
				 +  "<span class='writer'>" + item.nickName + "</span>";
		}
		else
		{
			html += "<div class='comment-item other'>"
				 +  "<span class='writer'>" + item.nickName + "</span>"
				 +  "<span class='comment' data-comment-id='" + item.commentId + "'>" + item.partyComment + "</span>";
		}

		html += "<span class='write-date' data-comment-id='" + item.commentId + "'>" + item.createdAt + "</span>"
		 	 +  "</div>";

		return html;
	}
	
	// 삭제 댓글 목록 함수
	function commentsRemove(list)
	{
		list.forEach(function(item)
		{
			removeComment(item);
		});
	}

	// 개별 댓글 삭제 함수
	function removeComment(item)
	{
		let commentItem = document.querySelector(".comment[data-comment-id='" + item.commentId + "']");
		let deleteBtn = document.querySelector(".comment-delete[data-comment-id='" + item.commentId + "']");

		if(deleteBtn != null)
			deleteBtn.remove();

		if(commentItem != null)
			commentItem.innerText = "삭제된 메세지 입니다.";
	}

	// 댓글 작성 함수
	function commentWrite()
	{
		let commentInput = document.querySelector("[name='partyComment']");
		let comment = commentInput.value.trim();

		if(!comment)
		{
			alert("메시지가 없습니다.");
			commentInput.focus();
			return;
		}
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		
		flag = true;
		
		// alert("댓글 작성");
		// comment.value = "";

		// ajax 댓글 작성
		
		let param = new URLSearchParams(
		{
			partyId: partyId,
			partyComment: comment
			
		}).toString();
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/comment/insert"
			, "data":param
			, "dataType":"json"
			, "success":function(data)
			{
				commentInput.value = "";
				
				if(!data.status)
				{
					alert("댓글 작성 실패");
				}
				
				flag = false;
			}
			, "error":function(e)
			{
			  	if (e.status === 401)
	            {
			  		alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            {
	            	alert("권한이 없습니다.");
	                location.href = "${path}/party/list";
	            }
	            else if(e.status === 404)
            	{
	    			alert("유효하지 않은 파티입니다.");
	    			location.href = "${path}/party/list";
            	}
	            else if(e.stats == 500)
	            {
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
	            	console.log(e.responseText);
	            }
	            else
	            {
	            	alert(e.responseText);
	                console.log(e.responseText);
	            }
			  	
			  	flag = false;
			}
		});
	}

	// 댓글 삭제 함수
	function deleteComment(commentId,btn)
	{
		if(!confirm("삭제하시겠습니까?"))
		{
			btn.disabled = false;
			return;
		}
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		
		flag = true;
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/comment/delete/" + commentId
			, "dataType":"json"
			, "success":function(data)
			{
				if(!data.status)
				{
					alert("삭제 실패");
					btn.disabled = false;
				}
				
				flag = false;
			}
			, "error":function(e)
			{
			  	if (e.status === 401)
	            {
			  		alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            {
	            	alert("권한이 없습니다.");
	                location.href = "${path}/party/list";
	            }
	            else if(e.status == 404)
	            {
	            	alert("유효하지 않은 파티입니다.");
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 500)
			  	{
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	            	console.log(e.responseText);
			  	}
	            else
	            {
	            	alert(e.responseText);
	                console.log(e.responseText);
	            }
			  	
				btn.disabled = false;
			  	flag = false;
			}
		});
	}

	function onReady(btn)
	{
		//alert("레디");
		// ajax 레디 요청
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		
		flag = true;
		
		btn.disabled = true;
		
		$.ajax(
		{
			"type":"POST"
			,"url":"${path}/party/ready/" + partyId
			,"dataType":"json"
			,"success":function(data)
			{
				if(!data.status)
				{
					alert("레디 실패");	
				}
				
				flag = false;
				btn.disabled = false;
			}
			,"error":function(e)
			{
				if (e.status === 401)
	            {
					alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            {
	            	alert("권한이 없습니다.")
	                location.href = "${path}/party/list";
	            }
	            else if(e.status == 404)
            	{
	        		alert("유효하지 않은 파티입니다.");
	        		location.href = "${path}/party/list";
            	}
	            else if(e.status == 500)
	            {
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
	            	console.log(e.responseText);
	            }
	            else
	            {
	            	alert(e.responseText);
	                console.log(e.responseText);
	            }
				btn.disabled = false;
                flag = false;
			}
		});
		
	}

	function approveApply(applyId,btn)
	{
		if(!confirm("승인 하시겠습니까?"))
		{
			btn.disabled = false;
			return;
		}
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		
		flag = true;
		
		//alert("승인");
		// ajax 승인 요청
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/aprvapply/" + applyId
			, "dataType":"json"
			, "success":function(data)
			{
				if(!data.status)
				{
					alert("승인 실패");
					btn.disabled = false;
				}			
				flag = false;
			}
			, "error":function(e)
			{
				if (e.status === 401)
	            {
					alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            { 
	            	alert("승인 규칙을 벗어났습니다.")
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 404)
	            {
	            	alert("유효하지 않은 파티입니다.");
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 500)
	            {
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요");
	            	console.log(e.responseText);
	            }
	            else
	            {
	 				alert(e.responseText);
	                console.log(e.responseText);
	            }
				btn.disabled = false;
                flag = false;
			}
		});
	}

	function rejectApply(applyId,btn)
	{
		if(!confirm("거절 하시겠습니까?"))
		{
			btn.disabled = false;
			return;
		}
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		flag = true;
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/rejectapply/" + applyId
			, "dataType":"json"
			, "success":function(data)
			{
				if(!data.status)
				{
					alert("거절 실패");
					btn.disabled = false;
				}		
				flag = false;
			}
			, "error":function(e)
			{
				if (e.status === 401)
	            {
					alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            { 
	            	alert("권한이 없습니다.")
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 404)
	            {
	            	alert("유효하지 않은 파티입니다.");
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 500)
	            {
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요");
	            	console.log(e.responseText);
	            }
	            else
	            {
	 				alert(e.responseText);
	                console.log(e.responseText);
	            }
				btn.disabled = false;
                flag = false;
			}
		});
	}

	function reservation()
	{
		// alert("예약");
		// 예약 페이지 이동
		
		if(confirm("예약하시겠습니까?"))
		{
			window.location.href = "${path}/party/reservation/" + partyId;
		}
	}

	function partyUpdate()
	{
		//alert("구현 중");
		// 파티 수정 페이지 이동
		window.location.href="${path}/party/update/" + partyId;
	}

	function partyDelete()
	{
		//alert("파티 해산");
		// confirm 만 물어보고 바로 delete 처리
		// 이후 마이 페이지로
		
		if(confirm("파티를 해산 하시겠습니까?"))
		{
			if(flag)
			{
				alert("잠시 후 다시 시도하세요");
				return;
			}
			
			window.location.href="${path}/party/delete/" + partyId;
		}
	}
	
	function crewKick(crewId, btn)
	{
		if(!confirm("강퇴 시키겠습니까?"))
		{
			btn.disabled = false;
			return;
		}
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		
		flag = true;
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/kick/" + crewId
			, "dataType":"json"
			, "success":function(data)
			{
				if(!data.status)
				{
					alert("강퇴 실패");
					btn.disabled = false;
				}			
				flag = false;
			}
			, "error":function(e)
			{
				if (e.status === 401)
	            {
					alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            { 
	            	alert("권한이 없습니다.")
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 404)
	            {
	            	alert("유효하지 않은 파티입니다.");
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 500)
	            {
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요");
	            	console.log(e.responseText);
	            }
	            else
	            {
	 				alert(e.responseText);
	                console.log(e.responseText);
	            }
				btn.disabled = false;
                flag = false;
			}
		});
	}
	
	function crewOut(applyId, btn)
	{
		if(!confirm("탈퇴하시겠습니까?"))
		{
			btn.disabled = false;
			return;
		}
		
		if(flag)
		{
			alert("잠시 후 다시 시도하세요");
			return;
		}
		flag = true;
		
		$.ajax(
		{
			"type":"POST"
			, "url":"${path}/party/out/" + applyId
			, "dataType":"json"
			, "success":function(data)
			{
				if(!data)
				{
					btn.disabled = false;
					alert("탈퇴 실패");
					flag = fasle;
				}
				else
				{
					window.location.href="${path}/party/list";
				}
			}
			, "error":function(e)
			{
				if (e.status === 401)
	            {
					alert("로그인 안함");
	                location.href = "${path}/user/login";
	            }
	            else if (e.status === 403)
	            { 
	            	alert("권한이 없습니다.")
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 404)
	            {
	            	alert("유효하지 않은 파티입니다.");
	            	location.href = "${path}/party/list";
	            }
	            else if(e.status == 500)
	            {
	            	alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요");
	            	console.log(e.responseText);
	            }
	            else
	            {
	 				alert(e.responseText);
	                console.log(e.responseText);
	            }
				btn.disabled = false;
                flag = false;
			}
		});
	}
	
</script>

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<main class="ne-main-content ne-body-offset">
		<div class="ne-container">
			<div class="container">

				<!-- 좌측 -->
				<div class="left-wrap">

					<!-- 파티 정보 -->
					<div class="party-info-wrap ne-sc">

						<div class="panel-title">파티 정보</div>

						<div class="party-name">
							<span id="partyName">파티명</span>
						</div>

						<div class="theme-info">
							<span id="cafeName">카페명</span>
							<span id="themeName">테마명</span>
							<span id="resDate">날짜</span>
							<span id="resTime">시간</span>
							<span id="themePlayers">인원수</span>
							<span id="themeStatus">예약 가능/예약 불가</span>
						</div>

						<div class="party-condition">
							<span id="genderName">성별 동성/무관</span>
							<span id="partyComment">파티 코멘트</span>
						</div>

						<c:if test="${position == 'HOST' }">
							<div class="party-action">
								<button type="button" class="btn btn-primary" onclick="reservation()">예약하기</button>
								<button type="button" class="btn btn-outline-primary" onclick="partyUpdate()">파티 수정</button>
								<button type="button" class="ne-btn-deact" onclick="partyDelete()">파티 해산</button>
							</div>
						</c:if>
					</div>

					<!-- 파티 댓글 -->
					<div class="party-comment ne-sc">

						<div class="panel-title">파티 댓글</div>

						<div class="comment-list"></div>

						<div class="comment-write-form">
							<input type="text" name="partyComment" placeholder="댓글">
							<button type="button" class="btn btn-primary" onclick="commentWrite()">작성</button>
						</div>

					</div>

				</div>


				<!-- 우측 -->
				<div class="right-wrap">

					<!-- 파티원 -->
					<div class="party-crew ne-sc">

						<div class="panel-title">파티원</div>

						<div class="party-crew-list"></div>

						<c:if test="${position == 'CREW' }">
							<div class="crew-action">
								<button type="button" class="btn btn-primary" onclick="onReady(this)">레디</button>
							</div>
						</c:if>

					</div>

					<!-- 파티 신청 -->
					<div class="party-apply ne-sc">

						<div class="panel-title">파티 신청</div>

						<div class="party-apply-list"></div>

					</div>

				</div>

			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
