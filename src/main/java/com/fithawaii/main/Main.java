package com.fithawaii.main;

import java.util.HashMap;
import java.util.List;

import java.util.Map;
import org.apache.ibatis.session.SqlSession;

import com.fithawaii.dao.FitDAO;
import com.fithawaii.dao.MyBatisConnectionFactory;
import com.fithawaii.model.Fit;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;


public class Main {
	/*public static void main(String args[]) {

		// connect Mybatis session
		SqlSession sqlSession = MyBatisConnectionFactory.getSqlSessionFactory()
				.openSession(true);
		
		// connect Mapper
		FitDAO fit = sqlSession.getMapper(FitDAO.class);

		// Select
		List<Fit> fits = fit.selectTest();
		for (int i = 0; i < fits.size(); i++) {
			System.out.println("Fit Test2 String : " + fits.get(i).getTest2());
		}
	}*/

	public static void main(String[] args) {

		int won = -1;

		try {
			int dollar = 100;
			String path = "https://search.naver.com/p/csearch/content/apirender_ssl.nhn?_callback=a&pkid=141&key=exchangeApiNationBetween&where=nexearch&q=%EB%8B%AC%EB%9F%AC+%EC%9C%A0%EB%A1%9C&u1=keb&u3=USD&u4=KRW&u8=down&u5=info&u2=" + dollar + "&_=1500515005067";

			URL url = new URL(path);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");

			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream())));

			String output;
			System.out.println("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
				System.out.println(output);
			}

			conn.disconnect();

		} catch (MalformedURLException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		}

		System.out.println(won);
	}
}
