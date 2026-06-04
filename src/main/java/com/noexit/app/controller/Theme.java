package com.noexit.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/theme/*")
public class Theme
{

    private final CafeController cafeController;

    Theme(CafeController cafeController) {
        this.cafeController = cafeController;
    }
	@GetMapping("list")
	public String themeList(@RequestParam(name="schType", defaultValue = "cafeName") String schType
						  , @RequestParam(name="kwd", defaultValue = "") String kwd
						  , Model model)
	{
		if(!kwd.isBlank())
		{
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
		}
		
		return "theme/themelist";
	}
	
	@GetMapping("info/{themeid}")
	public String themeDetail(@PathVariable(name="themeid") int themeId, Model model)
	{
		
		return "theme/themeinfo";
	}
	
	@GetMapping("enroll")
	public String enrollForm()
	{
		return "theme/themeEnrollForm";
	}
	
	@PostMapping()
	public String themeList(@RequestParam(name="schType", defaultValue = "cafeName") String schType
						  , @RequestParam(name="kwd", defaultValue = "") String kwd
						  , @RequestParam(name="lastId", defaultValue = "0") long lastId
						  , Model model)
	{
		return "";
	}
}
