package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.AttendCrew;
import com.noexit.app.model.AttendItemDTO;

@Mapper
public interface AttendanceMapper {
	
	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId);
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId);
	
    public void mergeAttendance(Long reservationId, Long staffId);
    public void mergeAttendDetail(AttendItemDTO item);

    public int selectAttendanceExists(Long reservationId);
    public void insertAttendance(AttendItemDTO item);
    public void updateAttendanceStaff(AttendItemDTO item);

    public int selectAttendDetailExists(AttendItemDTO item);
    public void insertAttendDetail(AttendItemDTO item);
    public void updateAttendDetail(AttendItemDTO item);
	
	
	
	
}
