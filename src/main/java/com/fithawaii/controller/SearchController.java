package com.fithawaii.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.SearchInfo;
import com.fithawaii.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
public class SearchController {

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(@RequestParam("json") String json, ModelMap model) {
		System.out.println("### search param => " + json);

		SearchInfo searchInfo = null;
		try {
			searchInfo = JsonUtils.toSearchInfo(json);
		} catch (Exception e) {
			System.out.println("ErrorMsg : " + e.getMessage() + ", StackTrace : " + e.getStackTrace());
		}

		//System.out.println("keyword : " + keyword + ", startDate : " + startDate + ", endDate : " + endDate + ",
		// adultCnt : " + adultCnt + ", youthCnt : " + youthCnt + ", babyCnt : " + babyCnt + ", totalCnt : " + totalCnt);

		//String keyword = searchInfo.getKeyword();

		List<HotelAllInfo> resultList = null;

		if (searchInfo == null || (StringUtils.isBlank(searchInfo.getKeyword()) && StringUtils.isBlank(searchInfo.getStartDate()))) {
			// Select All
			resultList = new FitBO().getHotelAllInfo();
			/*for (int i = 0; i < resultList.size(); i++) {
				HotelAllInfo room = resultList.get(i);
				System.out.println("Hotel resultList : " + room.getHotelInfo().getHotelNo() + ", " + room.getCateInfo().getCateNo() + ", " + room.getRoomInfo().getTypeNo());
			}*/
		} else {
			resultList = new FitBO().getHotelSearchResult(searchInfo);
		}

		if (resultList != null) {
			System.out.println("### search => resultList size : " + resultList.size());

			model.addAttribute("resultList", resultList);
			model.addAttribute("resultListSize", resultList.size());

			model.addAttribute("searchInfo", searchInfo);
		}

		return "search";
	}


/*
	@RequestMapping(value = "/searchHotel", method = RequestMethod.GET)
	public String searchHotel(@RequestParam(value = "key") String key, ModelMap model) {

		// Search Hotel
		List<HotelAllInfo> resultList = new FitBO().getHotelSearchResult(key);
		for (int i = 0; i < resultList.size(); i++) {
			HotelAllInfo room = resultList.get(i);
			System.out.println("Hotel search resultList : " + room.getHotelInfo().getHotelNo() + ", " + room.getCateInfo().getCateNo() + ", " + room.getRoomInfo().getTypeNo());
		}
		model.addAttribute("resultList", resultList);

		//model.addAttribute("pageKey", "search");
		return "search";
	}

	@RequestMapping(value = "/search")
	public String main(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("searchInfo") SearchInfo searchInfo, ModelMap model) {

		*/
/*//*
/ all parameters
		Map<String, String[]> params = request.getParameterMap();
		for (Map.Entry<String, String[]> entry : params.entrySet()) {
			System.out.println("PARAMETER - Key = " + entry.getKey() + ", Value = " + entry.getValue());
		}*//*


		System.out.println(searchInfo.getKeyword());
		model.addAttribute("keyword", searchInfo.getKeyword());

		model.addAttribute("pageKey", "searchView");
		return "main";
	}

	@RequestMapping(value = "/searchView"*/
/*, method = RequestMethod.POST*//*
)
	public String search(*/
/*@RequestBody SearchInfo searchInfo, *//*
ModelMap model) {

		//System.out.println(searchInfo.getKeyword());
		//System.out.println(json);

		// Select All
		List<HotelAllInfo> resultList = new FitBO().getHotelAllInfo();
		*/
/*for (int i = 0; i < resultList.size(); i++) {
			HotelAllInfo room = resultList.get(i);
			System.out.println("Hotel resultList : " + room.getHotelInfo().getHotelNo() + ", " + room.getCateInfo().getCateNo() + ", " + room.getRoomInfo().getTypeNo());
		}*//*

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultListSize", resultList.size());

		//model.addAttribute("keyword", searchInfo.getKeyword());

		return "search";
	}
*/

}