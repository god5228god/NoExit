package com.noexit.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @NoArgsConstructor
public class AttendItemDTO {
    private Long userId;
    private Long attendStatusId;
    private Long reservationId;
    private Long staffId;
    private Long attendanceId;
}
