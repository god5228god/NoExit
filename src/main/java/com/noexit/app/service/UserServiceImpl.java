package com.noexit.app.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.UserMapper;
import com.noexit.app.model.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
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

	@Override
	public User login(User user) {

		User dto = null;

		try {
			dto = userMapper.selectByLoginId(user.getLoginId());

			if (dto != null && ! dto.getPassword().equals(user.getPassword())) {
				dto = null;
			}

		} catch (Exception e) {
			log.info("login : ", e);
		}

		return dto;
	}

	@Override
	public String findRole(Long userId) {

		String role = "USER";

		try {
			int cafeCount = userMapper.countCafeByUserId(userId);
			if (cafeCount > 0) {
				role = "OWNER";
			}
		} catch (Exception e) {
			log.info("findRole : ", e);
		}

		return role;
	}
}
