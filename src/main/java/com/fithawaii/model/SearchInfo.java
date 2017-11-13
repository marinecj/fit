package com.fithawaii.model;

public class SearchInfo {

	private String keyword;
	private String startDate;
	private String endDate;
	private int adultCnt;
	private int youthCnt;
	private int babyCnt;
	private int totalCnt;

	public SearchInfo() {
	}

	public SearchInfo(String keyword) {
		this.keyword = keyword;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getAdultCnt() {
		return adultCnt;
	}

	public void setAdultCnt(int adultCnt) {
		this.adultCnt = adultCnt;
	}

	public int getYouthCnt() {
		return youthCnt;
	}

	public void setYouthCnt(int youthCnt) {
		this.youthCnt = youthCnt;
	}

	public int getBabyCnt() {
		return babyCnt;
	}

	public void setBabyCnt(int babyCnt) {
		this.babyCnt = babyCnt;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
}
