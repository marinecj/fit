package com.fithawaii.model;

public class HotelAllInfo {

	private HotelInfo hotelInfo;
	private HotelCategoryInfo cateInfo;
	private HotelRoomInfo roomInfo;
	private HotelDetailInfo detailInfo;

	public HotelAllInfo(HotelInfo hotelInfo, HotelCategoryInfo cateInfo, HotelRoomInfo roomInfo, HotelDetailInfo detailInfo) {
		this.hotelInfo = hotelInfo;
		this.cateInfo = cateInfo;
		this.roomInfo = roomInfo;
		this.detailInfo = detailInfo;
	}

	public HotelAllInfo() {

	}

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

	public HotelDetailInfo getDetailInfo() {
		return detailInfo;
	}

	public void setDetailInfo(HotelDetailInfo detailInfo) {
		this.detailInfo = detailInfo;
	}
}