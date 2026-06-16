package com.noexit.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeDropReason;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;

@Mapper
public interface ThemeMapper
{
	public int themeInsert(ThemeDTO dto);
	public ThemeDTO getThemeById(long themeId);
	public int themeUpdate(ThemeDTO dto);
	public int themeDelete(long themeId);

	public List<ThemeDTO> selectListByOwnerUserId(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
		
		
	/*
	 * 테마 목록을 가져오는 메소드
	 * 테마 정보 조회 (위와 동일)
	 * 테마 예약 슬롯 조회
	 * 테마 리뷰 조회
	 */
	
	
	ThemeDTO getThemeInfoById(long themeId);
	List<ThemeDTO> getThemeList(Map<String, Object> map);
	List<ThemeSlotDTO> getThemeSlot(long themeId);
	List<ThemeReviewDTO> getThemeReview(long themeId);
	ThemeReviewDTO getTotalReview(long themeId);
	
	public List<ThemeDropReason> selectDropReasonList();
	public int insertRoomDrop(Map<String, Object> map);
}
