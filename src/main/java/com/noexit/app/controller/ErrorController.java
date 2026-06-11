package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@RequestMapping("/err/*")
public class ErrorController
{
	@GetMapping("error")
	public String errorPage(@RequestParam(name="errorMsg") String errorMsg, Model model)
	{
		model.addAttribute("errorMsg", errorMsg);
		
		return "error/error";
	}
}
