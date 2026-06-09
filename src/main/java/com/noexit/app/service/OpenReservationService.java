package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.noexit.app.model.OpenReservationDTO;

public interface OpenReservationService {

	// 카페 목록 조회 
	public List<OpenReservationDTO> getCafeList (long userId);
	
	// 테마 목록 조회
	public List<OpenReservationDTO> getThemeList (long cafeId);
	
	// 등록된 예약 오픈 목록 조회
	public List<OpenReservationDTO> getOpenReservationList (Map<String, Object> map);
		
	// 예약 오픈 등록 프로시저
	public void openReservation(Map<String, Object> map) throws Exception;
	
	// 예약 비활성화 등록 프로시저
	public void dropOpen(long userId, long resOpenId) throws Exception;
	
	// 예약 오픈 등록 페이징 처리 
	//public Map<String, Object> getListPaging(Map<String, Object> map);
	
	// 예약 오픈 데이터 갯수
	//public int dataCount(Map<String, Object> map);
}
