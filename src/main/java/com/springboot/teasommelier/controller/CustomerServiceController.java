package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.teasommelier.dao.ICustomerServiceDao;

@Controller
public class CustomerServiceController {
	@Autowired
	ICustomerServiceDao cs_dao;
	
	@RequestMapping("/guest/cs_customerServiceList")
	public String csList() {
		return "guest/cs_customerServiceList";
	}
}
