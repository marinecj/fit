package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelDetailInfo;
import com.fithawaii.model.ReviewInfo;
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
	public String detail(@RequestParam("hotelNo") int hotelNo, ModelMap model) {
		System.out.println("### detail => hotelNo : " + hotelNo);

		List<HotelAllInfo> hotelAllInfoList = new FitBO().getHotelDetailResult(hotelNo);

		HotelDetailInfo hotelDetailInfo = new FitBO().getHotelDetailInfo(hotelNo);

		if (hotelAllInfoList.size() > 0 && hotelDetailInfo != null) {
			System.out.println(
					"### detail => hotelNo : " + hotelAllInfoList.get(0).getHotelInfo().getHotelNo() + ", hotelNm : " + hotelAllInfoList.get(0)
							.getHotelInfo().getHotelNm()
							+ ", grade : " + hotelDetailInfo.getGrade());
		}

		ReviewInfo reviewInfo = new FitBO().getHotelReview(hotelNo);
		if (reviewInfo != null) {
			System.out.println("hotelNo : " + reviewInfo.getHotelNo() + ", Comment : " + reviewInfo.getComment());
		}

		model.addAttribute("hotelAllInfoList", hotelAllInfoList);

		model.addAttribute("detail", hotelDetailInfo);

		model.addAttribute("review", reviewInfo);

		return "detail";
	}

}