package com.fithawaii.util;

public class ExchangeUtil {

	public static final double USD = 1125.5;

	public static double exchangeDollaToWon(double dolla) {
		double won = -1;
		try {
			won = dolla * USD;
		} catch (Exception e) {
			System.out.println(e);
		}
		return won;
	}

	/**
	 * 달러 환율
	 * @param dollar
	 * @return
	 */
	/*private static double getExchangeRate(int dollar) {
		double rate = -1;

		String url = "https://search.naver.com/p/csearch/content/apirender_ssl.nhn?_callback=a&pkid=141&key=exchangeApiNationBetween&where=nexearch&q=%EB%8B%AC%EB%9F%AC+%EC%9C%A0%EB%A1%9C&u1=keb&u3=USD&u4=KRW&u8=down&u5=info&u2=" + dollar + "&_=1500515005067";

		String result = FitHttpClient.sendRequestByGet(url);

		System.out.println(result);

		return rate;
	}*/
}
