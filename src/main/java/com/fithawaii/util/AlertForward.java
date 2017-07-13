package com.fithawaii.util;

import org.springframework.ui.Model;

public class AlertForward {
	public static final String MESSAGE_KEY = "msg";
	public static final String NEXT_URL_KEY = "nextUrl";

	public static String alert(String message, Model model) {
		model.addAttribute(MESSAGE_KEY, message);
		return "/alert/alertOnly";
	}
	
	public static String alertAndGoPage(String message, String nextUrl, Model model) {
		model.addAttribute(MESSAGE_KEY, message);
		model.addAttribute(NEXT_URL_KEY, nextUrl);
		return "/alert/alertAndGoPage";
	}
	
	public static String alertAndClose(String message, Model model) {
		model.addAttribute(MESSAGE_KEY, message);
		return "/alert/alertAndClose";
	}
	
	public static String alertAndBack(String message, Model model) {
		model.addAttribute(MESSAGE_KEY, message);
		return "/alert/alertAndBack";
	}
}
