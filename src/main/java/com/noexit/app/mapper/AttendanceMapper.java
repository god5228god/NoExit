package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.AttendCrew;
import com.noexit.app.model.AttendItemDTO;
import com.noexit.app.model.Manner;

@Mapper
public interface AttendanceMapper {
	
	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId);
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId);

	// 한 예약의 파티원 리스트
	public List<AttendCrew> selectCrewByReservationId(Long reservationId);
	
    public void mergeAttendance(Long reservationId, Long staffId);
    public void mergeAttendDetail(AttendItemDTO item);

    public int selectAttendanceExists(Long reservationId);
    public void insertAttendance(AttendItemDTO item);
    public void updateAttendanceStaff(AttendItemDTO item);

    public int selectAttendDetailExists(AttendItemDTO item);
    public void insertAttendDetail(AttendItemDTO item);
    public void updateAttendDetail(AttendItemDTO item);

	// 파티원 1명당 출석 상태 INSERT
	public void insertAttendDetailByUser(AttendItemDTO item);

	// 노쇼 시 매너온도 차감
	public void callInsertNoshow(Manner manner);

}
