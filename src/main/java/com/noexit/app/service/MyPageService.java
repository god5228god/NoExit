package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import com.noexit.app.model.MyPage;
import com.noexit.app.model.User;

public interface MyPageService {
	
	List<MyPage> getUserRecord(Map<String, Object> map);
	public List<MyPage> getMutualList(Long userId);
	public List<String> getQuestionList();
	public double getUserManner(Long userId);
	
	public List<MyPage> getRoomImg(Long userId);
	List<MyPage> getUnrecordedList(long userId);
	public int insertRecord(MyPage myPage);
	public int getUserRecordCount(Long userId);
	int updateRecord(MyPage myPage);
	int insertReview(MyPage myPage);
	int deleteReview(Long reviewId);
	
	
	
}
