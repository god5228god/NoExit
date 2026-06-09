package com.noexit.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.noexit.app.model.OpenReservationDTO;

@Mapper
public interface OpenReservationMapper {

	// 카페 목록 조회 
	public List<OpenReservationDTO> getCafeList (long userId);
	
	// 테마 목록 조회
	public List<OpenReservationDTO> getThemeList (long cafeId);
	
	// 등록된 예약 오픈 목록 조회
	public List<OpenReservationDTO> getOpenReservationList (Map<String, Object> map);
	
	// 예약 오픈 등록 프로시저
	public void openReservation(Map<String, Object> map) throws Exception;
	
	// 예약 비활성화 등록 프로시저
	public void dropOpen(@Param("userId")long userId, @Param("resOpenId") long resOpenId) throws Exception;
	
	// 예약 오픈 데이터 갯수
	//public int dataCount(Map<String, Object> map);
	
}
