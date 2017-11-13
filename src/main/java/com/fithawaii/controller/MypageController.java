package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelDetailInfo;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MypageController {

	@RequestMapping(value = "/buydetail", method = RequestMethod.POST)
	public String detail(@RequestParam("hotelNo") int hotelNo, ModelMap model) {
		System.out.println("### detail => hotelNo : " + hotelNo);

		List<HotelAllInfo> hotelAllInfoList = new FitBO().getHotelDetailResult(hotelNo);

		HotelDetailInfo hotelDetailInfo = new FitBO().getHotelDetailInfo(hotelNo);

		System.out.println("### detail => hotelNo : " + hotelAllInfoList.get(0).getHotelInfo().getHotelNo() + ", hotelNm : " +  hotelAllInfoList.get(0).getHotelInfo().getHotelNm()
				+ ", grade : " +  hotelDetailInfo.getGrade());

		model.addAttribute("hotelAllInfoList", hotelAllInfoList);

		model.addAttribute("detail", hotelDetailInfo);

		return "buydetail";
	}

}