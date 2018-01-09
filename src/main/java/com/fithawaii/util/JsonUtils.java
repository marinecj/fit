package com.fithawaii.util;

import com.fithawaii.model.ReviewInfo;
import com.fithawaii.model.ShopInfo;
import java.io.IOException;

import com.fithawaii.model.SearchInfo;
import org.codehaus.jackson.map.ObjectMapper;

public class JsonUtils {

	private static ObjectMapper mapper = new ObjectMapper();

	public static String toJson(Object object) {
		String json = "";

		try {
			json = mapper.writeValueAsString(object);
		} catch (Exception e) {
			System.out.println(e);
		}

		return json;
	}

	public static SearchInfo toSearchInfo(String json) {
		try {
			return mapper.readValue(json, SearchInfo.class);
		} catch (IOException e) {
			//logger.error(e.getMessage(), e);
			System.out.println(e);
		}

		return null;
	}

	public static ReviewInfo toReviewInfo(String json) {
		try {
			return mapper.readValue(json, ReviewInfo.class);
		} catch (IOException e) {
			//logger.error(e.getMessage(), e);
			System.out.println(e);
		}

		return null;
	}

	public static ShopInfo toShopInfo(String json) {
		try {
			return mapper.readValue(json, ShopInfo.class);
		} catch (IOException e) {
			System.out.println(e);
		}

		return null;
	}
}
