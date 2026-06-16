package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CafeDropReason {

	private Long dropReasonId;     
	private String dropReasonName; // 폐업/개인사정/사용자신고
}