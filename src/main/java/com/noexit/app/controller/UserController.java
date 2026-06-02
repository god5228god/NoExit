package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

//import com.noexit.app.model.User;
//import com.noexit.app.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

	//private final UserService service;

	// 아이디 찾기 폼
	@GetMapping("/findId")
	public String findIdForm() {
		return "user/findId";
	}

	// 비밀번호 찾기 폼
	@GetMapping("/findPw")
	public String findPwForm() {
		return "user/findPw";
	}

	// 회원가입 폼 화면 (GET)
	@GetMapping("/enroll")
	public String enrollForm() {
		return "user/enrollForm";
	}

	// 회원가입 처리 (POST)
	@PostMapping("/enroll")
	public String enroll(/* User user */) {
		try {
			//service.enroll(user);
		} catch (Exception e) {
			log.info("enroll : ", e);
		}
		return "redirect:/user/login";
	}

	// 로그인 폼 화면 (GET)
	@GetMapping("/login")
	public String loginForm() {
		return "user/loginForm";
	}

	// 로그인 처리 (POST)
	@PostMapping("/login")
	public String login() {
		return "redirect:/main";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout() {
		return "redirect:/user/login";
	}

}
