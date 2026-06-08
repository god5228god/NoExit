package com.noexit.app.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.AttendanceMapper;
import com.noexit.app.model.AttendanceListDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AttendanceServiceImpl implements AttendanceService {

	private final AttendanceMapper mapper;


	@Override
	public List<AttendanceListDTO> selectListByOwnerUserId(Long ownerUserId) {

		List<AttendanceListDTO> list = null;

		try {
			list = mapper.selectListByOwnerUserId(ownerUserId);
		} catch (Exception e) {
			log.info("selectListByOwnerUserId : ", e);
		}

		return list;
	}

	@Override
	public List<AttendanceListDTO> selectListByManagerUserId(Long managerUserId) {

		List<AttendanceListDTO> list = null;

		try {
			list = mapper.selectListByManagerUserId(managerUserId);
		} catch (Exception e) {
			log.info("selectListByManagerUserId : ", e);
		}

		return list;
	}

	@Override
	@Transactional
	public AttendanceListDTO attend(AttendanceListDTO dto) throws Exception {

		try {
			mapper.insertAttendance(dto);
			mapper.insertAttendDetail(dto);

			if (dto.getAttendStatusId() == 2) {
				dto.setStatusName("노쇼 처리 완료");
			} else {
				dto.setStatusName("출석 처리 완료");
			}
		} catch (Exception e) {
			log.info("attend : ", e);
			throw e;
		}

		return dto;
	}

	
	

}
