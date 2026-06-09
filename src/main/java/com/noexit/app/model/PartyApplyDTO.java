package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PartyApplyDTO
{
	private long applyId;
	private long partyId;
	private long userId;
	private String nickName;
	private String gender;
	private int age;
	private int temp;
	private String applyComment;
	private String createdAt;
}
