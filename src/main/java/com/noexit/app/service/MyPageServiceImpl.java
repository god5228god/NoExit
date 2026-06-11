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
	

	@Override
	public List<MyPage> getUserRecord(Long userId)
	{
		return mapper.getUserRecord(userId);
	}

	
	@Override
	public List<MyPage> getMutualList(Long userId) 
	{
		
		return mapper.getMutualList(userId);
	}


	@Override
	public List<String> getQuestionList() 
	{

		
		return mapper.getQuestionList();
	}
	
	
	
	@Override
	public double getUserManner(Long userId)
	{
		
		return mapper.getUserManner(userId);
		
	}
	
	@Override
	public List<MyPage> getRoomImg(Long userId) 
	{
		return mapper.getRoomImg(userId);
	}
	
	@Override
	public List<MyPage> getUnrecordedList(Long userId)
	{
		return mapper.getUnrecordedList(userId);
	}
	
	
	
	
	
}
