package com.fithawaii.model;

import com.fithawaii.util.ExchangeUtil;

public class HotelRoomInfo {

	private int typeNo;
	private int hotelNo;
	private int cateNo;
	private String typeNm;
	private String agencyCd;
	private double price1;
	private double price2;
	private double price3;
	private double price4;
	private String breakfastYn;
	private String breakfastPrice;
	private double cotPrice;
	private String cradleYn;
	private String acYn;
	private String fridgeYn;
	private String bathYn;
	private String gardenYn;
	private String vaultYn;

	public int getTypeNo() {
		return typeNo;
	}

	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}

	public int getHotelNo() {
		return hotelNo;
	}

	public void setHotelNo(int hotelNo) {
		this.hotelNo = hotelNo;
	}

	public int getCateNo() {
		return cateNo;
	}

	public void setCateNo(int cateNo) {
		this.cateNo = cateNo;
	}

	public String getTypeNm() {
		return typeNm;
	}

	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}

	public String getAgencyCd() {
		return agencyCd;
	}

	public void setAgencyCd(String agencyCd) {
		this.agencyCd = agencyCd;
	}

	public double getPrice1() {
		return price1;
	}

	public void setPrice1(double price1) {
		this.price1 = ExchangeUtil.exchangeDollaToWon(price1);
	}

	public double getPrice2() {
		return price2;
	}

	public void setPrice2(double price2) {
		this.price2 = ExchangeUtil.exchangeDollaToWon(price2);
	}

	public double getPrice3() {
		return price3;
	}

	public void setPrice3(double price3) {
		this.price3 = ExchangeUtil.exchangeDollaToWon(price3);
	}

	public double getPrice4() {
		return price4;
	}

	public void setPrice4(double price4) {
		this.price4 = ExchangeUtil.exchangeDollaToWon(price4);
	}

	public String getBreakfastYn() {
		return breakfastYn;
	}

	public void setBreakfastYn(String breakfastYn) {
		this.breakfastYn = breakfastYn;
	}

	public String getBreakfastPrice() {
		return breakfastPrice;
	}

	public void setBreakfastPrice(String breakfastPrice) {
		this.breakfastPrice = breakfastPrice;
	}

	public double getCotPrice() {
		return cotPrice;
	}

	public void setCotPrice(double cotPrice) {
		this.cotPrice = cotPrice;
	}

	public String getCradleYn() {
		return cradleYn;
	}

	public void setCradleYn(String cradleYn) {
		this.cradleYn = cradleYn;
	}

	public String getAcYn() {
		return acYn;
	}

	public void setAcYn(String acYn) {
		this.acYn = acYn;
	}

	public String getFridgeYn() {
		return fridgeYn;
	}

	public void setFridgeYn(String fridgeYn) {
		this.fridgeYn = fridgeYn;
	}

	public String getBathYn() {
		return bathYn;
	}

	public void setBathYn(String bathYn) {
		this.bathYn = bathYn;
	}

	public String getGardenYn() {
		return gardenYn;
	}

	public void setGardenYn(String gardenYn) {
		this.gardenYn = gardenYn;
	}

	public String getVaultYn() {
		return vaultYn;
	}

	public void setVaultYn(String vaultYn) {
		this.vaultYn = vaultYn;
	}
}
