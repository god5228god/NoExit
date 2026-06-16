package com.noexit.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Manager {

	// MANAGER_HISTORY
	private Long managerHistoryId;
	private Long cafeId;
	private Long userId;
	private Long regEventId;       // 1=등록, 2=해제
	private Date createdAt;

	//목록 표시 JOIN용
	private String cafeName;       // CAFE.CAFE_NAME
	private String loginId;        // USER_ACCOUNT.LOGIN_ID 검색용
	private String nickname;       // USER_ACCOUNT.NICKNAME
	private String name;           // USER_INFO.NAME
	private String phone;          // USER_INFO.PHONE
	private String regEventName;   // 등록/해제

}
