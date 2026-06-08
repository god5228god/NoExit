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

import com.noexit.app.model.OpenReservationDTO;
import com.noexit.app.service.OpenReservationService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class OwnerReservation {

	private final OpenReservationService service;
	
	@GetMapping("/openRes")
	public String openRes(@RequestParam(name="page", defaultValue="1") int currentPage
			, @RequestParam(name="schCafe", required=false) Long schCafe
			, @RequestParam(name="schDate", required=false) String schDate
			, HttpSession session
			, Model model) {
		
		// 세션에서 userId 받아오기
		//long userId = (long) session.getAttribute("userId");
		
		long userId = 15L;

		try {
			
			// 로그인한 사용자의 카페 목록 가져오기
			List<OpenReservationDTO> cafeList = service.getCafeList(userId);
			

			if(schDate==null) {
				schDate = LocalDate.now().toString();
			}
			model.addAttribute("schDate", schDate);
			
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("schCafe", schCafe);
			map.put("schDate", schDate);
			map.put("currentPage", currentPage);
						
			// 로그인한 사용자의 오픈 등록 목록 가져오기
			Map<String, Object> openList = service.getListPaging(map);
			log.info("schDate: {}", schDate);
			log.info("openList: {}", openList);
			
			model.addAttribute("cafeList", cafeList);
			model.addAttribute("openList", openList);
			
		} catch (Exception e) {
			log.error("openRes: ", e);
		}
		
		return "owner/openRes";
		
	}
	
	@GetMapping("/openRes/theme")
	@ResponseBody
	public List<OpenReservationDTO> getThemeList(@RequestParam(name="cafeId") long cafeId) {
		return service.getThemeList(cafeId);
		
	}
	
	@PostMapping("/openRes/open")
	@ResponseBody
	public Map<String, Object> open(@RequestParam(name="cafe") long cafeId
			, @RequestParam(name="theme") long roomId
			, @RequestParam(name="date") String openDate
			, @RequestParam(name="hour") String hour
			, @RequestParam(name="min") String min
			, HttpSession session) {
	
		long userId = 15L;
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			
			String openAtStr = openDate+" "+hour+":"+min;
			
			SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date openAt = dFormat.parse(openAtStr);
			
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("cafeId", cafeId);
			map.put("roomId", roomId);
			map.put("openAt", openAt);
			
			service.openReservation(map);
			
			result.put("success", true);
			result.put("message", "예약 슬롯이 등록되었습니다.");
			
			
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
	
	@GetMapping("/openRes/list")
	@ResponseBody
	public List<OpenReservationDTO> getList(
	        @RequestParam(name="schCafe", required=false) Long schCafe,
	        @RequestParam(name="schDate") String schDate,
	        HttpSession session) {
	    
	    long userId = 15L;
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("schCafe", schCafe);
	    map.put("schDate", schDate);
	    
	    return service.getOpenReservationList(map);
	}
	
	
}
