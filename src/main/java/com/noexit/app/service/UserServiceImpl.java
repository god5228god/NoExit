package com.noexit.app.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.UserMapper;
import com.noexit.app.model.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper;

	@Override
	@Transactional
	public void enroll(User user) {
		userMapper.insertAccount(user);
		userMapper.insertInfo(user);
	}

	@Override
	public int countByLoginId(String loginId) {
		 return userMapper.countByLoginId(loginId);
	}
}
