package com.noexit.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;

@Mapper
public interface ThemeMapper
{
	public void getGenreList();
	public List<Cafe> getCafeList(long userId);
	public int themeInsert(ThemeDTO dto);
	public ThemeDTO getThemeById(long themeId);
	public int themeUpdate(ThemeDTO dto);
	public int themeDelete(long themeId);
		
		
		/*
		 * 테마 목록을 가져오는 메소드
		 * 테마 정보 조회 (위와 동일)
		 * 테마 예약 슬롯 조회
		 * 테마 리뷰 조회
		 */
		
		List<ThemeDTO> getThemeList(Map<String, Object> map);
		List<ThemeSlotDTO> getThemeSlot(long themeId);
		List<ThemeReviewDTO> getThemeReview(long themeId);
}
