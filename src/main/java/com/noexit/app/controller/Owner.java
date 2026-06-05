package com.noexit.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noexit.app.mapper.CafeMapper;
import com.noexit.app.model.Cafe;
import com.noexit.app.model.User;
import com.noexit.app.service.CafeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/owner/*")
public class Owner {
	
	private final CafeService cafeService; 
	
	
	@GetMapping("/res/open")
	public String openReserv() {
	
		return "owner/openRes";
		
	}
	
	@GetMapping("/res/list")
	public String resList() {
	
		return "owner/resList";
		
	}
	
	// 테마 등록
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
		
		return "theme/themeEnrollForm";
	}
	
	/*
	  @PostMapping("/theme/enroll") {
	  public String enroll(Theme theme, HttpSession session) throws Exception {	  
        User loginUser = (User) session.getAttribute("loginUser");
       
        theme.setUserId(loginUser.getUserId());  
       
        themeService.enroll(theme);
        
        session.setAttribute("role", "OWNER");
        
        return "redirect:/theme";
	  }
	*/
	 
	
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
