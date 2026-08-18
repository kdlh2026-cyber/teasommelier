package com.springboot.teasommelier.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.teasommelier.dao.IShopDao;
import com.springboot.teasommelier.dto.ShopDto;

@Controller
public class ShopController {

    @Autowired
    private IShopDao shopDao;

    // 이미지 저장 경로 - 상품(product) 이미지 저장 패턴과 동일하게 맞춤
    private static final String UPLOAD_DIR = "C:\\easommelier\\src\\main\\resources\\static\\images\\shop\\";

    // 전체 공개 - 매장 목록 조회 (guest, 카카오맵 있는 화면)
    @RequestMapping(value = "/guest/ShopList", method = RequestMethod.GET)
    public String ShopList(Model model) {
        // 매장 전체 조회 - 통합 조회 방식으로 결정한 부분
        List<ShopDto> shopList = shopDao.select_tea_shop_List();
        model.addAttribute("shopList", shopList);
        return "guest/ShopList";
    }

    // 관리자 - 매장 목록 조회 (등록/수정/삭제 관리용 테이블 화면)
    @RequestMapping(value = "/admin/ShopList", method = RequestMethod.GET)
    public String ShopListA(Model model) {
        List<ShopDto> shopList = shopDao.select_tea_shop_List();
        model.addAttribute("shopList", shopList);
        return "admin/ShopListA";
    }

    // 관리자 - 등록 폼
    @RequestMapping(value = "/admin/ShopWrite", method = RequestMethod.GET)
    public String ShopWrite() {
        return "admin/ShopWrite";
    }

    // 관리자 - 등록 처리
    @RequestMapping(value = "/admin/ShopWritePro", method = RequestMethod.POST)
    public String ShopWritePro(ShopDto shop, @RequestParam("sh_img_file") MultipartFile sh_img_file) {
        // 이미지 업로드 처리 - 로컬 경로에 저장 후 파일명만 DTO에 세팅
        // file input name을 sh_img_file로 분리해서 DTO의 String sh_img 필드와 바인딩 충돌 방지
        if (!sh_img_file.isEmpty()) {
            String fileName = sh_img_file.getOriginalFilename();
            File saveFile = new File(UPLOAD_DIR + fileName);
            try {
                sh_img_file.transferTo(saveFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            shop.setSh_img(fileName);
        }

        shopDao.insert_tea_shop(shop);
        return "redirect:/guest/ShopList";
    }

    // 관리자 - 수정 폼
    @RequestMapping(value = "/admin/ShopModify", method = RequestMethod.GET)
    public String ShopModify(@RequestParam("sh_no") int sh_no, Model model) {
        ShopDto shop = shopDao.select_tea_shop(sh_no);
        model.addAttribute("shop", shop);
        return "admin/ShopModify";
    }

    // 관리자 - 수정 처리
    @RequestMapping(value = "/admin/ShopUpdate", method = RequestMethod.POST)
    public String ShopUpdate(ShopDto shop, @RequestParam("sh_img_file") MultipartFile sh_img_file,
                              @RequestParam("existing_sh_img") String existingImg) {
        // 새 이미지 올렸으면 교체, 안 올렸으면 기존 이미지 파일명(hidden으로 넘어온 값) 유지
        if (!sh_img_file.isEmpty()) {
            String fileName = sh_img_file.getOriginalFilename();
            File saveFile = new File(UPLOAD_DIR + fileName);
            try {
                sh_img_file.transferTo(saveFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            shop.setSh_img(fileName);
        } else {
            shop.setSh_img(existingImg);
        }

        shopDao.update_tea_shop(shop);
        return "redirect:/guest/ShopList";
    }

    // 관리자 - 삭제
    @RequestMapping(value = "/admin/ShopDelete", method = RequestMethod.GET)
    public String ShopDelete(@RequestParam("sh_no") int sh_no) {
        shopDao.delete_tea_shop(sh_no);
        return "redirect:/guest/ShopList";
    }
}