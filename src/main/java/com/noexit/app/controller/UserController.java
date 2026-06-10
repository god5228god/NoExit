package com.noexit.app.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noexit.app.model.User;
import com.noexit.app.service.MailService;
import com.noexit.app.service.UserService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

	private final UserService service;
	private final MailService mailService;

	 // 아이디 중복확인 (Ajax)
	 @PostMapping("/id-check")
	 public void idCheck(User user, HttpServletResponse response) throws IOException {
	     int count = service.countByLoginId(user.getLoginId());
	     response.setContentType("text/html; charset=UTF-8");
	     response.getWriter().print(count == 0 ? "OK" : "NO");
	  }
	
	
	// 아이디 찾기 폼
	@GetMapping("/findId")
	public String findIdForm() {
		return "user/findId";
	}
	
	@PostMapping("/findId")
	public void findId(String name ,String email ,HttpServletResponse response) throws IOException {

		 System.out.println("1. 컨트롤러 진입");
	    User user = service.findByNameAndEmail(name, email);

	    response.setContentType("text/plain;charset=UTF-8");

	    if(user == null) {
	        response.getWriter().print("NOT_FOUND");
	        return;
	    }

	    mailService.sendUserIdMail(user.getEmail(), user.getLoginId());

	    response.getWriter().print("SUCCESS");
	}
	
	

	// 비밀번호 찾기 폼
	@GetMapping("/findPw")
	public String findPwForm() {
		return "user/findPw";
	}

	// 회원가입 폼
	@GetMapping("/enroll")
	public String enrollForm() {
		return "user/enrollForm";
	}

	// 회원가입 처리
	@PostMapping("/enroll")
	public String enroll(User user) {
		try {
			service.enroll(user);
		} catch (Exception e) {
			log.info("enroll : ", e);
		}
		return "redirect:/theme/list";
	}

	// 로그인 폼
	@GetMapping("/login")
	public String loginForm() {
		return "user/loginForm";
	}

	// 로그인 처리
	@PostMapping("/login")
	public String login(User user, HttpSession session, Model model) {

	    User dto = null;
	    try {
	        dto = service.login(user);
	    } catch (Exception e) {
	        log.info("login : ", e);
	    }

	    if (dto == null) {
	        model.addAttribute("errorMessage", "아이디 또는 비밀번호가 올바르지 않습니다.");
	        return "user/loginForm";
	    }

	    String role = service.findRole(dto.getUserId());
	    session.setAttribute("loginUser", dto);
	    session.setAttribute("role", role);
	    return "redirect:/theme/list";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/user/login";
	}

}
