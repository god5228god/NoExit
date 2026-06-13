package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RecentPartyDTO {

	private Long partyId;
	private String partyName;
	private String cafeName;
	private String roomName;
	private String openAt;
	private Double avgTemp;
	private int partyCnt;
	private int maxPlayers;
	
}
