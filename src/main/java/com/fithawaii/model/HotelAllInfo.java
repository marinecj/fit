package com.fithawaii.model;

public class HotelAllInfo {

	private HotelInfo hotelInfo;
	private HotelCategoryInfo cateInfo;
	private HotelRoomInfo roomInfo;

	public HotelInfo getHotelInfo() {
		return hotelInfo;
	}

	public void setHotelInfo(HotelInfo hotelInfo) {
		this.hotelInfo = hotelInfo;
	}

	public HotelCategoryInfo getCateInfo() {
		return cateInfo;
	}

	public void setCateInfo(HotelCategoryInfo cateInfo) {
		this.cateInfo = cateInfo;
	}

	public HotelRoomInfo getRoomInfo() {
		return roomInfo;
	}

	public void setRoomInfo(HotelRoomInfo roomInfo) {
		this.roomInfo = roomInfo;
	}
}