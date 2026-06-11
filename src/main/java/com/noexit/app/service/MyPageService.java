package com.noexit.app.service;

import java.util.List;
import java.util.Map;

import com.noexit.app.model.MyPage;

public interface MyPageService {
	
	public List<MyPage> getUserRecord(Long userId);
	public List<MyPage> getMutualList(Long userId);
	public List<String> getQuestionList();
	public double getUserManner(Long userId);
	
	public List<MyPage> getRoomImg(Long userId);
	List<MyPage> getUnrecordedList(long userId);
	public int insertRecord(MyPage myPage);
	
}
