package com.noexit.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.CommonMapper;
import com.noexit.app.model.Common;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommonServiceImpl implements CommonService {

	private final CommonMapper commonMapper;

	@Override
	public List<Common> getCommonList() {
		List<Common> list = null;
		try {
			list = commonMapper.getCommonList();
		} catch (Exception e) {
			log.info("getCommonList : ", e);
		}
		return list;
	}

}
