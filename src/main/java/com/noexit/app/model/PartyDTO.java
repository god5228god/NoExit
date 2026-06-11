package com.noexit.app.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PartyDTO
{
	private long partyId;
	private long slotId;
	private String partyStatus;
	private long userId;
	private String partyName;
	private String cafeName;
	private String themeName;
	private String themeImg;
	private String resDate;
	private String resTime;
	private double avgAge;
	private double avgTemp;
	private int memberCount;
	private int minPlayers;
	private int maxPlayers;
	private int price;
	private int slotStatus;
	private int genderId;
	private String genderName;
	private String partyComment;
}
