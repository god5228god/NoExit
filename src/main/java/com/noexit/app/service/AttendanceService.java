package com.noexit.app.service;

import java.util.List;

import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.AttendCrew;

public interface AttendanceService {

	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId); // 출석체크 목록 조회
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId); // 매니저 출석체크 목록 조회
	
	
	public List<AttendCrew> selectCrewByReservationId(Long reservationId);
	public void attendAll(List<AttendanceListDTO> list, Long staffUserId) throws Exception;
	public boolean isCheckable(Long reservationId);
}
