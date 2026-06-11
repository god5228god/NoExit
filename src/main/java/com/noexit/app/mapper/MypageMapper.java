package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.MyPage;

@Mapper
public interface MypageMapper {
	
	public List<MyPage> getUserRecord(Long userId);
	public List<MyPage> getMutualList(Long userId);	
	public List<String> getQuestionList();	
	public double getUserManner(Long userId);
	public List<MyPage> getRoomImg(Long userId);
	public List<MyPage> getUnrecordedList(Long userId);
}
