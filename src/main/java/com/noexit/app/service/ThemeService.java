package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.SearchFilterDTO;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeDropReason;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;

public interface ThemeService
{

	public List<Cafe> getCafeList(long userId);
	public int themeInsert(ThemeDTO dto) throws Exception;
	public ThemeDTO getThemeById(long themeId);
	public int themeUpdate(ThemeDTO dto) throws Exception;
	public List<ThemeDTO> selectListByOwnerUserId(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public List<ThemeDropReason> getDropReasonList();
	public void themeDrop(Long themeId, Long dropReasonId, Long ownerUserId) throws Exception;
	
	
	
	/*
	 * 테마 목록을 가져오는 메소드
	 * 테마 정보 조회 (위와 동일)
	 * 테마 예약 슬롯 조회
	 * 테마 리뷰 조회
	 */
	
	ThemeDTO getThemeInfoById(long themeId);
	List<ThemeDTO> getThemeList(Map<String, Object> map,SearchFilterDTO filter);
	Map<String,List<ThemeSlotDTO>> getThemeSlot(long themeId);
	List<ThemeReviewDTO> getThemeReview(long themeId);
	ThemeReviewDTO getTotalReview(long themeId);
	

}
