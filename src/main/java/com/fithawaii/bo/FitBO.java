package com.fithawaii.bo;

import com.fithawaii.dao.FitDAO;
import com.fithawaii.dao.MyBatisConnectionFactory;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelInfo;
import com.fithawaii.model.HotelRoomInfo;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import javax.annotation.PostConstruct;
import java.util.List;

public class FitBO {
	// UserDAO가 호출될때 생성자를 통해 sqlSessionFactory 생성
	private SqlSessionFactory sqlSessionFactory;

	public FitBO(){ sqlSessionFactory = MyBatisConnectionFactory.getSqlSessionFactory(); }

	public List<HotelAllInfo> getHotelRecommendInfo(	) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<HotelAllInfo> hotelRecommendInfoList = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelRecommendInfoList = fitDAO.selectHotelRecommendInfo();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelRecommendInfoList;
	}

	public List<HotelAllInfo> getHotelAllInfo(	) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<HotelAllInfo> hotelAllInfoList = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelAllInfoList = fitDAO.selectHotelAllInfo();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelAllInfoList;
	}

	public List<HotelAllInfo> getHotelSearchResult(String key) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<HotelAllInfo> hotelAllInfoList = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelAllInfoList = fitDAO.selectHotelSearchResult(key);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelAllInfoList;
	}

	public HotelAllInfo getHotelDetailResult(int typeNo) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		HotelAllInfo hotelAllInfo = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelAllInfo = fitDAO.selectHotelDetailResult(typeNo);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelAllInfo;
	}

	public List<Fit> getTest() {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		// connect Mapper
		FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);

		return fitDAO.selectTest();
	}
}
