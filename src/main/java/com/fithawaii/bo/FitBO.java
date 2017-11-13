package com.fithawaii.bo;

import com.fithawaii.dao.FitDAO;
import com.fithawaii.dao.MyBatisConnectionFactory;
import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelCategoryInfo;
import com.fithawaii.model.HotelDetailInfo;
import com.fithawaii.model.HotelInfo;
import com.fithawaii.model.HotelRoomInfo;
import com.fithawaii.model.SearchInfo;
import java.util.HashMap;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import javax.annotation.PostConstruct;
import java.util.List;

public class FitBO {

	// UserDAO가 호출될때 생성자를 통해 sqlSessionFactory 생성
	private SqlSessionFactory sqlSessionFactory;

	public FitBO() {
		sqlSessionFactory = MyBatisConnectionFactory.getSqlSessionFactory();
	}

	public List<HotelAllInfo> getHotelRecommendInfo() {
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

	public List<HotelAllInfo> getHotelAllInfo() {
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

	public List<HotelAllInfo> getHotelSearchResult(SearchInfo searchInfo) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<HotelAllInfo> hotelAllInfoList = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelAllInfoList = fitDAO.selectHotelSearchResult(searchInfo);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelAllInfoList;
	}

	public HotelDetailInfo getHotelDetailInfo(int hotelNo) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		HotelDetailInfo hotelDetailInfo = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelDetailInfo = fitDAO.selectHotelDetailInfo(hotelNo);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelDetailInfo;
	}

	public HotelInfo getHotelInfoByName(String hotelNm) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		HotelInfo hotelInfo = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelInfo = fitDAO.selectHotelInfoByName(hotelNm);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelInfo;
	}

	public List<HotelAllInfo> getHotelDetailResult(int hotelNo) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		List<HotelAllInfo> hotelAllInfoList = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelAllInfoList = fitDAO.selectHotelDetailResult(hotelNo);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

		return hotelAllInfoList;
	}

	public HotelAllInfo getHotelDetailResultByTypeNo(int typeNo) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		HotelAllInfo hotelAllInfo = null;

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);
			hotelAllInfo = fitDAO.selectHotelDetailResultByTypeNo(typeNo);
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

	public void insertAllDataFromExcel(List<HotelInfo> hotelInfoList, List<HotelCategoryInfo> hotelCategoryInfoList, List<HotelRoomInfo> hotelRoomInfoList) {
		// connect Mybatis session
		SqlSession sqlSession = sqlSessionFactory.openSession(true);

		try {
			// connect Mapper
			FitDAO fitDAO = sqlSession.getMapper(FitDAO.class);

			fitDAO.truncateHotelCategory();
			fitDAO.truncateHotelRoom();

			// fitDAO.mergeHotelInfo(hotelInfoList);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hotelCategoryInfoList", hotelCategoryInfoList);
			fitDAO.insertHotelCategoryInfo(map);

			map = new HashMap<String, Object>();
			map.put("hotelRoomInfoList", hotelRoomInfoList);
			fitDAO.insertHotelRoomInfo(map);
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}

	}
}