package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OpenReservationDTO {
	private long cafeId;
	private String cafeName;
	private long roomId;
	private String roomName;
	private long ownerId;
	private long managerId;
	private String openAt;
	private String openDate;
	private String openTime;
	private long resOpenId;
}
