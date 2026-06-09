package com.noexit.app.service;

import java.util.List;

import com.noexit.app.model.CafeReservationDTO;

public interface CafeReservationService {
	
	// 예약 목록 조회
	public List<CafeReservationDTO> resList(long roomId);
	
	// 예약 상세 조회
	public List<CafeReservationDTO> resDetail(long reservationId);
	
	// 예약 취소 프로시저
	public void resDelete(long reservationId);
}
