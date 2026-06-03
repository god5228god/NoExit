package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/theme/*")
public class Theme
{
	@GetMapping("list")
	public String themeList()
	{
		return "theme/themelist";
	}
	
	@GetMapping("info/{themeid}")
	public String themeDetail(@PathVariable(name="themeid") int themeId)
	{
		
		return "theme/themedetail";
	}

	
	@GetMapping("enroll")
	public String enrollForm()
	{
		return "theme/themeEnrollForm";
	}
	
}
