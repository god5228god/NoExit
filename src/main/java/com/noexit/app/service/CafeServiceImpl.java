package com.noexit.app.service;



import java.util.List;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.CafeMapper;
import com.noexit.app.model.Cafe;
import com.noexit.app.model.CafeDropReason;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CafeServiceImpl implements CafeService  {

	private final CafeMapper cafeMapper;

    @Override
    public void enroll(Cafe cafe) throws Exception {
    	try {
    		cafeMapper.insertCafe(cafe);
		} catch (Exception e) {
			log.info("enroll : " , e);
			throw e;
		}
    }

	@Override
	public List<Cafe> selectByUserId(Long userId) {
		List<Cafe> list = null;
		try {
			list = cafeMapper.selectByUserId(userId);
		} catch (Exception e) {
			log.info("selectByUserId : ", e);
		}
		return list;
	}
	
	@Override
	public List<CafeDropReason> getDropReasonList() {
		List<CafeDropReason> list = null;
		try {
			list = cafeMapper.selectDropReasonList();
		} catch (Exception e) {
			log.info("getDropReasonList : ", e);
		}
		return list;
	}

	@Override
	public void cafeDrop(Cafe cafe, Long loginUserId) throws Exception {
		try {
			cafe.setUserId(loginUserId);
			cafeMapper.insertCafeDrop(cafe);
		} catch (Exception e) {
			log.info("cafeDrop : ", e);
			throw e;
		}
	}


}
