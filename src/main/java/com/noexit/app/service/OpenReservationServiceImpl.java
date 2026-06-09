package com.noexit.app.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.noexit.app.mapper.OpenReservationMapper;
import com.noexit.app.model.OpenReservationDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class OpenReservationServiceImpl implements OpenReservationService {
	
	private final OpenReservationMapper mapper;
	
	
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
	public List<OpenReservationDTO> getThemeList(long cafeId) {
		
		List<OpenReservationDTO> result = new ArrayList<>();
		
		try {
		
			result = mapper.getThemeList(cafeId);
			
		} catch (Exception e) {
			log.error("getThemeList: ",e);
		}
		
		return result;
	}


	@Override
	public List<OpenReservationDTO> getOpenReservationList(Map<String, Object> map) {
		
		List<OpenReservationDTO> result = new ArrayList<>();
		
		try {
			
			result = mapper.getOpenReservationList(map);
			
		} catch (Exception e) {
			log.error("getOpenReservationList: ", e);
		}
		
		return result;
	}

	@Override
	public void openReservation(Map<String, Object> map) throws Exception {
			
		try {
			
			mapper.openReservation(map);
			
			
		} catch (Exception e) {
			log.error("openReservation: ", e);
			throw e;
		}
	}

	@Override
	public void dropOpen(long userId, long resOpenId) throws Exception {
		try {
						
			mapper.dropOpen(userId, resOpenId);
			
		} catch (Exception e) {
			log.error("dropOpen: ", e);
			throw e;
		}
	}

	
// 페이징 처리 안하면 삭제 	
//	@Override
//	public Map<String, Object> getListPaging(Map<String, Object> map) {
//		
//		Map<String, Object> result = new HashMap<>();
//		
//		try {
//			
//			int totalPage = 0 ;
//			int dataCount = 0;
//			int size = 10;
//			
//			int currentPage = (int) map.get("currentPage");
//			
//			// 전체 페이지 수 
//			dataCount = mapper.dataCount(map);
//			
//			if(dataCount!=0)
//				totalPage = paginateUtil.pageCount(dataCount, size);
//			
//			// 리스트에 출력할 데이터 가져오기
//			int offset = (currentPage - 1) * size;
//			if(offset<0)
//				offset = 0;
//			
//			map.put("offset", offset);
//			map.put("size", size);
//			
//			// 목록 조회
//			List<OpenReservationDTO> list = getOpenReservationList(map);
//			
//			// 페이징 url 
//			String schDate = (String) map.get("schDate");
//			Long schCafe = (Long) map.get("schCafe");
//			
//			String listUrl = "/openRes?schDate="+schDate
//					+ (schCafe != null ? "&schCafe="+schCafe : "" );
//			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);
//			
//			result.put("list", list);
//			result.put("dataCount", dataCount);
//			result.put("totalPage", totalPage);
//			result.put("paging", paging);
//	
//			
//		} catch (Exception e) {
//			log.error("getListPaging: ",e);
//		}
//		
//		
//		return result;
//	}
//
//	@Override
//	public int dataCount(Map<String, Object> map) {
//		
//		int result = 0;
//		
//		try {
//			
//			result = mapper.dataCount(map);
//			
//		} catch (Exception e) {
//			log.error("dataCount: ", e);
//		}
//		
//		return result;
//	}

	
}






























