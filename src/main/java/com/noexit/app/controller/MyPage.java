package com.noexit.app.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MyPage {

	@GetMapping("/mypage/*")
	public String mypage()
	{
		try {
			
			
		} catch (Exception e) {
			
			
		}
		
		return "/mypage/record";
	}
	
	
}
