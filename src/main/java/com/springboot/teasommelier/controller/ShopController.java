package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.teasommelier.dao.IShopDao;

@Controller
public class ShopController {

    @Autowired
    private IShopDao shopDao;

    // 전체 공개 - 매장 목록 조회
    @RequestMapping("/guest/ShopList")
    public String ShopList() {

        return "guest/ShopList";
    }

    // 전체 공개 - 매장 상세 조회
    @RequestMapping("/guest/ShopDetail")
    public String ShopDetail() {

        return "guest/ShopDetail";
    }

    // 관리자 - 등록 폼
    @RequestMapping("/admin/ShopWrite")
    public String ShopWrite() {

        return "admin/ShopWrite";
    }

    // 관리자 - 수정 폼
    @RequestMapping("/admin/ShopModify")
    public String ShopModify() {

        return "admin/ShopModify";
    }

    // 관리자 - 수정
    @RequestMapping("/admin/ShopUpdate")
    public String ShopUpdate() {

        return "redirect:/guest/ShopList";
    }

    // 관리자 - 삭제
    @RequestMapping("/admin/ShopDelete")
    public String ShopDelete() {

        return "redirect:/guest/ShopList";
    }
}
