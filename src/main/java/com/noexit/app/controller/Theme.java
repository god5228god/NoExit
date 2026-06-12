package com.noexit.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.noexit.app.mapper.ThemeMapper;
import com.noexit.app.model.SearchFilterDTO;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.ThemeReviewDTO;
import com.noexit.app.model.ThemeSlotDTO;
import com.noexit.app.service.ThemeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/theme/*")
public class Theme
{
	private final ThemeService themeService;
	
    private final AdminController adminController;

    Theme(AdminController adminController, ThemeService themeService) 
    {
        this.adminController = adminController;
        this.themeService = themeService;
    }

    /*
     * themelist 페이지로 이동하는 메소드
     * 파라미터로 schTpye, kwd 를 받고
     * 키워드가 존재한다면 바인딩해서 넘겨준다
     */
	@GetMapping("list")
	public String themeListPage(@RequestParam(name="schType", defaultValue = "cafeName") String schType
						  , @RequestParam(name="kwd", defaultValue = "") String kwd
						  , Model model
						  , SearchFilterDTO filter)
	{
		/*
		 * 유효성 검사 목록
		 *
		 * 없음
		 */

		if(!kwd.isBlank())
		{
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
		}

		if(filter.getMinPrice() != null)
			model.addAttribute("minPrice", filter.getMinPrice());
		if(filter.getMaxPrice() != null)
			model.addAttribute("maxPrice", filter.getMaxPrice());
		if(filter.getMinLevel() != null)
			model.addAttribute("minLevel", filter.getMinLevel());
		if(filter.getMaxLevel() != null)
			model.addAttribute("maxLevel", filter.getMaxLevel());
		if(filter.getMinHorror() != null)
			model.addAttribute("minHorror", filter.getMinHorror());
		if(filter.getMaxHorror() != null)
			model.addAttribute("maxHorror", filter.getMaxHorror());
		
		return "theme/themelist";
	}

	/**
	 * AJAX 요청을 받아서 데이터를 넘겨주는 메소드
	 *
	 * @param schType : 검색 타입
	 * @param kwd     : 검색 키워드
	 * @param lastId  : 마지막으로 받은 데이터 번호
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping("list")
	public List<ThemeDTO> themeListData(@RequestParam(name="schType", defaultValue = "C.CAFE_NAME") String schType
						  , @RequestParam(name="kwd", defaultValue = "") String kwd
						  , @RequestParam(name="lastId", defaultValue = "0") long lastId
						  , SearchFilterDTO filter)
	{
		/*
		 * 유효성 검사 목록
		 *
		 * 없음
		 * 
		 */ 
		
		/* 
		 * 가져 와야하는 테마 정보는
		 * 
		 * 테마 번호
		 * 테마 이미지 경로
		 * 테마명
		 * 테마 장르명
		 * 테마 시간
		 * 테마 난이도
		 * 테마 공포도
		 * 테마 최소 인원
		 * 테마 최대 인원
		 * 
		 */

		Map<String, Object> map = new HashMap<>();
		
		map.put("lastId", lastId);
		
		try
		{		
			if(!kwd.isBlank())
			{
				map.put("kwd", kwd);
				map.put("schType", schType);
			}
			
			List<ThemeDTO> list = themeService.getThemeList(map,filter);
			
			return list;
		} 
		catch (Exception e)
		{
			log.info("themeListData : ",e);
		}
		
		return null;
	}

	/**
	 * 특정 테마의 세부 정보를 찾아주는 메소드
	 *
	 * @param themeId : 테마 번호
	 * @param model
	 * @return
	 */
	@GetMapping("info/{themeid}")
	public String themeDetail(@PathVariable(name="themeid") int themeId, Model model)
	{
		/*
		 * 유효성 검사 목록
		 *
		 * 존재하는 themeId 인가?
		 * 
		 */
		
		/*
		 * 가져와야 하는 테마 정보
		 * 
		 * 테마 번호
		 * 테마 이미지 경로
		 * 카페명
		 * 카페위치
		 * 카페전화번호
		 * 테마명
		 * 테마 장르
		 * 테마 시간
		 * 난이도
		 * 공포도
		 * 활동도
		 * 테마 가격
		 * 최소 인원
		 * 최대 인원
		 * 테마 소개
		 * 
		 * 예약 슬롯 목록
		 * 
		 * 날짜 , 시간 , 슬롯 번호 
		 * 
		 * 리뷰 개수
		 * 리뷰 목록
		 * 
		 * 작성자 
		 * 만족도
		 * 체감난이도
		 * 체감공포도
		 * 체감활동도
		 * 몰입도
		 * 코멘트
		 */
		
		try
		{
			ThemeDTO dto = themeService.getThemeInfoById(themeId);
			
			if(dto == null)
			{
				return "redirect:/theme/list";
			}
			
			Map<String, List<ThemeSlotDTO>> slot = themeService.getThemeSlot(themeId);
			
			List<ThemeReviewDTO> review = themeService.getThemeReview(themeId);
			
			int  count = 0;
			
			if(!review.isEmpty())
			{
				count = review.size();				
			}
			
			ThemeReviewDTO total = themeService.getTotalReview(themeId);	
			model.addAttribute("dto",dto);
			model.addAttribute("slot",slot);
			model.addAttribute("review",review);
			model.addAttribute("total", total);
			model.addAttribute("count", count);
		} 
		catch (Exception e)
		{
			log.info("themeDetail : ",e);
		}
		
		return "theme/themeinfo";
	}



}
