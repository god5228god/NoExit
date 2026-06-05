package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.User;
import com.noexit.app.service.CafeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RequiredArgsConstructor
@Slf4j
@Controller
@RequestMapping("/cafe")
public class CafeController {
	
	private final CafeService cafeService;

	//카페 등록
	@GetMapping("/enroll")
	public String enrollForm() {
		return "cafe/cafeEnrollForm";
	}
	//카페 등록
	@PostMapping("/enroll")
	public String enroll(Cafe cafe, HttpSession session) throws Exception {
        User loginUser = (User) session.getAttribute("loginUser");
       
        cafe.setUserId(loginUser.getUserId());  
       
        cafeService.enroll(cafe);
        
        session.setAttribute("role", "OWNER");      
		
		return "redirect:/theme/list";
	}

}
