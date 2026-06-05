package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Common;

@Mapper
public interface CommonMapper {

	public List<Common> getCommonList();

}
