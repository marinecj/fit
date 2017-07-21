package com.fithawaii.dao;

import com.fithawaii.model.HotelCategoryInfo;
import com.fithawaii.model.HotelDetailInfo;
import java.util.List;

import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelInfo;
import com.fithawaii.model.HotelRoomInfo;
import java.util.Map;

public interface FitDAO {

	public List<HotelAllInfo> selectHotelRecommendInfo();

	public List<HotelAllInfo> selectHotelAllInfo();

	public List<HotelAllInfo> selectHotelSearchResult(String key);

	public List<HotelAllInfo> selectHotelDetailResult(int hotelNo);

	public HotelAllInfo selectHotelDetailResultByTypeNo(int typeNo);

	public HotelDetailInfo selectHotelDetailInfo(int hotelNo);

	public HotelInfo selectHotelInfoByName(String hotelNm);

	public List<Fit> selectTest();

	public void truncateHotelCategory();

	public void truncateHotelRoom();

	public void insertHotelCategoryInfo(Map<String, Object> map);

	public void insertHotelRoomInfo(Map<String, Object> map);
}
