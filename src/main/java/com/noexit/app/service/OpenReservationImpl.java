package com.noexit.app.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.noexit.app.common.PaginateUtil;
import com.noexit.app.mapper.OpenReservationMapper;
import com.noexit.app.model.OpenReservationDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class OpenReservationImpl implements OpenReservation {
	
	private final OpenReservationMapper mapper;
	private final PaginateUtil paginateUtil;
	
	
	// 카페 목록 가져오기
	@Override
	public List<OpenReservationDTO> getCafeList(long userId) {

		List<OpenReservationDTO> result = new ArrayList<>();
		
		try {
			result = mapper.getCafeList(userId);
		} catch (Exception e) {
			log.error("getCafeList: ",e);
		}
		
		return result;
	}

	@Override
	public List<OpenReservationDTO> getOpenReservationList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void openReservation(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void dropOpen(long userId, long resOpenId) {
		// TODO Auto-generated method stub
		
	}

	
}
