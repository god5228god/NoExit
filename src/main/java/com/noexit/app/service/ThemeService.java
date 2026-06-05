package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;

public interface ThemeService
{
	/*
	장르 목록 가져오는 메소드
	카페 목록 가져오는 메소드
	테마 등록하는 메소드
	테마 정보 조회하는 메소드
	테마 수정하는 메소드
	테마 삭제하는 메소드
	*/
	
	// 장르목록 DTO 필요
	/*장르목록DTO*/ void getGenreList();
	List<Cafe> getCafeList(long userId);
	int themeInsert(ThemeDTO dto) throws Exception;
	ThemeDTO getThemeById(long themeId);
	int themeUpdate(ThemeDTO dto);
	int themeDelete(long themeId);
	
	/*
	 * ↑ 위 메소드는 명철님이 사용함 
	 */
	
	
	/*
	 * 테마 목록을 가져오는 메소드
	 * 테마 정보 조회 (위와 동일)
	 * 테마 예약 슬롯 조회
	 * 테마 리뷰 조회
	 */
	
	List<ThemeDTO> getThemeList(Map<String, Object> map);
	Map<String, List<ThemeSlotDTO>> getThemeSlot(long themeId);
	List<ThemeReviewDTO> getThemeReview(long themeId);
}
