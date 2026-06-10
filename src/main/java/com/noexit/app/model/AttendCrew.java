package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AttendCrew {

	private Long   userId;
	private String nickname;
	private String position;
	// 이전 선택값 (null = 미정)
	private Long   attendStatusId;
}
