package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/party/*")
public class Party
{
	@GetMapping("write")
	public String partyWrite()
	{
		return "party/partywrite";
	}
}
