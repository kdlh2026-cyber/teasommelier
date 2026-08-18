package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.teasommelier.dao.ICustomerServiceDao;
import com.springboot.teasommelier.dto.CustomerServiceDto;

@Controller
public class CustomerServiceController {
	@Autowired
	ICustomerServiceDao cs_dao;
	
	@RequestMapping("/guest/cs/cs_customerServiceList")
	public String customerService(Model model) {
	    model.addAttribute("csList", cs_dao.CustomerServiceList());
	    return "guest/cs/cs_customerServiceList";
	}
	
	@RequestMapping("/admin/cs/cs_customerServiceInsertForm")
	public String csInseertForm() {
		return "admin/cs/cs_customerServiceInsertForm";
	}
	
	@RequestMapping("/customerServiceInsert")
	public String csInsert(CustomerServiceDto cs_dto,Model model) {
		model.addAttribute("CustomerServiceInsert",new CustomerServiceDto());
		cs_dao.CustomerServiceInsert(cs_dto);
		return "redirect:/guest/cs/cs_customerServiceList";
	}
	
	@RequestMapping("/admin/cs/cs_customerServiceUpdateForm")
	public String csUpdateForm(CustomerServiceDto cs_dto,@RequestParam("cs_no") int cs_no,Model model) {
		model.addAttribute("csUpdate",cs_dao.CustomerServiceView(cs_dto.getCs_no()));
		return "admin/cs/cs_customerServiceUpdateForm";
	}
	
	@RequestMapping("/customerServiceUpdate")
	public String csUpdate(CustomerServiceDto cs_dto) {
		cs_dao.CustomerServiceUpdate(cs_dto);
		return "redirect:/guest/cs/cs_customerServiceList";
	}
	
	@RequestMapping("/customerServiceDelete")
	public String csDelete(@RequestParam("cs_no") int cs_no) {
		cs_dao.CustomerServiceDelete(cs_no);
		return "redirect:/guest/cs/cs_customerServiceList";
	}
}
