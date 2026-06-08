package com.noexit.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.OpenReservationDTO;

@Mapper
public interface OpenReservationMapper {

	// 카페 목록 조회 
	public List<OpenReservationDTO> getCafeList (long userId);
	
	// 등록된 예약 오픈 목록 조회
	public List<OpenReservationDTO> getOpenReservationList (Map<String, Object> map);
	
	// 예약 오픈 등록 프로시저
	public void openReservation(Map<String, Object> map);
	
	// 예약 비활성화 등록 프로시저
	public void dropOpen(long userId, long resOpenId);
	
}
