package com.noexit.app.model;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AttendForm {

	private Long reservationId;
	private List<Long> userIds;
	private List<Long> attendStatusIds;
}
