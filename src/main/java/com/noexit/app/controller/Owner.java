package com.noexit.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.ThemeDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.CafeService;
import com.noexit.app.service.CommonService;
import com.noexit.app.service.GenreService;
import com.noexit.app.service.ThemeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/*")
public class Owner {
	
	private final CafeService cafeService;
	private final ThemeService themeService;
	private final GenreService genreService;
	private final CommonService commonService;
	
	
	@GetMapping("/res/open")
	public String openReserv() {
	
		return "owner/openRes";
		
	}
	
	@GetMapping("/res/list")
	public String resList() {
	
		return "owner/resList";
		
	}
	
	// 테마 등록 폼
	@GetMapping("/theme/enroll")
	public String enrollForm(HttpSession session, Model model)
	{
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/user/login";
		}

		String role = (String) session.getAttribute("role");
		if (!"OWNER".equals(role)) {
		    return "redirect:/theme/list";
		}

		List<Cafe> cafeList = cafeService.selectByUserId(loginUser.getUserId());

		model.addAttribute("cafeList", cafeList);
		model.addAttribute("genreList", genreService.getGenreList());
		model.addAttribute("commonList", commonService.getCommonList());

		return "theme/themeEnrollForm";
	}

	// 테마 등록 처리
	@PostMapping("/theme/enroll")
	public String enroll(ThemeDTO dto, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/user/login";
		}

		try {
			themeService.themeInsert(dto);
		} catch (Exception e) {
			log.info("themeInsert : ", e);
		}

		return "redirect:/theme/list";
	}
	 
	
	// 출석체크
	@GetMapping("/attendance")
	public String attendance() {
	    return "owner/attendance";
	}
	
	// 매니저   
	@GetMapping("/manager")
	public String manager() {
	    return "owner/manager";
	}
	
	
}
