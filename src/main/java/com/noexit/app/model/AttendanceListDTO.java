package com.noexit.app.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AttendanceListDTO {

	private Long   reservationId;
	private Date   openAt;
	private Long   cafeId;
	private String cafeName;
	private Long   roomId;
	private String roomName;
	private Long   leaderId;
	private String leaderNickname;
	private int    totalMember;
	private String statusName;
	private Long   attendanceId;
	private Long   userId;
	private Long   attendStatusId;
}
