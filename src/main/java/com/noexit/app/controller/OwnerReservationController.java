package com.noexit.app.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.noexit.app.model.CafeReservationDTO;
import com.noexit.app.model.OpenReservationDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.CafeReservationService;
import com.noexit.app.service.MyReservationService;
import com.noexit.app.service.OpenReservationService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class OwnerReservationController {

	private final OpenReservationService service;
	private final CafeReservationService cafeService;
	private final MyReservationService myService;
	
	@GetMapping("/owner/openRes")
	public String openRes(@RequestParam(name="page", defaultValue="1") int currentPage
			, @RequestParam(name="schCafe", required=false) Long schCafe
			, @RequestParam(name="schDate", required=false) String schDate
			, HttpSession session
			, Model model) {
		
		// 세션에서 userId 받아오기
		//Long userId = (Long) session.getAttribute("userId");
		//Long userId = 15L;
		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
		
		
		try {
			
			// 로그인한 사용자의 카페 목록 가져오기
			List<OpenReservationDTO> cafeList = service.getCafeList(userId);

			// 첫 진입시 
			// 오늘날짜 담아주기 YYYY-MM-DD 형태의 문자열로 출력
			if(schDate==null) {
				schDate = LocalDate.now().toString();
			}
			
			
			// 로그인한 사용자의 오픈 등록 목록 가져오기(페이징x)
			//-- userId, schCafe, schDate
			Map<String, Object> map = new HashMap<>();
			map.put("schCafe", schCafe);
			map.put("schDate", schDate);
			map.put("userId", userId);
			
			List<OpenReservationDTO> openList = service.getOpenReservationList(map);
			
			
			model.addAttribute("schDate", schDate);
			model.addAttribute("cafeList", cafeList);
			model.addAttribute("openList", openList);
			model.addAttribute("minDate", LocalDate.now().plusDays(1).toString());
			
		} catch (Exception e) {
			log.error("openRes: ", e);
		}
		
		return "owner/openRes";
		
	}
	
	// AJAX 연동을 위한 테마 목록 조회
	@GetMapping("/owner/openRes/theme")
	@ResponseBody
	public List<OpenReservationDTO> getThemeList(@RequestParam(name="cafeId") Long cafeId) {
		return service.getThemeList(cafeId);
		
	}
	
	// 예약 슬롯 오픈 등록 폼에서 넘어와서 등록 처리
	@PostMapping("/owner/openRes/open")
	@ResponseBody
	public Map<String, Object> open(@RequestParam(name="cafe") Long cafeId
			, @RequestParam(name="theme") Long roomId
			, @RequestParam(name="date") String openDate
			, @RequestParam(name="hour") String hour
			, @RequestParam(name="min") String min
			, HttpSession session) {
	
		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
		
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			
			String openAtStr = openDate+" "+hour+":"+min;
			
			// 문자열을 Date 타입으로 변환
			SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date openAt = dFormat.parse(openAtStr);
			
			// 예약 오픈 등록 처리를 위한 map 구성
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("cafeId", cafeId);
			map.put("roomId", roomId);
			map.put("openAt", openAt);
			
			service.openReservation(map);
			
			// AJAX로 넘어갈 성공과 메시지 담기
			result.put("success", true);
			result.put("message", "예약 슬롯이 등록되었습니다.");
			
		
			//런타임 예외 모든 SQLException을 DataAccessException에 담아 던짐
			// 스프링에서 DB 관련 Exception은 DataAccessException사용
		} catch (DataAccessException e) {
			
		   String fullMsg = e.getCause().getMessage();
		   String msg = fullMsg.split("\n")[0];  // 첫 줄만
		   msg = msg.replaceAll("ORA-\\d+: ", "").trim();
			
			result.put("success", false);
			result.put("message", msg);
		}
		
		catch (Exception e) {
			result.put("success", false);
			result.put("message", "오류가 발생했습니다.");
			log.error("open: ", e);
		}
		
		
		return result;
	}
	
	// 등록 목록 조회
	@GetMapping("/owner/openRes/list")
	@ResponseBody
	public List<OpenReservationDTO> getList(
	        @RequestParam(name="schCafe", required=false) Long schCafe,
	        @RequestParam(name="schDate") String schDate,
	        HttpSession session) {
	    

		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
		
	     //Long userId = 15L;
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("schCafe", schCafe);
	    map.put("schDate", schDate);
	    
	    return service.getOpenReservationList(map);
	}
	
	
	// 예약 슬롯 비활성화
	@PostMapping("/owner/openRes/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam (name="resOpen") Long resOpenId
									, HttpSession session) {

		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
		
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			service.dropOpen(userId, resOpenId);
			result.put("success", true);
			result.put("message", "정상적으로 삭제되었습니다.");
			
		} catch (DataAccessException e) {
			
			   String fullMsg = e.getCause().getMessage();
			   String msg = fullMsg.split("\n")[0];  // 첫 줄만
			   msg = msg.replaceAll("ORA-\\d+: ", "").trim();
				
				result.put("success", false);
				result.put("message", msg);
		}catch (Exception e) {
			result.put("success", false);
			result.put("message", "오류가 발생했습니다.");
			log.error("delete: ",e);
		}
		
		return result;
		
	}
	
	

	@GetMapping("/owner/resList")
	public String resList(
			@RequestParam(name="schDate", required = false) String schDate
			, @RequestParam(name = "schCafe", required = false) Long cafeId
			, @RequestParam(name="schTheme", required = false) Long roomId
			, HttpSession session
			, Model model) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
		
		try {
			
			// 로그인한 사용자의 카페 목록 가져오기
			List<OpenReservationDTO> cafeList = service.getCafeList(userId);

			// cafeId 없으면 첫 번째 카페로 세팅
			if (cafeId == null && !cafeList.isEmpty()) {
			    cafeId = cafeList.get(0).getCafeId();
			}
			
			// 첫 진입시 
			// 오늘날짜 담아주기 YYYY-MM-DD 형태의 문자열로 출력
			if(schDate==null) {
				schDate = LocalDate.now().toString();
			}
			
			// 로그인한 사용자의 예약 현황 목록 가져오기
			//-- userId, schDate, cafeId, userId, offset, limit
			int offset = 0;
			int limit = 10;
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("openAt", schDate);
			map.put("cafeId", cafeId);
			if(roomId!=null)
				map.put("roomId", roomId);
			map.put("offset", offset);
			map.put("limit", limit);
			
			List<CafeReservationDTO> resList = cafeService.resList(map);
			
			model.addAttribute("schDate", schDate);
			model.addAttribute("cafeList", cafeList);
			model.addAttribute("resList", resList);
			
			
			
		} catch (Exception e) {
			log.error("resList: ",e );
		}

		
		return "owner/resList";
		
	}
	
	// 예약 현황 목록 조회 AJAX 엔드포인드
	@GetMapping("/owner/resList/list")
	@ResponseBody
	public List<CafeReservationDTO> getResList(
	        @RequestParam(name="schDate") String schDate,
	        @RequestParam(name="cafeId") Long cafeId,
	        @RequestParam(name="roomId", required=false) Long roomId,
	        @RequestParam(name="offset", defaultValue="0") int offset,
	        HttpSession session) {

		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();


	    Map<String, Object> map = new HashMap<>();
	    try {
	    	map.put("userId", userId);
	    	map.put("openAt", schDate);
	    	map.put("cafeId", cafeId);
	    	if(roomId != null) 
	    		map.put("roomId", roomId);
	    	map.put("offset", offset);
	    	map.put("limit", 3);
			
		} catch (Exception e) {
			log.error("getResList: ",e);
		}
	    
	    return cafeService.resList(map);
	}
	
	
	// 예약 상세 목록 조회 AJAX 엔드 포인트
	@PostMapping("/owner/resList/detail")
	@ResponseBody
	public CafeReservationDTO getDetail(
			@RequestParam(name="resId") Long resId){
		
		
		CafeReservationDTO result = new CafeReservationDTO();
		try {
			result = cafeService.resDetail(resId);
			
		} catch (Exception e) {
			log.error("getDetail: ",e);
		}
		return result;
		
	}
	
	// 예약 취소 AJAX 엔드포인트
	@PostMapping("/owner/resList/delete")
	@ResponseBody
	public Map<String, Object> resDelete(
			@RequestParam(name="resId") Long resId
			, HttpSession session){
		
		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();

		Map<String, Object> result = new HashMap<>();
		
		try {
			
			myService.cancelReservation(resId, userId);
			result.put("success", true);
			result.put("message", "예약이 성공적으로 취소되었습니다.");
			
		} catch (DataAccessException e) {
			
		   String fullMsg = e.getCause().getMessage();
		   String msg = fullMsg.split("\n")[0];  // 첫 줄만
		   msg = msg.replaceAll("ORA-\\d+: ", "").trim();
					
			result.put("success", false);
			result.put("message", msg);
		}		
		catch (Exception e) {
			result.put("success", false);
			result.put("message", "오류가 발생했습니다.");
			log.error("resDelete: ", e);
		}
		
		return result;
		
	}
	
	
	
}
