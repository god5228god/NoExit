package com.noexit.app.service;

import java.util.List;

import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.Manner;

public interface AttendanceService {

	public Manner noshow(Long userId) throws Exception;
	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId); // 출석체크 목록 조회
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId); // 매니저 출석체크 목록 조회
	public AttendanceListDTO attend(AttendanceListDTO dto) throws Exception; // 출석/노쇼 처리
}
