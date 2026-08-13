package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.teasommelier.dao.IInquiryDao;

@Controller
public class InqiryController {

    @Autowired
    private IInquiryDao IInquiryDao;

    // -- 전체 공개 --
    // 대량문의 등록
    @RequestMapping("/guest/InqiryQuery")
    public String InqiryQuery(Model model) {
        return "guest/InqiryQuery";
    }

    // -- 회원 공개 --
    // 대량문의 목록조회
    @RequestMapping("/member/InqiryList")
    public String InqiryList(Model model) {
        return "/member/InqiryList";
    }

    // 상세 조회
    @RequestMapping("/member/InqiryDetail")
    public String InqiryDetail(Model model) {
        return "/member/InqiryDetail";
    }

    // -- 관리자.회원 공개 --
    // 대량문의 수정
    @RequestMapping("/InqiryUpdate")
    public String InqiryUpdate(Model model) {
        return "redirect:/guest/InqiryQuery";
    }

    // 대량문의 삭제
    @RequestMapping("/guest/InqiryDelete")
    public String InqiryDelete(Model model) {
        return "redirect:/guest/InqiryQuery";
    }
}
