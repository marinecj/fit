package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.ReviewInfo;
import com.fithawaii.model.SearchInfo;
import com.fithawaii.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class ReviewController {

	@ResponseBody
	@RequestMapping(value = "/review", method = RequestMethod.POST)
	public String review(@RequestParam("json") String json, ModelMap model) {
		System.out.println("### review param => " + json);

		int resultCnt = -1;
		try {
			ReviewInfo reviewInfo = JsonUtils.toReviewInfo(json);

			resultCnt = new FitBO().writeReview(reviewInfo);

			System.out.println("resultCnt : " + resultCnt);
		} catch (Exception e) {
			System.out.println("ErrorMsg : " + e.getMessage() + ", StackTrace : " + e.getStackTrace());
		}

		return "";
	}

}