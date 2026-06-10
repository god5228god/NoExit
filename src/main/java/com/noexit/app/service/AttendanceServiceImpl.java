package com.noexit.app.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noexit.app.mapper.AttendanceMapper;
import com.noexit.app.model.AttendanceListDTO;
import com.noexit.app.model.AttendCrew;

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
	public List<AttendCrew> selectCrewByReservationId(Long reservationId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void attendAll(List<AttendanceListDTO> list, Long staffUserId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean isCheckable(Long reservationId) {
		// TODO Auto-generated method stub
		return false;
	}


	
	

}
