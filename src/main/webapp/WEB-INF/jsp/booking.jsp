<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

<div id="contents">

	<form method="post" id="LGD_PAYINFO" action="/shop/payreq">
		<div class="col-group">
			<div class="res-payment-info">
				<dl>
					<dt>결제정보</dt>
					<dd>
						<ul>
							<li><span class="label">체크인</span><p>2017년 1월 23일</p></li>
							<li><span class="label">체크아웃</span><p>2017년 1월 23일</p></li>
							<li><span class="label">이용 가능 포인트</span><p class="pt1">120,000원</p></li>
							<li><span class="label">사용할 포인트</span><p><input type="text" style="width: 78px;"><a href="#" class="t-btn ty6">적용</a></p></li>
							<li class="note">- 최소 5,000 포인트부터 사용 가능</li>
						</ul>
					</dd>
					<dd class="total">
						<span class="label">총 결제 금액</span><p class="pt1"><fmt:formatNumber value="${hotelAllInfo.roomInfo.price1Won}"  pattern="0"/>원</p>
					</dd>
				</dl>
				<div class="btn-box">
					<a href="<%--javascript:doPay();--%>#" id="buy_submit" class="i-btn bt-payment">결재하기</a>
					<p>총 결제 금액에는 객실+세금+봉사료+기타 할인이 포함되어 있습니다.</p>
				</div>
			</div><!-- end : .left-menu -->

			<div class="con-section">
				<h2 class="sr-only">예약정보</h2>

				<h3>예약확인</h3>
				<div class="my-buy-top">
					<div class="item">
						<span class="label">호텔 이름</span>
						<p class="line">${hotelAllInfo.hotelInfo.hotelNmKr}</p>
					</div>
					<div class="item">
						<span class="label">호텔 주소</span>
						<p>${hotelAllInfo.hotelInfo.hotelAddress}</p>
						<p>TEL : ${hotelAllInfo.hotelInfo.hotelTel}</p>    <p>${hotelAllInfo.hotelInfo.roomCnt}객실</p>
					</div>
				</div>

				<h3>숙박 정보</h3>
				<div class="tb-ty4">
					<table>
						<colgroup>
							<col width="164px" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th>룸타입</th>
							<td>${hotelAllInfo.roomInfo.typeNm}</td>
						</tr>
						<tr>
							<th>예약일자</th>
							<td>2017년 1월 29일 ~ 2017년 2월 2일  / 5박</td>
						</tr>
						<tr>
							<th>객실수</th>
							<td>1개</td>
						</tr>
						<tr>
							<th>인원수</th>
							<td>성인 2명, 유아 1명 / 총 3명</td>
						</tr>
						</tbody>
					</table>
				</div>

				<h3>예약자 정보<span>예약하시는 분의 연락처 정보를 입력해주세요. 예약확인 결과를 보내드립니다.</span></h3>
				<div class="tb-ty4">
					<table>
						<colgroup>
							<col width="164px" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="LGD_BUYER" id="LGD_BUYER" placeholder="입력해주세요" style="width: 234px;" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="LGD_BUYEREMAIL" id="LGD_BUYEREMAIL" placeholder="입력해주세요" style="width: 234px;" />
								<span class="note">* 이 이메일로 예약 확정 및 해당 일정에 대한 안내를 제공합니다.</span>
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>
								<div class="custom-select ty2" style="width: 76px;">
									<label><span></span></label>
									<select>
										<option>010</option>
									</select>
								</div>
								<span class="gap">-</span>
								<input type="text" style="width: 56px;" />
								<span class="gap">-</span>
								<input type="text" style="width: 56px;" />
							</td>
						</tr>
						</tbody>
					</table>
				</div>

				<h3>투숙자 정보</h3>
				<div class="tb-ty4">
					<table>
						<colgroup>
							<col width="164px" />
							<col width="92px" />
							<col width="45px" />
							<col width="91px" />
							<col width="*" />
							<col width="118px" />
							<col width="54px" span="2" />
						</colgroup>
						<thead>
						<tr>
							<th>대표 투숙자</th>
							<td colspan="7">
								<div class="sel-cover">
									<span class="custom-checkbox ty2"><label for="reservation-info"><input type="checkbox" id="reservation-info">예약자 정보와 동일</label></span>
								</div>
							</td>
						</tr>
						<tr>
							<th>이름/연락처</th>
							<td colspan="7">
								<input type="text" placeholder="한글이름" style="width: 104px;" />
								<span class="gap">&nbsp;</span>
								<div class="custom-select ty2" style="width: 76px;">
									<label><span></span></label>
									<select>
										<option>010</option>
									</select>
								</div>
								<span class="gap">-</span>
								<input type="text" style="width: 56px;" />
								<span class="gap">-</span>
								<input type="text" style="width: 56px;" />
								<span class="note">* 비상 시에만 연락드립니다</span>
							</td>
						</tr>
						<tr>
							<th colspan="8">투숙자 정보</th>
						</tr>
						</thead>
						<tbody class="guest-info">
						<tr>
							<th colspan="2">룸타임</th>
							<th>NO.</th>
							<th>한글 이름</th>
							<th>영문 이름</th>
							<th>영문 성</th>
							<th>성별</th>
							<th>나이</th>
						</tr>
						<tr>
							<td colspan="2" rowspan="2" class="left">Premium 1 Bedroom + Oceanview<br />(double bed)</td>
							<td>1</td>
							<td><input type="text" style="width: 78px;" /></td>
							<td><input type="text" style="width: 165px;" /></td>
							<td><input type="text" style="width: 105px;" /></td>
							<td>
								<div class="custom-select ty3" style="width: 40px;">
									<label><span></span></label>
									<select>
										<option>남</option>
										<option>여</option>
									</select>
								</div>
							</td>
							<td><input type="text" style="width: 40px;" /></td>
						</tr>
						<tr>
							<td>2</td>
							<td><input type="text" style="width: 78px;" /></td>
							<td><input type="text" style="width: 165px;" /></td>
							<td><input type="text" style="width: 105px;" /></td>
							<td>
								<div class="custom-select ty3" style="width: 40px;">
									<label><span></span></label>
									<select>
										<option>남</option>
										<option selected="selected">여</option>
									</select>
								</div>
							</td>
							<td><input type="text" style="width: 40px;" /></td>
						</tr>
						</tbody>
					</table>
				</div>
				<div class="my-detail-info">
					<ul>
						<li>- <span class="pt1">영문 이름/성</span>은 현지 호텔에 제시할 바우처에 입력되으로 <span class="pt1">여권정보와 동일하게 기재</span>해주세요.</li>
						<li>- 각 객실의 '대표투숙자'의 영문명이 여권과 동일하지 않은경우 투숙이 거부되며, <span class="pt1">예약완료 후 영문변경은 불가능</span>합니다.</li>
						<li>- 연령은 <span class="pt1">투숙일 기준으로 만 연령을 기재</span>해주세요. 기준연령 이하이거나 부정확한 정보 기재시 현장에서 객실 제공이 거부될 수 있습니다.</li>
					</ul>
				</div>

				<h3>요청 사항<span>호텔에 요구할 내용이 있으면 기재해주십시오. 기재한 내용에 대한 확인 유무는 현지 호텔에서 직접하셔야 합니다.</span></h3>
				<div class="textarea-box">
					<textarea rows="3"></textarea>
					<p class="word-length"><span>0</span>/500</p>
				</div>

				<h3>예약 약관 및 취소 정책</h3>
				<div class="my-detail-info">
					<ul>
						<li class="pt1">- 무료 취소 기한 : 2017년 1월 2일</li>
						<li>- 2017년 1월 2일 오후 6:00((GMT-10:00) Hawaii) 이후에 예약을 변경하거나 취소하시는 경우 2박에 해당하는 요금(세금 포함)이<br />수수료로 부과됩니다.</li>
						<li>- 예약 후 오지 않거나 예정보다 일찍 체크아웃하는 경우 환불해 드리지 않습니다.</li>
					</ul>
				</div>

				<h3>이용 동의<span>이용약관과 개인정보 보호정책을 읽고 이에 동의합니다.</span></h3>
				<div class="use-agree-box sel-cover">
					<div class="all">
						<span class="custom-checkbox ty2"><label for="agree-all"><input type="checkbox" id="agree-all">약관 전체 동의 </label></span>
					</div>
					<ul>
						<li><span class="custom-checkbox ty2"><label for="agree1"><input type="checkbox" id="agree1">이용약관</label></span>(<a href="#">보기</a>)</li>
						<li><span class="custom-checkbox ty2"><label for="agree2"><input type="checkbox" id="agree2">개인정보 보호정책</label></span>(<a href="#">보기</a>)</li>
						<li><span class="custom-checkbox ty2"><label for="agree3"><input type="checkbox" id="agree3">객실유의사항</label></span>(<a href="#">보기</a>)</li>
						<li><span class="custom-checkbox ty2"><label for="agree4"><input type="checkbox" id="agree4">취소규정</label></span>(<a href="#">보기</a>)</li>
					</ul>
				</div>
			</div><!-- end : .con-section -->
		</div><!-- end : .col-group -->

		<input type="hidden" name="CST_MID" id="CST_MID" value="fithawaii"/>
		<input type="hidden" name="CST_PLATFORM" id="CST_PLATFORM" value="test"/>
		<input type="hidden" name="LGD_PRODUCTINFO" id="LGD_PRODUCTINFO" value="${hotelAllInfo.hotelInfo.hotelNmKr}"/>
		<input type="hidden" name="LGD_AMOUNT" id="LGD_AMOUNT" value="<fmt:formatNumber value="${hotelAllInfo.roomInfo.price1Won}"  pattern="0"/>"/>
		<input type="hidden" name="LGD_TIMESTAMP" id="LGD_TIMESTAMP" value="1234567890"/>
		<input type="hidden" name="LGD_OID" id="LGD_OID" value="test_1234567890020"/>
		<%--<select name="LGD_CUSTOM_USABLEPAY" id="LGD_CUSTOM_USABLEPAY">
			<option value="SC0010">신용카드</option>
			<option value="SC0030">계좌이체</option>
			<option value="SC0040">무통장입금</option>
			<option value="SC0060">휴대폰</option>
			<option value="SC0070">유선전화결제</option>
			<option value="SC0090">OK캐쉬백</option>
			<option value="SC0111">문화상품권</option>
			<option value="SC0112">게임문화상품권</option>
		</select>--%>
		<input type="hidden" name="LGD_CUSTOM_USABLEPAY" id="LGD_CUSTOM_USABLEPAY" value="SC0010"/>
		<input type="hidden" name="LGD_WINDOW_TYPE" id="LGD_WINDOW_TYPE" value="iframe"/>
		<input type="hidden" name="LGD_CUSTOM_SWITCHINGTYPE" id="LGD_CUSTOM_SWITCHINGTYPE" value="IFRAME"/>

		<input type="hidden" name="LGD_MID" id="LGD_MID" value=""/>
		<input type="hidden" name="LGD_CUSTOM_SKIN" id="LGD_CUSTOM_SKIN" value=""/>
		<input type="hidden" name="LGD_CUSTOM_PROCESSTYPE" id="LGD_CUSTOM_PROCESSTYPE" value=""/>
		<input type="hidden" name="LGD_HASHDATA" id="LGD_HASHDATA" value=""/>
		<input type="hidden" name="LGD_RETURNURL" id="LGD_RETURNURL" value=""/>
		<input type="hidden" name="LGD_WINDOW_VER" id="LGD_WINDOW_VER" value=""/>
		<input type="hidden" name="LGD_OSTYPE_CHECK" id="LGD_OSTYPE_CHECK" value=""/>
		<input type="hidden" name="LGD_VERSION" id="LGD_VERSION" value=""/>
		<input type="hidden" name="LGD_CASNOTEURL" id="LGD_CASNOTEURL" value=""/>
		<input type="hidden" name="LGD_RESPCODE" id="LGD_RESPCODE" value=""/>
		<input type="hidden" name="LGD_RESPMSG" id="LGD_RESPMSG" value=""/>
		<input type="hidden" name="LGD_PAYKEY" id="LGD_PAYKEY" value=""/>
		<input type="hidden" name="LGD_ENCODING" value="UTF-8">
		<input type="hidden" name="LGD_ENCODING_NOTEURL"  value="UTF-8">
		<input type="hidden" name="LGD_ENCODING_RETURNURL"  value="UTF-8">
	</form>

</div><!-- end : #contents -->

<%@ include file="/WEB-INF/jsp/include/javascripts.jsp" %>

<script language="javascript" src="http://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var floatPosition = parseInt($(".res-payment-info").css('top'));
		var h = $("#contents").offset().top +$("#contents").height()-$(".res-payment-info").height()-118;
		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var newPosition=scrollTop + floatPosition;
			if(newPosition>h){newPosition = h;}else if(newPosition<0){newPosition = 0;}
			$(".res-payment-info").stop().animate({"top" : newPosition + "px"}, 300);
		}).scroll();

		$("#buy_submit").click(function() {
			if ($('#LGD_BUYER').val() == '') {
				alert('이름을 입력해주세요.');
				return false;
			}
			if ($('#LGD_BUYEREMAIL').val() == '') {
				alert('이메일을 입력해주세요.');
				return false;
			}

			// OID, TIMESTAMP 생성
			makeoid();

			_oRequest = $.ajax({
				type : "POST",
				url : "/shop/payreq",
				cache : false,
				data : {
					"LGD_OID" : $('#LGD_OID').val(),
					"LGD_AMOUNT" : $('#LGD_AMOUNT').val(),
					"LGD_TIMESTAMP" : $('#LGD_TIMESTAMP').val()
				},
				error : function(request,status,error) {
					if (error != "") {
						console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
					}

					_oRequest = null;
				},
				complete : function(oRes) {
					var payReqMap = JSON.parse(oRes.responseText);

					console.log("payreq - LGD_MID : " + payReqMap.LGD_MID);
					console.log("payreq - LGD_OID : " + payReqMap.LGD_OID);
					console.log("payreq - LGD_PRODUCTINFO : " + $('#LGD_PRODUCTINFO').val());
					console.log("payreq - LGD_CUSTOM_SKIN : " + payReqMap.LGD_CUSTOM_SKIN);
					console.log("payreq - LGD_CUSTOM_PROCESSTYPE : " + payReqMap.LGD_CUSTOM_PROCESSTYPE);
					console.log("payreq - LGD_HASHDATA : " + payReqMap.LGD_HASHDATA);
					console.log("payreq - LGD_RETURNURL : " + payReqMap.LGD_RETURNURL);
					console.log("payreq - LGD_WINDOW_VER : " + payReqMap.LGD_WINDOW_VER);
					console.log("payreq - LGD_OSTYPE_CHECK : " + payReqMap.LGD_OSTYPE_CHECK);
					console.log("payreq - LGD_VERSION : " + payReqMap.LGD_VERSION);
					console.log("payreq - LGD_CASNOTEURL : " + payReqMap.LGD_CASNOTEURL);
					console.log("payreq - LGD_RESPCODE : " + payReqMap.LGD_RESPCODE);
					console.log("payreq - LGD_RESPMSG : " + payReqMap.LGD_RESPMSG);
					console.log("payreq - LGD_PAYKEY : " + payReqMap.LGD_PAYKEY);

					$('#LGD_MID').val(payReqMap.LGD_MID);
					//$('#LGD_OID').val(payReqMap.LGD_OID);
					$('#LGD_CUSTOM_SKIN').val(payReqMap.LGD_CUSTOM_SKIN);
					$('#LGD_CUSTOM_PROCESSTYPE').val(payReqMap.LGD_CUSTOM_PROCESSTYPE);
					$('#LGD_HASHDATA').val(payReqMap.LGD_HASHDATA);
					$('#LGD_RETURNURL').val(payReqMap.LGD_RETURNURL);
					$('#LGD_WINDOW_VER').val(payReqMap.LGD_WINDOW_VER);
					$('#LGD_OSTYPE_CHECK').val(payReqMap.LGD_OSTYPE_CHECK);
					$('#LGD_VERSION').val(payReqMap.LGD_VERSION);
					$('#LGD_CASNOTEURL').val(payReqMap.LGD_CASNOTEURL);
					$('#LGD_RESPCODE').val(payReqMap.LGD_RESPCODE);
					$('#LGD_RESPMSG').val(payReqMap.LGD_RESPMSG);
					$('#LGD_PAYKEY').val(payReqMap.LGD_PAYKEY);


					// 인증요청
					launchCrossPlatform();
				}
			});
		});
	});

	function LPad(digit, size, attatch) {
		var add = "";
		digit = digit.toString();

		if (digit.length < size) {
			var len = size - digit.length;
			for (i = 0; i < len; i++) {
				add += attatch;
			}
		}
		return add + digit;
	}

	function makeoid() {
		var now = new Date();
		var years = now.getFullYear();
		var months = LPad(now.getMonth() + 1, 2, "0");
		var dates = LPad(now.getDate(), 2, "0");
		var hours = LPad(now.getHours(), 2, "0");
		var minutes = LPad(now.getMinutes(), 2, "0");
		var seconds = LPad(now.getSeconds(), 2, "0");
		var timeValue = years + months + dates + hours + minutes + seconds;
		document.getElementById("LGD_OID").value = "test_" + timeValue;
		document.getElementById("LGD_TIMESTAMP").value = timeValue;
	}

	/*
     * 인증요청 처리
     */
	function doPay() {
		// OID, TIMESTAMP 생성
		makeoid();
		// 결제창 호출
		document.getElementById("LGD_PAYINFO").submit();
	}




	/*
     * 수정불가.
     */
	var CST_PLATFORM		= 'test';
	var LGD_window_type	= 'iframe';

	/*
     * 수정불가
     */
	function launchCrossPlatform(){
		lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), CST_PLATFORM, LGD_window_type, null, "", "");
	}
	/*
     * FORM 명만  수정 가능
     */
	function getFormObject() {
		return document.getElementById("LGD_PAYINFO");
	}

	/*
     * 인증결과 처리
     */
	function payment_return() {
		var fDoc;

		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;


		if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {

			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "/shop/payres";
			document.getElementById("LGD_PAYINFO").submit();
		} else {
			alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
			closeIframe();
		}
	}
</script>
