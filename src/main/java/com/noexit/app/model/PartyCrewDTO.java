package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PartyCrewDTO
{
	private long crewId;
	private long partyId;
	private String nickName;
	private long userId;
	private long applyId;
	private int age;
	private String gender;
	private double temp;
	private String ready;
	private String position;
}
