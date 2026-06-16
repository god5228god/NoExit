package com.noexit.app.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.noexit.app.model.PopularThemeDTO;
import com.noexit.app.model.RecentPartyDTO;
import com.noexit.app.service.MainService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {
	
	private final MainService service;

	@GetMapping("/")
	public String main(Model model) {
		
		try {
			List<PopularThemeDTO> themeList = service.popularThemeList();
			List<RecentPartyDTO> partyList = service.recentPartyList();
			
			model.addAttribute("themeList", themeList);
			model.addAttribute("partyList", partyList);
			
		} catch (Exception e) {
			log.error("main: ",e);
		}
		
		return "main";
		
	}
}
