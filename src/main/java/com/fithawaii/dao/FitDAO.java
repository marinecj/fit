package com.fithawaii.dao;

import com.fithawaii.model.*;

import java.util.List;

import java.util.Map;

public interface FitDAO {

	public List<HotelAllInfo> selectHotelRecommendInfo();

	public List<HotelAllInfo> selectHotelAllInfo();

	public List<HotelAllInfo> selectHotelSearchResult(SearchInfo searchInfo);

	public List<HotelAllInfo> selectHotelDetailResult(int hotelNo);

	public HotelAllInfo selectHotelDetailResultByTypeNo(int typeNo);

	public HotelDetailInfo selectHotelDetailInfo(int hotelNo);

	public HotelInfo selectHotelInfoByName(String hotelNm);

	public ReviewInfo selectHotelReview(int hotelNo);

	public int insertReview(ReviewInfo reviewInfo);

	public List<Fit> selectTest();

	public void truncateHotelCategory();

	public void truncateHotelRoom();

	public void insertHotelCategoryInfo(Map<String, Object> map);

	public void insertHotelRoomInfo(Map<String, Object> map);
}
