package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@GetMapping("info/{partyid}")
	public String partyDetail(@PathVariable(name="partyid") int partyId)
	{
		return "party/partydetail";
	}
	
	@GetMapping("board/{partyid}")
	public String partyBoard(@PathVariable(name="partyid") int partyId)
	{
		return "party/partyboard2";
	}
}
