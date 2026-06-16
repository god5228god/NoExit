package com.noexit.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.Cafe;
import com.noexit.app.model.CafeDropReason;

@Mapper
public interface CafeMapper {

	public List<Cafe> selectByUserId(Long userId);
	public void insertCafe(Cafe cafe) throws SQLException;
	
	//카페 삭제
	public List<CafeDropReason> selectDropReasonList();   
	public Cafe selectByCafeId(Long cafeId);              
	public void insertCafeDrop(Cafe cafe) throws SQLException;  
}
