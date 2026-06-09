package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CafeReservationDTO {
	private long reservationId;
	private long cafeId;
	private long roomId;
	private String cafeName;
	private String roomName;
	private String openAt;
	private long bookerId;
	private String bookerName;
	private String bookerTel;
	private	int totalMember;

}
