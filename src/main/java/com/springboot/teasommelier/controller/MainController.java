package com.springboot.teasommelier.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	@RequestMapping("/")
	public String root() {
		
		return "redirect:main";
	}
	
	@RequestMapping("/main")
	public String main() {
		
		return "main";
	}
	
	@RequestMapping("/guest/MemberWriteForm")
	public String MemberWriteForm() {
		return"guest/MemberWriteForm";
	}
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "loginForm";
	}
	@RequestMapping("/loginError")
	public String loginError() {
		return"loginError";
	}
}
