package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class OwnerResvation {

	@GetMapping("/openRes")
	public String openRes(
			HttpSession session
			, Model model) {
		
		// 세션에서 userId 받아오기
		//long userId = (long) session.getAttribute("userId");
		
		long userId = 5L;

		try {
			
			// 로그인한 사용자의 카페 목록 가져오기
			
			// 로그인한 사용자의 오픈 등록 목록 가져오기
			
			
			
			
		} catch (Exception e) {
			log.error("openRes: ", e);
		}
		
		
		return "owner/openRes";
		
	}
	
	
}
