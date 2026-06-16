package com.noexit.app.service;

import java.util.Random;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.UserMapper;
import com.noexit.app.model.User;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

	private final UserMapper userMapper;
	private final ManagerService managerService;
	private final MailService mailService;

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
	public int countByEmail(String email) {
		 return userMapper.countByEmail(email);
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
	public User findByLoginId(String loginId) {
		User dto = null;
		try {
			dto = userMapper.findByLoginId(loginId);
		} catch (Exception e) {
			log.info("findByLoginId : ", e);
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
	public User findByNameAndEmail(User user) {

	    User dto = null;

	    try {
	        dto = userMapper.findByNameAndEmail(user);
	    } catch (Exception e) {
	        log.info("findByNameAndEmail : ", e);
	    }

	    return dto;
	}


	// 비밀번호 찾기 인증번호 발송
	@Override
	public boolean sendAuthCode(String loginId, String name, HttpSession session) {

		try {
			User param = new User();
			param.setLoginId(loginId);
			param.setName(name);

			User dto = userMapper.findByLoginIdAndName(param);
			if (dto == null) return false;

			// 6자리 인증번호
			String authCode = String.valueOf(100000 + new Random().nextInt(900000));

			session.setAttribute("authCode", authCode);
			session.setAttribute("authCodeLoginId", loginId);

			mailService.sendAuthCodeMail(dto.getEmail(), authCode);
			return true;

		} catch (Exception e) {
			log.info("sendAuthCode : ", e);
			return false;
		}
	}


	// 인증번호 검증
	@Override
	public boolean verifyAuthCode(String loginId, String authCode, HttpSession session) {

		String savedCode = (String) session.getAttribute("authCode");
		String savedLoginId = (String) session.getAttribute("authCodeLoginId");

		if (savedCode == null || savedLoginId == null) return false;
		if (!savedLoginId.equals(loginId)) return false;
		if (!savedCode.equals(authCode)) return false;

		session.setAttribute("authCodeVerified", true);
		return true;
	}


	// 비밀번호 변경
	@Override
	public int resetPassword(String loginId, String newPassword, HttpSession session) {

		Boolean verified = (Boolean) session.getAttribute("authCodeVerified");
		String savedLoginId = (String) session.getAttribute("authCodeLoginId");

		if (verified == null || !verified) return 0;
		if (savedLoginId == null || !savedLoginId.equals(loginId)) return 0;

		int result = 0;

		try {
			User dto = userMapper.findByLoginId(loginId);
			if (dto == null) return 0;

			dto.setPassword(newPassword);
			result = userMapper.updatePassword(dto);

			// 세션 정리
			session.removeAttribute("authCode");
			session.removeAttribute("authCodeLoginId");
			session.removeAttribute("authCodeVerified");

		} catch (Exception e) {
			log.info("resetPassword : ", e);
		}

		return result;
	}

	// 회원탈퇴
	@Override
	@Transactional
	public void withdraw(Long userId) {
		try {
			userMapper.insertUserDrop(userId);
			userMapper.deleteUserInfo(userId);
		} catch (Exception e) {
			log.info("withdraw : ", e);
			throw e;
		}
	}

	@Override
	public boolean verifyPassword(Long userId, String password) {
		int count = 0;
		try {
			User param = new User();
			param.setUserId(userId);
			param.setPassword(password);
			count = userMapper.countByUserIdAndPassword(param);
		} catch (Exception e) {
			log.info("verifyPassword : ", e);
		}
		return count > 0;
	}
}

