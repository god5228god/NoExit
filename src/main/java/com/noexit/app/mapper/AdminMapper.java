package com.noexit.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Admin;

@Mapper
public interface AdminMapper {
	
	Admin findByLoginId(String loginId);

}
