package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.MypageMapper;
import com.noexit.app.model.MyPage;
import com.noexit.app.model.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService{
	
	private final MypageMapper mapper;
	

	@Override
	public List<MyPage> getUserRecord(Map<String, Object> map)
	{
		return mapper.getUserRecord(map);
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
	public List<MyPage> getUnrecordedList(long userId) 
	{
		return mapper.getUnrecordedList(userId);
	}
	
	
	@Override
	public int insertRecord(MyPage myPage) {
        return mapper.insertRecord(myPage);
    }


	@Override
	public int getUserRecordCount(Long userId) {
		return mapper.getUserRecordCount(userId);
	}
	
	@Override
	public int updateRecord(MyPage myPage) {
		return mapper.updateRecord(myPage);
	}
	
	
	@Override
	public int insertReview(MyPage myPage) {
		
		int reviewCount = mapper.countReview(myPage.getDetailId());
		
		if (reviewCount > 0)
			return mapper.updateReview(myPage);
		else 
			return mapper.insertReview(myPage);
	}
	
	@Override
	public int deleteReview(Long reviewId) {
		return mapper.deleteReview(reviewId);
		
	}
	
	@Override
	public List<MyPage> getReservationList(Long userId)
	{
	    return mapper.getReservationList(userId);
	}

	@Override
	public List<MyPage> getReservationDetail(Map<String, Object> map)
	{
	    return mapper.getReservationDetail(map);
	}
	
	
}
