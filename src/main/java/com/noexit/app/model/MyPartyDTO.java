package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyPartyDTO
{
	private Long userId;
	private String partyName;
	private String themeName;
	private String resDate;
	private String resTime;
	private Long applyId;
	private Long partyId;
	private String kickDate;
	private String kickTime;
	private String partyStatus;
}
