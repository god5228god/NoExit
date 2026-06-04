package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/theme/*")
public class Theme
{

    private final CafeController cafeController;

    Theme(CafeController cafeController) {
        this.cafeController = cafeController;
    }
    
    /*
     * themelist 페이지로 이동하는 메소드
     * 파라미터로 schTpye, kwd 를 받고 
     * 키워드가 존재한다면 바인딩해서 넘겨준다
     */
	@GetMapping("list")
	public String themeListPage(@RequestParam(name="schType", defaultValue = "cafeName") String schType
						  , @RequestParam(name="kwd", defaultValue = "") String kwd
						  , Model model)
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
	@PostMapping()
	public String themeListItem(@RequestParam(name="schType", defaultValue = "cafeName") String schType
						  , @RequestParam(name="kwd", defaultValue = "") String kwd
						  , @RequestParam(name="lastId", defaultValue = "0") long lastId
						  , Model model)
	{
		/*
		 * 유효성 검사 목록
		 * 
		 * 없음
		 */
		
		return "";
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
		 */
		
		return "theme/themeinfo";
	}
	
	// 테마 등록
	@GetMapping("enroll")
	public String enrollForm()
	{
		return "theme/themeEnrollForm";
	}
	
}
