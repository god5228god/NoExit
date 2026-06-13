package com.noexit.app.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.noexit.app.model.ReservationDTO;
import com.noexit.app.model.User;
import com.noexit.app.service.ReservationService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor 
public class ReservationController {
	
	private final ReservationService service;
	
	@GetMapping("/reservation")
	public String reserveForm(@RequestParam(name="party", required=false) Long partyId
			, HttpSession session, Model model) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
		
		
		try {
			
			ReservationDTO bookerInfo = service.findBooker(userId, partyId);
			
			model.addAttribute("bookerInfo", bookerInfo);
			
		} catch (Exception e) {
			log.error("reserveForm: ",e );
		}
		
		
		return "reserve/reservation";
	}
	
	@PostMapping("/reservation/action")
	@ResponseBody
	public Map<String, Object> createRes(@RequestParam(name="partyId") Long partyId
			, HttpSession session) {
		
		User loginUser = (User) session.getAttribute("loginUser");
		Long userId = loginUser.getUserId();
				
		
		Map<String, Object> result = new HashMap<>();
		try {
			
			service.createReservation(userId, partyId);
			result.put("success", true);
			result.put("message", "성공적으로 예약이 되었습니다.");
			
		} catch (DataAccessException e) {
			String fullMsg = e.getCause().getMessage();
			String msg = fullMsg.split("\n")[0]; 
			msg = msg.replaceAll("ORA-\\d+: ", "").trim();
						
			result.put("success", false);
			result.put("message", msg);
			
		} catch (Exception e) {
			result.put("success", false);
			result.put("message", "오류가 발생했습니다.");
			log.error("resDelete: ", e);
		}
		
		return result;
		
	}
	
	
	
}
