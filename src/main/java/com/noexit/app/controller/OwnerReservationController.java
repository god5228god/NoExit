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
public class OwnerReservationController {

	private final OpenReservationService service;
	
	@GetMapping("/owner/openRes")
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
			
//			
//			// 페이징 처리를 위한 map 구성
//			//-- currentPage, schDate, schCafe
//			Map<String, Object> map = new HashMap<>();
//			map.put("schCafe", schCafe);
//			map.put("schDate", schDate);
//			map.put("currentPage", currentPage);
//						
//			// 로그인한 사용자의 오픈 등록 목록 가져오기(페이징처리해서)
//			//-- list, dataCount, totalPage, paging 
//			Map<String, Object> openList = service.getListPaging(map);
			
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
	public List<OpenReservationDTO> getThemeList(@RequestParam(name="cafeId") long cafeId) {
		return service.getThemeList(cafeId);
		
	}
	
	// 예약 슬롯 오픈 등록 폼에서 넘어와서 등록 처리
	@PostMapping("/owner/openRes/open")
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
	    
		
		//long userId = (long)session.getAttribute("userId");
		
	     long userId = 15L;
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("schCafe", schCafe);
	    map.put("schDate", schDate);
	    
	    return service.getOpenReservationList(map);
	}
	
	
	// 예약 슬롯 비활성화
	@PostMapping("/owner/openRes/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam (name="resOpen") long resOpenId
									, HttpSession session) {
		//long userId = (long)session.getAttribute("userId");
		long userId = 15L;
		
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
			 HttpSession session
			, Model model) {
		

		
		return "owner/resList";
		
	}
	
	
	
}
