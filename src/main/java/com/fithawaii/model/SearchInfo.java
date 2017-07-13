package com.fithawaii.model;

import java.util.Date;

public class SearchInfo {

	private String keyword;
	private Date startDate;
	private Date endDate;
	private int adultCnt;
	private int youthCnt;
	private int babyCnt;
	private int totalCnt;

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
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
