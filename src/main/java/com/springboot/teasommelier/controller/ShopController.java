package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.teasommelier.dao.IShopDao;

@Controller
public class ShopController {
	@Autowired
	private IShopDao IShopDao;
	
	//  -- 전체 공개 (gest) -- 
	// 매장 목록 조회
	@RequestMapping("gest/ShopList")
	public String ShopList () {
		return"";
	}
	// 매장 상세 조회 
	@RequestMapping("gest/ShopDetail")
	public String ShopDetail () {
		
		return"";
	}
		
	// -- 관리자 권한 필요 (admin) --
	
	// 등록 폼
	@RequestMapping("/admin/ShopWrite")
	public String ShopWrite() {
		
		return"";
	}
	
	
	// 수정 폼
	@RequestMapping("/admin/ShopModify")
	public String ShopModify () {
		
		return"";
	}
	
	// 수정
	@RequestMapping("/admin/ShopUpdate")
	public String ShopUpdate () {
		return "redirect:/ShopList";
	}
	
	// 삭제 
	@RequestMapping("/admin/ShopDelete")
	public String ShopDelete () {
		return "redirect:/ShopList";
	}
}
