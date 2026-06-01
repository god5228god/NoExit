package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/theme/*")
public class Theme
{
	@GetMapping("list")
	public String themeList()
	{
		return "theme/themelist";
	}
	
	@GetMapping("detail")
	public String themeDetail()
	{
		// dto 로 담아서 넘겨줌
		
		return "theme/themedetail";
	}
}
