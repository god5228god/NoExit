package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noexit.app.model.Admin;
import com.noexit.app.service.AdminService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

	private final AdminService service;

	// 로그인 폼
	@GetMapping("/login")
	public String loginForm() {
		return "admin/adminLoginForm";
	}

	// 로그인 처리
	@PostMapping("/login")
	public String login(Admin admin, HttpSession session, Model model) {

		Admin dto = service.login(admin);

		if (dto == null) {
			model.addAttribute("errorMessage", "아이디 또는 비밀번호가 올바르지 않습니다.");
			return "admin/adminLoginForm";
		}

		session.setAttribute("loginAdmin", dto);
		session.setAttribute("role", "ADMIN");
		return "redirect:/";
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
