package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MyPage {

	// 닉네임 바인딩 영역 ---------------------------------------
	// private String nickName;                 → 세션으로 가져오기
	
	// 상호평가 바인딩 영역--------------------------------------
	private Long detailId;						// 출석체크
	private Long targetId;
	private String cafeName;					// + 개인기록
	private String roomName;
	private String targetNickName;				// 상호평가 대상 닉네임
	
	private String firstQuestion;				// 상호평가 항목 1번
	private String secondQuestion;				// 상호평가 항목 2번
	
	private int firstAnswer;					// 상호평가 1번 답변
	private int secondAnswer;					// 상호평가 2번 답변
	
	
	// 개인기록 바인딩 영역---------------------------------------
	private String playDate;					// 플레이 일시
	private int playTime;						// 소요시간
	private int hintCount;						// 힌트 사용 갯수
	private int peopleCount;					// 플레이 인원 수
	private String recordComment;						// 기록 메모
	private int isEscaped;						// 탈출 여부
	private String createdAt;					// 등록 일자
	
	
	// 캘린더 바인딩 영역 ----------------------------------------
	private String reservedAt;					// 예약날짜
	private String reservedCafe;				// 예약매장
	private String reservedRoom;				// 예약테마
	
	// 매너온도 바인딩 영역 --------------------------------------
	private int manner;							// 매너온도
	
	
}
