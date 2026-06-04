package com.noexit.app.service;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.AdminMapper;
import com.noexit.app.model.Admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminServiceImpl implements AdminService {

	private final AdminMapper mapper;

	@Override
	public Admin login(Admin admin) {
		Admin result = null;
		try {
			Admin dto = mapper.findByLoginId(admin.getLoginId());
			if (dto != null && dto.getPassword().equals(admin.getPassword())) {
				result = dto;
			}
		} catch (Exception e) {
			log.info("login : ", e);
		}
		return result;
	}

}
