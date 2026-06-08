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
	private String roonName;
	private long ownerId;
	private long managerId;
	private String openAt;
	private long resOpenId;
}
