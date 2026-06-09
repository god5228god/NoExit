package com.noexit.app.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.noexit.app.model.User;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MyPageController {

	@GetMapping("/mypage/*")
	public String mypage(HttpSession session, Model model)
	{
		// 세션 검증 
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 세션 만료 시 로그인 페이지 리다이렉트
		if (session == null || session.getAttribute("loginUser") == null)
		{
			return "redirect:/user/login";
		}
		
		// 로그인 유저 정보 넘기기
		model.addAttribute("USER", loginUser);
		
		// 마이페이지로 리턴
		return "/mypage/record";
	}
	
	
}
