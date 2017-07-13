package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class RegionController {

	@RequestMapping(value = "/region/{name:.+}", method = RequestMethod.GET)
	public String region(@PathVariable("name") String name, ModelMap model) {
		System.out.println("### region => name : " + name);

		// Search Hotel
		List<HotelAllInfo> resultList = new FitBO().getHotelSearchResult(name);
		/*for (int i = 0; i < resultList.size(); i++) {
			HotelAllInfo room = resultList.get(i);
			System.out.println(name + " region resultList : " + room.getHotelInfo().getHotelNo() + ", " + room.getCateInfo().getCateNo() + ", " + room.getRoomInfo().getTypeNo());
		}*/

		System.out.println("### region => resultList size : " + resultList.size());

		model.addAttribute("resultList", resultList);

		model.addAttribute("regionName", name);

		return "region";
	}

}