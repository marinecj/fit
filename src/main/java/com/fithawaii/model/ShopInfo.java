package com.fithawaii.model;

public class ShopInfo {

	private String CST_MID;			// 상점아이디
	private String CST_PLATFORM;		// 테스트, 서비스 구분
	private String LGD_BUYER;			// 구매자
	private String LGD_PRODUCTINFO;	// 상품정보
	private String LGD_AMOUNT;		// 결제금액
	private String LGD_BUYEREMAIL;	// 구매자 이메일
	private String LGD_OID;			// 주문번호
	private String LGD_TIMESTAMP;	// 주문시각
	private String LGD_CUSTOM_USABLEPAYL;	// 상점정의 초기결제수단

	public String getCST_MID() {
		return CST_MID;
	}

	public void setCST_MID(String CST_MID) {
		this.CST_MID = CST_MID;
	}

	public String getCST_PLATFORM() {
		return CST_PLATFORM;
	}

	public void setCST_PLATFORM(String CST_PLATFORM) {
		this.CST_PLATFORM = CST_PLATFORM;
	}

	public String getLGD_BUYER() {
		return LGD_BUYER;
	}

	public void setLGD_BUYER(String LGD_BUYER) {
		this.LGD_BUYER = LGD_BUYER;
	}

	public String getLGD_PRODUCTINFO() {
		return LGD_PRODUCTINFO;
	}

	public void setLGD_PRODUCTINFO(String LGD_PRODUCTINFO) {
		this.LGD_PRODUCTINFO = LGD_PRODUCTINFO;
	}

	public String getLGD_AMOUNT() {
		return LGD_AMOUNT;
	}

	public void setLGD_AMOUNT(String LGD_AMOUNT) {
		this.LGD_AMOUNT = LGD_AMOUNT;
	}

	public String getLGD_BUYEREMAIL() {
		return LGD_BUYEREMAIL;
	}

	public void setLGD_BUYEREMAIL(String LGD_BUYEREMAIL) {
		this.LGD_BUYEREMAIL = LGD_BUYEREMAIL;
	}

	public String getLGD_OID() {
		return LGD_OID;
	}

	public void setLGD_OID(String LGD_OID) {
		this.LGD_OID = LGD_OID;
	}

	public String getLGD_TIMESTAMP() {
		return LGD_TIMESTAMP;
	}

	public void setLGD_TIMESTAMP(String LGD_TIMESTAMP) {
		this.LGD_TIMESTAMP = LGD_TIMESTAMP;
	}

	public String getLGD_CUSTOM_USABLEPAYL() {
		return LGD_CUSTOM_USABLEPAYL;
	}

	public void setLGD_CUSTOM_USABLEPAYL(String LGD_CUSTOM_USABLEPAYL) {
		this.LGD_CUSTOM_USABLEPAYL = LGD_CUSTOM_USABLEPAYL;
	}
}
