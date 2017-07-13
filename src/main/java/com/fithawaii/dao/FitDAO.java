package com.fithawaii.dao;

import java.util.List;

import com.fithawaii.model.Fit;
import com.fithawaii.model.HotelAllInfo;
import com.fithawaii.model.HotelInfo;
import com.fithawaii.model.HotelRoomInfo;

public interface FitDAO {

	public List<HotelAllInfo> selectHotelRecommendInfo();

	public List<HotelAllInfo> selectHotelAllInfo();

	public List<HotelAllInfo> selectHotelSearchResult(String key);

	public HotelAllInfo selectHotelDetailResult(int typeNo);

	public List<Fit> selectTest();
}
