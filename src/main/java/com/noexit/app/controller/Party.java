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
	
	@GetMapping("list")
	public String partyList()
	{
		return "party/partylist";
	}
	
	@GetMapping("detail")
	public String partyDetail()
	{
		return "party/partydetail";
	}
	
	@GetMapping("board")
	public String partyBoard()
	{
		return "party/partyboard";
	}
}
