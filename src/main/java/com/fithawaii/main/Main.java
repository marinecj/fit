package com.fithawaii.main;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.fithawaii.dao.FitDAO;
import com.fithawaii.dao.MyBatisConnectionFactory;
import com.fithawaii.model.Fit;

public class Main {
	public static void main(String args[]) {

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
	}
}
