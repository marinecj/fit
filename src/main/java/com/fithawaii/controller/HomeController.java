package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class HomeController {

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(ModelMap model) {

		model.addAttribute("hotelRecommendInfoList", new FitBO().getHotelRecommendInfo());

		return "home";
	}

}