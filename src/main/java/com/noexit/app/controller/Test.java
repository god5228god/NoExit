package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.noexit.app.model.User;
import com.noexit.app.service.PartyService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class Test {
	
	private final PartyService service;
	
	@GetMapping("/test")
	public String home() {
		
		return "testCss";
	}
	
	@GetMapping("/mypage/myparty")
	public String myParty(Model model, HttpSession session, RedirectAttributes reModel)
	{
		try
		{
			User user = (User)session.getAttribute("loginUser");
			
			if(user == null)
			{
				return "redirect:/user/login";
			}
			
			long userId = user.getUserId();
			
			model.addAttribute("myPartyList", service.getMyPartyList(userId));
			model.addAttribute("myPartyApplyList", service.getMyPartyApplyList(userId));
			model.addAttribute("myPartyKickList", service.getMyPartyKickList(userId));
			
			return "mypage/myparty";
		}
		catch (Exception e)
		{
			log.info("myParty : ",e);
		}
		
		reModel.addAttribute("errorMsg", "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요");
		return "redirect:/err/error";
	}
}
