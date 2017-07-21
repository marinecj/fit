package com.fithawaii.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelRoomInfo;
import com.fithawaii.util.FitHttpClient;
import java.net.URL;
import java.net.URLConnection;
import org.springframework.beans.factory.annotation.Autowired;
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

		try {
			int dollar = 100;
			String url = "https://search.naver.com/p/csearch/content/apirender_ssl.nhn?_callback=a&pkid=141&key=exchangeApiNationBetween&where=nexearch&q=%EB%8B%AC%EB%9F%AC+%EC%9C%A0%EB%A1%9C&u1=keb&u3=USD&u4=KRW&u8=down&u5=info&u2=" + dollar + "&_=1500515005067";

			/*Map<String, Object> map = new HashMap<String, Object>();
			map.put("u2", dollar);*/

			/*String result = FitHttpClient.sendRequestByGet(url);

			System.out.println(result);*/
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("pageKey", "home");
		return "main";
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main2(ModelMap model) {
		model.addAttribute("pageKey", "home");
		return "main";
	}

}