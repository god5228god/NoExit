package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

	@GetMapping("/findid")
	public String findIdForm() {
		
		return "user/findId";
	}
	
	@GetMapping("/findpw")
	public String findPwForm() {
	
		return "user/findPw";
	}
	
	
	
}
