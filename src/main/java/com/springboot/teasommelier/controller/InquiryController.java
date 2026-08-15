package com.springboot.teasommelier.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.IInquiryDao;
import com.springboot.teasommelier.dto.InquiryDto;

@Controller
public class InquiryController {

    @Autowired
    private IInquiryDao inquiryDao;

    private static final String UPLOAD_PATH =
            "C:\\teasommelier\\src\\main\\resources\\static\\images\\inquiry\\";

    // ==================== GUEST ====================

    // 비회원 - 문의 작성폼
    @RequestMapping("/guest/inquiryWrite")
    public String guestInquiryWriteForm() {
        return "guest/inquiryWrite";
    }

    // 회원 / 비회원 - 문의 등록
    @RequestMapping("/guest/InquiryWrite")
    public String guestInquiryWrite(
            InquiryDto i_dto,
            Authentication authentication,
            @RequestParam(value = "i_file1", required = false) MultipartFile i_file1,
            @RequestParam(value = "i_file2", required = false) MultipartFile i_file2,
            @RequestParam(value = "i_file3", required = false) MultipartFile i_file3,
            @RequestParam(value = "i_file4", required = false) MultipartFile i_file4,
            @RequestParam(value = "i_file5", required = false) MultipartFile i_file5)
            throws Exception {

        if (authentication != null && authentication.isAuthenticated()) {
            i_dto.setM_id(authentication.getName());
        }

        File uploadDir = new File(UPLOAD_PATH);

        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        List<MultipartFile> files = new ArrayList<>();
        files.add(i_file1);
        files.add(i_file2);
        files.add(i_file3);
        files.add(i_file4);
        files.add(i_file5);

        List<String> savedNames = new ArrayList<>();

        for (MultipartFile file : files) {
            if (file != null && !file.isEmpty()) {
                String filename = file.getOriginalFilename();

                file.transferTo(new File(UPLOAD_PATH + filename));

                savedNames.add(filename);
            }
        }

        if (!savedNames.isEmpty()) {
            i_dto.setI_file(String.join(",", savedNames));
        }

        inquiryDao.insert_tea_inquiry(i_dto);

        if (authentication != null && authentication.isAuthenticated()) {
            return "redirect:/member/inquiryListM";
        }

        return "redirect:/guest/inquiryWrite";
    }

    // ==================== MEMBER ====================

    // 회원 - 문의 목록
    @RequestMapping("/member/inquiryListM")
    public String memberInquiryListM(
            Authentication authentication,
            Model model) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String m_id = authentication.getName();

        List<InquiryDto> inquiryList =
                inquiryDao.selectMyInquiryList(m_id);

        model.addAttribute("inquiryList", inquiryList);

        return "member/inquiryListM";
    }

    // 회원 - 문의 상세
    @RequestMapping("/member/inquiryDetailM")
    public String memberInquiryDetailM(
            Authentication authentication,
            @RequestParam(value = "i_no", required = false) Integer i_no,
            Model model) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (i_no == null) {
            return "redirect:/member/inquiryListM";
        }

        String m_id = authentication.getName();

        InquiryDto i_dto =
                inquiryDao.selectMyInquiry(i_no, m_id);

        if (i_dto == null) {
            return "redirect:/member/inquiryListM";
        }

        model.addAttribute("inquiry", i_dto);

        return "member/inquiryDetailM";
    }

    // 회원 - 문의 수정폼
    @RequestMapping("/member/inquiryEditFormM")
    public String memberInquiryEditFormM(
            Authentication authentication,
            @RequestParam(value = "i_no", required = false) Integer i_no,
            Model model) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (i_no == null) {
            return "redirect:/member/inquiryListM";
        }

        String m_id = authentication.getName();

        InquiryDto i_dto =
                inquiryDao.selectMyInquiry(i_no, m_id);

        if (i_dto == null) {
            return "redirect:/member/inquiryListM";
        }

        model.addAttribute("inquiry", i_dto);

        return "member/inquiryEditFormM";
    }

    // 회원 - 문의 수정
    @RequestMapping("/member/InquiryEditM")
    public String memberInquiryEditM(
            Authentication authentication,
            InquiryDto i_dto) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String m_id = authentication.getName();
        i_dto.setM_id(m_id);

        if (i_dto.getI_no() <= 0) {
            return "redirect:/member/inquiryListM";
        }

        InquiryDto check =
                inquiryDao.selectMyInquiry(
                        i_dto.getI_no(),
                        m_id
                );

        if (check == null) {
            return "redirect:/member/inquiryListM";
        }

        inquiryDao.updateMyInquiry(i_dto);

        return "redirect:/member/inquiryDetailM?i_no="
                + i_dto.getI_no();
    }

    // 회원 - 문의 삭제
    @RequestMapping("/member/InquiryDeleteM")
    public String memberInquiryDeleteM(
            Authentication authentication,
            @RequestParam(value = "i_no", required = false) Integer i_no) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        if (i_no == null) {
            return "redirect:/member/inquiryListM";
        }

        String m_id = authentication.getName();

        inquiryDao.deleteMyInquiry(i_no, m_id);

        return "redirect:/member/inquiryListM";
    }

    // ==================== ADMIN ====================

    // 관리자 - 문의 목록
    @RequestMapping("/admin/inquiryListA")
    public String adminInquiryListA(Model model) {

        List<InquiryDto> inquiryList =
                inquiryDao.select_tea_inquiry_List();

        model.addAttribute("inquiryList", inquiryList);

        return "admin/inquiryListA";
    }

    // 관리자 - 문의 상세
    @RequestMapping("/admin/inquiryDetailA")
    public String adminInquiryDetailA(
            @RequestParam(value = "i_no", required = false) Integer i_no,
            Model model) {

        if (i_no == null) {
            return "redirect:/admin/inquiryListA";
        }

        InquiryDto i_dto =
                inquiryDao.select_tea_inquiry(i_no);

        if (i_dto == null) {
            return "redirect:/admin/inquiryListA";
        }

        model.addAttribute("inquiry", i_dto);

        return "admin/inquiryDetailA";
    }

    // 관리자 - 문의 수정폼
    @RequestMapping("/admin/inquiryEditFormA")
    public String adminInquiryEditFormA(
            @RequestParam(value = "i_no", required = false) Integer i_no,
            Model model) {

        if (i_no == null) {
            return "redirect:/admin/inquiryListA";
        }

        InquiryDto i_dto =
                inquiryDao.select_tea_inquiry(i_no);

        if (i_dto == null) {
            return "redirect:/admin/inquiryListA";
        }

        model.addAttribute("inquiry", i_dto);

        return "admin/inquiryEditFormA";
    }

 // 관리자 - 문의 답변 저장
    @RequestMapping("/admin/InquiryEditA")
    public String adminInquiryEditA(InquiryDto i_dto) {

        if (i_dto.getI_no() <= 0) {
            return "redirect:/admin/inquiryListA";
        }

        InquiryDto oldInquiry =
                inquiryDao.select_tea_inquiry(i_dto.getI_no());

        if (oldInquiry == null) {
            return "redirect:/admin/inquiryListA";
        }

        // 답변상태 + 답변내용 변경, 개인정보동의(i_define)는 관리자 수정 대상 아님
        oldInquiry.setI_reply(i_dto.getI_reply());
        oldInquiry.setI_answer(i_dto.getI_answer());

        inquiryDao.update_tea_inquiry(oldInquiry);

        return "redirect:/admin/inquiryListA";
    }

    // 관리자 - 문의 삭제
    @RequestMapping("/admin/InquiryDeleteA")
    public String adminInquiryDeleteA(
            @RequestParam(value = "i_no", required = false) Integer i_no) {

        if (i_no == null) {
            return "redirect:/admin/inquiryListA";
        }

        inquiryDao.delete_tea_inquiry(i_no);

        return "redirect:/admin/inquiryListA";
    }
}