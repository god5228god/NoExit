package com.noexit.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.MypageMapper;
import com.noexit.app.model.MyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService{
	
	private final MypageMapper mapper;

	public List<MyPage> getUserRecord(Long userId)
	{
		return mapper.getUserRecord(userId);
	}
	
	
}
