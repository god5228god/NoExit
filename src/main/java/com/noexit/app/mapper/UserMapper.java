package com.noexit.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.User;

@Mapper
public interface UserMapper {

	public int insertAccount(User user);
	public int insertInfo(User user);
	public int countByLoginId(String loginId); // 중복확인
	public User selectByLoginId(User user);
	public int countCafeByUserId(Long userId);

}
