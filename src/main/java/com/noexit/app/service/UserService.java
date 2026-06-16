package com.noexit.app.service;

import com.noexit.app.model.User;

import jakarta.servlet.http.HttpSession;


public interface UserService {

	public void enroll(User user);
	public int countByLoginId(String loginId); // 중복 확인
	public int countByEmail(String email); // 이메일 중복 확인
	public User login(User user);
	public String findRole(Long userId);
	public User findByLoginId(String loginId);
	public User findByNameAndEmail(User user);

	// 비밀번호 찾기 인증번호 발송
	public boolean sendAuthCode(String loginId, String name, HttpSession session);

	// 인증번호 검증
	public boolean verifyAuthCode(String loginId, String authCode, HttpSession session);

	// 비밀번호 변경
	public int resetPassword(String loginId, String newPassword, HttpSession session);

	// 회원탈퇴
	public void withdraw(Long userId);
	public boolean verifyPassword(Long userId, String password);
}
