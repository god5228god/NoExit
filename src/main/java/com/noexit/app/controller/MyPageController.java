package com.noexit.app.controller;


import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.noexit.app.model.MyPage;
import com.noexit.app.model.User;
import com.noexit.app.service.AdminService;
import com.noexit.app.service.MyPageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MyPageController {

	// 서비스 주입
	private final MyPageService service;

	@GetMapping("/mypage/*")
	public String mypage(HttpSession session, Model model)
	{
		// 세션 검증 
		User loginUser = (User) session.getAttribute("loginUser");
		
		// 세션 만료 시 로그인 페이지 리다이렉트
		if (loginUser == null || session.getAttribute("loginUser") == null)
		{
			return "redirect:/user/login";
		}
		
		
		List<MyPage> recordList = service.getUserRecord(loginUser.getUserId());
		List<MyPage> mutualList = service.getMutualList(loginUser.getUserId());
		List<String> questionList = service.getQuestionList();
		
		
		// 로그인 유저 정보 넘기기
		model.addAttribute("USER", loginUser);
		model.addAttribute("recordList", recordList);
		model.addAttribute("mutualList", mutualList);
		model.addAttribute("questionList", questionList);
		
		// 마이페이지로 리턴
		return "/mypage/record";
	}
	
	
}
