package com.fithawaii.model;

public class ReviewInfo {

	private int hotelNo;
	private float star1;
	private float star2;
	private float star3;
	private float star4;
	private String comment;

	public ReviewInfo() {
	}

	public int getHotelNo() {
		return hotelNo;
	}

	public void setHotelNo(int hotelNo) {
		this.hotelNo = hotelNo;
	}

	public float getStar1() {
		return star1;
	}

	public void setStar1(float star1) {
		this.star1 = star1;
	}

	public float getStar2() {
		return star2;
	}

	public void setStar2(float star2) {
		this.star2 = star2;
	}

	public float getStar3() {
		return star3;
	}

	public void setStar3(float star3) {
		this.star3 = star3;
	}

	public float getStar4() {
		return star4;
	}

	public void setStar4(float star4) {
		this.star4 = star4;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
}
