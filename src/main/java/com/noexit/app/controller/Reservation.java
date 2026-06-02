package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor 
@RequestMapping("/reserve/*")
public class Reservation {
	
	@GetMapping("/write")
	public String reserveForm() {
		return "reserve/reservation";
	}
	
	
	
}
