package com.noexit.app.service;

import com.noexit.app.model.User;


public interface UserService {

	public void enroll(User user);
	public int countByLoginId(String loginId); // 중복 확인
	public User login(User user);
	public String findRole(Long userId);
}
