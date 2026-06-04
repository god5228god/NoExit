package com.noexit.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Cafe;

@Mapper
public interface CafeMapper {

	List<Cafe> selectByUserId(Long userId);

}
