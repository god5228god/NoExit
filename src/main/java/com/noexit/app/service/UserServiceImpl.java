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
	private final ManagerService managerService;

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
			dto = userMapper.selectByLoginId(user);


		} catch (Exception e) {
			log.info("login : ", e);
		}

		return dto;
	}

	@Override
	public User selectByLoginId(String loginId) {
		User dto = null;
		try {
			dto = userMapper.findByLoginId(loginId);
		} catch (Exception e) {
			log.info("selectByLoginId : ", e);
		}
		return dto;
	}

	@Override
	public String findRole(Long userId) {

		try {
			if (userMapper.countCafeByUserId(userId) > 0)       
				return "OWNER";
			if (managerService.countActiveByUserId(userId) > 0)  return 
					"MANAGER";
		} catch (Exception e) {
			log.info("findRole : ", e);
		}

		return "USER";
	}
	
	@Override
	public User findByNameAndEmail(String name, String email) {

	    User dto = null;

	    try {
	        dto = userMapper.findByNameAndEmail(name, email);
	    } catch (Exception e) {
	        log.info("findByNameAndEmail : ", e);
	    }

	    return dto;
	}
}

