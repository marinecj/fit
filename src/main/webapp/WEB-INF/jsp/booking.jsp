<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

	<div id="contents">

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
						<span class="label">총 결제 금액</span><p class="pt1"><fmt:formatNumber value="${hotelAllInfo.roomInfo.price1}"  pattern="0"/>원</p>
					</dd>
				</dl>
				<div class="btn-box">
					<a href="#" class="i-btn bt-payment">결재하기</a>
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
						<p>75-5660 Palani Road, 카일루아 코나, HI, 96740, 미국</p>
						<p>TEL : + 808 661 0031    FAX : + 808 661 0031    426객실</p>
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
							<td><input type="text" placeholder="입력해주세요" style="width: 234px;" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" placeholder="입력해주세요" style="width: 234px;" />
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

	</div><!-- end : #contents -->

<div class="map-wrap">지도앱 작업</div>

<%@ include file="/WEB-INF/jsp/include/javascripts.jsp" %>

<script>
	$(document).ready(function () {
		$("body").scrollTop(0);

		var floatPosition = parseInt($(".res-payment-info").css('top'));
		var h = $("#contents").offset().top +$("#contents").height()-$(".res-payment-info").height()-118;
		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var newPosition=scrollTop + floatPosition;
			if(newPosition>h){newPosition = h;}else if(newPosition<0){newPosition = 0;}
			$(".res-payment-info").stop().animate({"top" : newPosition + "px"}, 300);
		}).scroll();
	});
</script>
