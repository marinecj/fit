package com.fithawaii.shop.controller;

import com.fithawaii.bo.FitBO;
import com.fithawaii.model.ShopInfo;
import com.fithawaii.util.JsonUtils;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lgdacom.XPayClient.XPayClient;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/shop")
public class ShopController {

		    /*
     * [결제 인증요청 페이지(STEP2-1)]
     *
     * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
     */

    /*
     * 1. 기본결제 인증요청 정보 변경
     *
     * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
     */

	private String CST_PLATFORM         = "test";                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
	private String CST_MID              = "fithawaii";                      //LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.

	private String LGD_MERTKEY          = "5209c8faab60960d98728916d0d17cde";	//상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
	private String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
	private String LGD_CUSTOM_SKIN      = "red";                                                //상점정의 결제창 스킨(red)

	private String LGD_CUSTOM_SWITCHINGTYPE = "IFRAME"; //신용카드 카드사 인증 페이지 연동 방식 (수정불가)
	private String LGD_WINDOW_VER		= "2.5";												//결제창 버젼정보
	private String LGD_WINDOW_TYPE      = "iframe";              //결제창 호출 방식 (수정불가)

	private String LGD_OSTYPE_CHECK     = "P";                                                  //값 P: XPay 실행(PC 결제 모듈): PC용과 모바일용 모듈은 파라미터 및 프로세스가 다르므로 PC용은 PC 웹브라우저에서 실행 필요.
	//"P", "M" 외의 문자(Null, "" 포함)는 모바일 또는 PC 여부를 체크하지 않음
	//private String LGD_ACTIVEXYN		= "N";													//계좌이체 결제시 사용, ActiveX 사용 여부로 "N" 이외의 값: ActiveX 환경에서 계좌이체 결제 진행(IE)


	/*
	 * 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
	 */
	private String LGD_CASNOTEURL		= "http://fithawaii.com/shop/cas_noteurl";

	/*
	 * LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
	 */
	//private String LGD_RETURNURL		= "http://fithawaii.com/shop/returnurl";// FOR MANUAL
	private String LGD_RETURNURL		= "http://localhost:8080/shop/returnurl";// FOR MANUAL


	@RequestMapping(value = "/sample_crossplatform", method = RequestMethod.GET)
	public String sample_crossplatform(ModelMap model) throws Exception {
		return "shop/sample_crossplatform";
	}

	/*
	//@RequestMapping(value = "/payreq_crossplatform", method = RequestMethod.POST)
	//public String bill(@RequestParam("json") String json, ModelMap model) throws Exception {
	public String bill(@RequestBody String json, ModelMap model) throws Exception {
		System.sb.append("### shop param => " + json);

		String replacedParam = "{" + json.replace("=", "='").replace("&", "',") + "}";

		System.sb.append("### replacedParam => " + replacedParam);

		ShopInfo shopInfo = JsonUtils.toShopInfo(replacedParam);

		String LGD_OID              = shopInfo.getLGD_OID()*//*"test_1234567890020"*//*;     //주문번호(상점정의 유니크한 주문번호를 입력하세요)
		String LGD_PRODUCTINFO      = shopInfo.getLGD_PRODUCTINFO()*//*""*//*;              //상품명
		String LGD_AMOUNT           = shopInfo.getLGD_AMOUNT()*//*"50000"*//*;         //결제금액("," 를 제외한 결제금액을 입력하세요)
		String LGD_BUYER            = shopInfo.getLGD_BUYER();                    //구매자명
		String LGD_BUYEREMAIL       = shopInfo.getLGD_BUYEREMAIL();               //구매자 이메일
		String LGD_TIMESTAMP        = shopInfo.getLGD_TIMESTAMP();                //타임스탬프
		String LGD_CUSTOM_USABLEPAY = shopInfo.getLGD_CUSTOM_USABLEPAYL();        	//상점정의 초기결제수단
		*/
	@RequestMapping(value = "/payreq_crossplatform", method = RequestMethod.POST)
	public String bill(
		@RequestParam String LGD_OID,
		@RequestParam String LGD_PRODUCTINFO,
		@RequestParam String LGD_AMOUNT	,
		@RequestParam String LGD_BUYER,
		@RequestParam String LGD_BUYEREMAIL,
		@RequestParam String LGD_TIMESTAMP,
		@RequestParam String LGD_CUSTOM_USABLEPAY,
		ModelMap model) throws Exception {

    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
     *
     * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
     *************************************************
     *
     * 해쉬 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : 상점아이디
     * LGD_OID          : 주문번호
     * LGD_AMOUNT       : 금액
     * LGD_TIMESTAMP    : 타임스탬프
     * LGD_MERTKEY      : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
     *
     * MD5 해쉬데이터 암호화 검증을 위해
     * LG유플러스에서 발급한 상점키(MertKey)를 환경설정 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
     */
		StringBuffer sb = new StringBuffer();
		sb.append(LGD_MID);
		sb.append(LGD_OID);
		sb.append(LGD_AMOUNT);
		sb.append(LGD_TIMESTAMP);
		sb.append(LGD_MERTKEY);

		byte[] bNoti = sb.toString().getBytes();
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] digest = md.digest(bNoti);

		StringBuffer strBuf = new StringBuffer();
		for (int i=0 ; i < digest.length ; i++) {
			int c = digest[i] & 0xff;
			if (c <= 15){
				strBuf.append("0");
			}
			strBuf.append(Integer.toHexString(c));
		}

		String LGD_HASHDATA = strBuf.toString();
		String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - END
     *************************************************
     */




		Map payReqMap = new HashMap();

		payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// 테스트, 서비스 구분
		payReqMap.put("CST_MID"                     , CST_MID );                        	// 상점아이디
		payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                   // 결제창호출 방식(수정불가)
		payReqMap.put("LGD_MID"                     , LGD_MID );                        	// 상점아이디
		payReqMap.put("LGD_OID"                     , LGD_OID );                        	// 주문번호
		payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// 구매자
		payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// 상품정보
		payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// 결제금액
		payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// 구매자 이메일
		payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// 결제창 SKIN
		payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// 트랜잭션 처리방식
		payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// 타임스탬프
		payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 해쉬암호값
		payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// 응답수신페이지
		payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// 디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)
		payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );			// 신용카드 카드사 인증 페이지 연동 방식
		payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );						// 결제창 버젼정보
		payReqMap.put("LGD_OSTYPE_CHECK"           , LGD_OSTYPE_CHECK);                    // 값 P: XPay 실행(PC용 결제 모듈), PC, 모바일 에서 선택적으로 결제가능
		//payReqMap.put("LGD_ACTIVEXYN"			, LGD_ACTIVEXYN);						// 계좌이체 결제시 사용, ActiveX 사용 여부
		payReqMap.put("LGD_VERSION"         		, "JSP_Non-ActiveX_Standard");			// 사용타입 정보(수정 및 삭제 금지): 이 정보를 근거로 어떤 서비스를 사용하는지 판단할 수 있습니다.



		// 가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다 .
		payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // 가상계좌 NOTEURL



    /*Return URL에서 인증 결과 수신 시 셋팅될 파라미터 입니다.*/
		payReqMap.put("LGD_RESPCODE"  		 , "" );
		payReqMap.put("LGD_RESPMSG"  		 , "" );
		payReqMap.put("LGD_PAYKEY"  		 , "" );


		model.addAttribute("PAYREQ_MAP", payReqMap);

		/*
		XPayClient xPayClient = new XPayClient();
		xPayClient.Response("name", 0);
		*/

		return "shop/payreq_crossplatform";
	}

	@RequestMapping(value = "/returnurl", method = RequestMethod.POST)
	public String returnurl(
			@RequestParam(required = false) String CST_PLATFORM,
			@RequestParam(required = false) String CST_MID,
			@RequestParam(required = false) String LGD_WINDOW_TYPE,
			@RequestParam(required = false) String LGD_MID,
			@RequestParam(required = false) String LGD_OID,
			@RequestParam(required = false) String LGD_BUYER,
			@RequestParam(required = false) String LGD_PRODUCTINFO,
			@RequestParam(required = false) String LGD_AMOUNT,
			@RequestParam(required = false) String LGD_BUYEREMAIL,
			@RequestParam(required = false) String LGD_CUSTOM_SKIN,
			@RequestParam(required = false) String LGD_CUSTOM_PROCESSTYPE,
			@RequestParam(required = false) String LGD_TIMESTAMP,
			@RequestParam(required = false) String LGD_HASHDATA,
			@RequestParam(required = false) String LGD_RETURNURL,
			@RequestParam(required = false) String LGD_CUSTOM_USABLEPAY,
			@RequestParam(required = false) String LGD_CUSTOM_SWITCHINGTYPE,
			@RequestParam(required = false) String LGD_WINDOW_VER,
			@RequestParam(required = false) String LGD_OSTYPE_CHECK,
			@RequestParam(required = false) String LGD_VERSION,
			@RequestParam(required = false) String LGD_CASNOTEURL,
			@RequestParam(required = false) String LGD_RESPCODE,
			@RequestParam(required = false) String LGD_RESPMSG,
			@RequestParam(required = false) String LGD_PAYKEY,
			ModelMap model) throws Exception {

		Map payReqMap = new HashMap();

		payReqMap.put("CST_PLATFORM"                , CST_PLATFORM);                   	// 테스트, 서비스 구분
		payReqMap.put("CST_MID"                     , CST_MID );                        	// 상점아이디
		payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                   // 결제창호출 방식(수정불가)
		payReqMap.put("LGD_MID"                     , LGD_MID );                        	// 상점아이디
		payReqMap.put("LGD_OID"                     , LGD_OID );                        	// 주문번호
		payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// 구매자
		payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// 상품정보
		payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// 결제금액
		payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// 구매자 이메일
		payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// 결제창 SKIN
		payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// 트랜잭션 처리방식
		payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// 타임스탬프
		payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 해쉬암호값
		payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// 응답수신페이지
		payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// 디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)
		payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );			// 신용카드 카드사 인증 페이지 연동 방식
		payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );						// 결제창 버젼정보
		payReqMap.put("LGD_OSTYPE_CHECK"           , LGD_OSTYPE_CHECK);                    // 값 P: XPay 실행(PC용 결제 모듈), PC, 모바일 에서 선택적으로 결제가능
		payReqMap.put("LGD_VERSION"         		, LGD_VERSION);			// 사용타입 정보(수정 및 삭제 금지): 이 정보를 근거로 어떤 서비스를 사용하는지 판단할 수 있습니다.
		payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // 가상계좌 NOTEURL
		payReqMap.put("LGD_RESPCODE"  		 , LGD_RESPCODE );
		payReqMap.put("LGD_RESPMSG"  		 , LGD_RESPMSG );
		payReqMap.put("LGD_PAYKEY"  		 , LGD_PAYKEY );


		model.addAttribute("PAYREQ_MAP", payReqMap);

		return "shop/returnurl";
	}

	@RequestMapping(value = "/payres", method = RequestMethod.POST)
	public @ResponseBody String payres(
			@RequestParam(required = false) String LGD_PAYKEY,
			@RequestParam(required = false) String LGD_OID,
			@RequestParam(required = false) String LGD_PRODUCTINFO,
			@RequestParam(required = false) String LGD_AMOUNT	,
			@RequestParam(required = false) String LGD_BUYER,
			@RequestParam(required = false) String LGD_BUYEREMAIL,
			@RequestParam(required = false) String LGD_TIMESTAMP,
			@RequestParam(required = false) String LGD_CUSTOM_USABLEPAY,
			ModelMap model) throws Exception {
		
		StringBuilder sb = new StringBuilder();

		/*
		 * [최종결제요청 페이지(STEP2-2)]
		 *
		 * 매뉴얼 "5.1. XPay 결제 요청 페이지 개발"의 "단계 5. 최종 결제 요청 및 요청 결과 처리" 참조
		 *
		 * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
		 */

		/* ※ 중요
		* 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
		* 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다.
		* 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
		*/

		//String configPath = "/resources/lgdacom";  //LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
		String configPath = "J:\\dev\\IntellijProjects\\fit\\src\\main\\webapp\\resources\\lgdacom";  //local

		/*
		 *************************************************
		 * 1.최종결제 요청 - BEGIN
		 *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
		 *************************************************
		 */

		//해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다.
		// (1) XpayClient의 사용을 위한 xpay 객체 생성
		XPayClient xpay = new XPayClient();

		// (2) Init: XPayClient 초기화(환경설정 파일 로드)
		// configPath: 설정파일
		// CST_PLATFORM: - test, service 값에 따라 lgdacom.conf의 test_url(test) 또는 url(srvice) 사용
		//				- test, service 값에 따라 테스트용 또는 서비스용 아이디 생성
		boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);

		if( !isInitOK ) {
			//API 초기화 실패 화면처리
			sb.append( "결제요청을 초기화 하는데 실패하였습니다.<br>");
			sb.append( "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");
			sb.append( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
			sb.append( "문의전화 LG유플러스 1544-7772<br>");
			return sb.toString();

		}else{
			try{

				// (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
				xpay.Init_TX(LGD_MID);
				xpay.Set("LGD_TXNAME", "PaymentByKey");
				xpay.Set("LGD_PAYKEY", LGD_PAYKEY);

				//금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
				//String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
				//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
				//xpay.Set("LGD_AMOUNT", DB_AMOUNT);

			}catch(Exception e) {
				sb.append("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
				sb.append(""+e.getMessage());
				return sb.toString();
			}
		}
		/*
		 *************************************************
		 * 1.최종결제 요청(수정하지 마세요) - END
		 *************************************************
		 */

		/*
		 * 2. 최종결제 요청 결과처리
		 *
		 * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
		 */
		// (4) TX: lgdacom.conf에 설정된 URL로 소켓 통신하여 최종 인증요청, 결과값으로 true, false 리턴
		if ( xpay.TX() ) {
			//1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
			sb.append( "결제요청이 완료되었습니다.  <br>");
			sb.append( "TX 결제요청 통신 응답코드 = " + xpay.m_szResCode + "<br>");					//통신 응답코드("0000" 일 때 통신 성공)
			sb.append( "TX 결제요청 통신 응답메시지 = " + xpay.m_szResMsg + "<p>");					//통신 응답메시지


			sb.append("거래번호 : " + xpay.Response("LGD_TID",0) + "<br>");
			sb.append("상점아이디 : " + xpay.Response("LGD_MID",0) + "<br>");
			sb.append("상점주문번호 : " + xpay.Response("LGD_OID",0) + "<br>");
			sb.append("결제금액 : " + xpay.Response("LGD_AMOUNT",0) + "<br>");
			sb.append("결과코드 : " + xpay.Response("LGD_RESPCODE",0) + "<br>");						//LGD_RESPCODE 가 반드시 "0000" 일때만 결제 성공, 그 외는 모두 실패
			sb.append("결과메세지 : " + xpay.Response("LGD_RESPMSG",0) + "<p>");

			for (int i = 0; i < xpay.ResponseNameCount(); i++)
			{
				sb.append(xpay.ResponseName(i) + " = ");
				for (int j = 0; j < xpay.ResponseCount(); j++)
				{
					sb.append("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
				}
			}
			sb.append("<p>");


			// (5) DB에 인증요청 결과 처리
			if( "0000".equals( xpay.m_szResCode ) ) {
				// 통신상의 문제가 없을시
				// 최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
				sb.append("최종결제요청 성공, DB처리하시기 바랍니다.<br>");

				//최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
				//상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
				boolean isDBOK = true;
				if( !isDBOK ) {

					xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");

					sb.append( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
					sb.append( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");

					if( "0000".equals( xpay.m_szResCode ) ) {
						sb.append("자동취소가 정상적으로 완료 되었습니다.<br>");
					}else{
						sb.append("자동취소가 정상적으로 처리되지 않았습니다.<br>");
					}
				}

			}else{
				//통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
				sb.append("최종결제요청 결과 실패, DB처리하시기 바랍니다.<br>");
			}
		}else {
			//2)API 요청실패 화면처리
			sb.append( "결제요청이 실패하였습니다.  <br>");
			sb.append( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
			sb.append( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");

			//최종결제요청 결과 실패 DB처리
			sb.append("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");
		}

		return sb.toString();
	}

}
