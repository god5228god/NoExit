package com.noexit.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.Manner;

@Mapper
public interface AttendanceMapper {

	public void insertNoshow(Manner manner) throws SQLException;

	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId);
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId);

	public void insertAttendance(AttendanceListDTO dto) throws SQLException;
	public void insertAttendDetail(AttendanceListDTO dto) throws SQLException;
}
