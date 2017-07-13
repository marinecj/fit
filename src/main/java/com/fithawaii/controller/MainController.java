package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelRoomInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class MainController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(ModelMap model) {

		//System.out.println("Welcome Fit Hawaii!");

		/*// Select
		List<HotelAllInfo> roomInfo = new FitBO().getHotelAllInfo();
		for (int i = 0; i < roomInfo.size(); i++) {
			HotelAllInfo room = roomInfo.get(i);
			System.out.println("Hotel roomInfo : " + room.getHotelInfo().getHotelNo() + ", " + room.getCateInfo().getCateNo() + ", " + room.getRoomInfo().getTypeNo());
		}
		model.addAttribute("roomInfo", roomInfo);*/

		/*List<Fit> fits = new FitBO().getTest();
		for (int i = 0; i < fits.size(); i++) {
			System.out.println("Fit Test2 String : " + fits.get(i).getTest2());
		}
		model.addAttribute("fits", fits);*/

		model.addAttribute("pageKey", "home");
		return "main";
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main2(ModelMap model) {
		model.addAttribute("pageKey", "home");
		return "main";
	}

}