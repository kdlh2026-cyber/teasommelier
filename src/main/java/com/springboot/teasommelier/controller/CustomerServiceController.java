package com.springboot.teasommelier.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.springboot.teasommelier.dao.ICustomerServiceDao;

@Controller
public class CustomerServiceController {
	@Autowired
	ICustomerServiceDao csdao;
}
