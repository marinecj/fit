package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.SearchInfo;
import com.fithawaii.util.JsonUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class DetailController {

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public String detail(@RequestParam("typeNo") int typeNo, ModelMap model) {
		System.out.println("### detail => typeNo : " + typeNo);

		HotelAllInfo hotelDetailInfo = new FitBO().getHotelDetailResult(typeNo);

		System.out.println("### detail => hotelNo : " + hotelDetailInfo.getHotelInfo().getHotelNo() + ", hotelNm : " + hotelDetailInfo.getHotelInfo().getHotelNm());

		model.addAttribute("result", hotelDetailInfo);

		return "detail";
	}

}