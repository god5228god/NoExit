package com.noexit.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.MyPage;

@Mapper
public interface MypageMapper {
	
	public List<MyPage> getUserRecord(Map<String, Object> map);
	public List<MyPage> getMutualList(Long userId);	
	public List<String> getQuestionList();	
	public double getUserManner(Long userId);
	public List<MyPage> getRoomImg(Long userId);
	List<MyPage> getUnrecordedList(long userId);
	int insertRecord(MyPage myPage);
	public int getUserRecordCount(Long userId);
}
