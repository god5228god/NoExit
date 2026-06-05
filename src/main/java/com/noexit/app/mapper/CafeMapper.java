package com.noexit.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Cafe;

@Mapper
public interface CafeMapper {

	public List<Cafe> selectByUserId(Long userId);
	public void insertCafe(Cafe cafe) throws SQLException;
}
