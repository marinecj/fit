<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

<div id="container" class="detail-wrap">
	<div id="contents">

		<div class="detail-top">
			<div class="col1">
				<div class="detail-slide">
					<ul>
						<li><img src="${Img}/temp/detail_top.jpg" alt="" /></li>
						<li><img src="${Img}/temp/detail_top.jpg" alt="" /></li>
						<li><img src="${Img}/temp/detail_top.jpg" alt="" /></li>
					</ul>
				</div>
			</div>
			<div class="col2">
				<h2>${detail.hotelNmKr}<p>${detail.hotelNm}</p></h2>
				<div class="base-info">
					<p>75-5660 Palani Road, 카일루아 코나, HI, 96740, 미국</p>
					<p class="e-list">
						<span>TEL : + 808 661 0031</span>
						<span>FAX : + 808 661 0031</span>
						<span>426객실</span>
					</p>
				</div>
				<div class="etc-info">
					<div class="fl">
						<span class="price"><em><fmt:formatNumber value="${hotelAllInfoList[0].roomInfo.price1Won}" pattern="#,###"/></em>원~</span>
						<p class="e-list">
							<span>1일 객실요금</span>
							<span>부가세, 봉사료를 포함한 가격</span>
						</p>
					</div>
					<div class="fr">
						<p><span class="star"><em style="width: 60%;"></em></span><span class="num"><strong> 9.0</strong>점</span></p>
						<p><span class="comment num"><strong>56</strong>건</span></p>
					</div>
				</div>
				<div class="search-data">
					<div class="date-rang-picker">
						<div class="date-inputs">
							<input type="text" class="date-range1 cal" value="2017.02.01" />
							<input type="text" class="date-range2 cal" value="2017.03.01" />
						</div>
						<div class="date-rang-layer">
							<div class="row"></div>
							<div class="gp-close-box">
								<a href="#" class="close">닫기</a>
							</div>
						</div>
					</div>
					<div class="custom-select" style="width: 93px;">
						<label><span></span></label>
						<select>
							<option>객실 1개</option>
						</select>
					</div><!-- end : select-box -->
					<div class="custom-select" style="width: 109px;">
						<label><span></span></label>
						<select>
							<option>2인실(더블)</option>
						</select>
					</div><!-- end : select-box -->
				</div>
				<div class="btn-box">
					<a href="#" class="i-btn bt-search">조건검색</a>
					<a href="#" class="i-btn bt-d-wish">관심상품 등록</a>
					<a href="#" class="i-btn bt-d-share">공유</a>
				</div>
			</div>
		</div>

		<div class="detail-info-sec">
			<div class="option-info-article">
				<ul>
					<%--<c:if test="${detail.breakfastYn == 'Y'}">
					<li class="ico-opt ty1">
						<strong>조식포함</strong>
						<p>호텔에서 제공되는 조식이<br />포함되어 있습니다.</p>
					</li>
					</c:if>--%>
					<c:if test="${detail.resortfeeYn == 'Y'}">
					<li class="ico-opt ty2">
						<strong>석식 포함</strong>
						<p>리조트피(Resort Fee)가<br />포함되어 있습니다.</p>
					</li>
					</c:if>
					<c:if test="${detail.resortfeeYn == 'Y'}">
					<li class="ico-opt ty3">
						<strong>리조트피 포함</strong>
						<p>리조트피(Resort Fee)가<br />포함되어 있습니다.</p>
					</li>
					</c:if>
					<li class="ico-opt ty4">
						<strong>룸업그레이드</strong>
						<p>예약하신 룸보다 더 좋은룸으로<br />업그레이드 해드립니다.</p>
					</li>
					<c:if test="${detail.valetParkingYn == 'Y'}">
					<li class="ico-opt ty5">
						<strong>발렛 파킹</strong>
						<p>별도의 비용없이 발렛파킹을<br />해드립니다.</p>
					</li>
					</c:if>
				</ul>
			</div><!--  end : option-info -->

			<h3>상세요금<span><strong>2016년 07월 21일 ~ 2016년 07월 22일 1박, 싱글 1실</strong> 요금조회 결과 입니다.</span></h3>
			<div class="detail-price-article">
				<div class="tb-ty1">
					<table>
						<colgroup>
							<col width="*" />
							<col width="17%" />
							<col width="18%" />
							<col width="9%" />
							<col width="17%" />
							<col width="12%" />
						</colgroup>
						<thead>
						<tr>
							<th>객실타입</th>
							<th>조식 및 리조트피</th>
							<th>혜택 및 특전</th>
							<th>예약상태</th>
							<th>오늘의 가격</th>
							<th>예약</th>
						</tr>
						</thead>
						<tbody>
<c:forEach var="room" items="${hotelAllInfoList}" varStatus="status">
						<tr>
							<td>${room.cateInfo.cateNm}<br>${room.roomInfo.typeNm}</td>
							<td class="center">
								<c:choose>
								<c:when test="${room.roomInfo.breakfastYn == 'Y'}">
									<span class="ico breakfast">조식 포함</span>
								</c:when>
								<c:otherwise>
									<span class="ico breakfast off">조식 불포함</span>
								</c:otherwise>
								</c:choose>
								<%--<c:if test="${room.resortfeeYn == 'Y'}">
								<span class="ico fee">리조트피 포함</span>
								</c:if>--%>
							</td>
							<%--<td>
								- 발렛파킹 무료<br />
								- 허니문 특전 : 스페셜 샴페인<br />
								- 10% 스파서비스 할인권
							</td>--%>
							<td>${room.cateInfo.remark}</td>
							<td class="center">
								<p class="pt1">즉시확정</p>
								<a class="hastip">취소규정</a>
								<div class="tooltip-text">
									<span class='pt1'>취소규정</span>
									<%--<p class="t1">무료취소기한 <span class='pt1'>2016년 07월 15일 16시까지</span></p>
									<p class="t2">${room.cateInfo.cancelPolicy}</p>--%>
									<p class="t1">${room.cateInfo.cancelPolicy}</p>
								</div>
							</td>
							<td>
								<div class="price">
									<p class="one-day">1박 기준 객실 요금</p>
									<p class="nop"><fmt:formatNumber value="${room.roomInfo.price1Won * 1.2}" pattern="#,###"/>원</p>
									<strong><fmt:formatNumber value="${room.roomInfo.price1Won}" pattern="#,###"/>원</strong>
								</div>
							</td>
							<td class="center"><a href="javascript:shop(${room.roomInfo.typeNo});" id="booking" class="i-btn bt-real">실시간 예약</a></td>
						</tr>
</c:forEach>
						</tbody>
					</table>
				</div>
				<ul class="tx-list-ty1">
					<li><span class="blet">-</span>검색된 요금은 베드타입의 보장이 아닌 "<span class="pt1">해당 인원수가 투숙할 수 있는 모든 객실타입의 요금</span>"입니다.<br />
						예) 트윈(2베드)을 원하시면 2개의 침대개수를 의미하는 문구가 포함된 객실타입으로 선택 부탁드리며, 자세한 사항은 객실타입을 참고하세요.
					</li>
					<li><span class="blet">-</span>규정 중 어린이 규정은 객실타입에 따라 제약이 있을 수 있으니 별도 문의 바랍니다.</li>
				</ul>
				<ul class="tel-guide">
					<li class="tel">
						<p class="t1"><em class="pt3">080-000-0000</em></p>
						<p class="t2">평일 09:00 - 18:00 / 주말 및 공휴일 휴무</p>
					</li>
					<li class="talk">
						<p class="t1">친구 등록 <em class="pt3">fithawaii</em></p>
						<p class="t2">평일 09:00 - 18:00 / 주말 및 공휴일 휴무</p>
					</li>
				</ul>
			</div>

			<h3>호텔소개</h3>
			<div class="hotel-info-article">
				Hyatt Place Waikiki Beach는 와이키키 비치와 1블럭 떨어진 곳(도보2분)에 위치하며 메리엇 와이키키 비치 리조트 바로 뒷편에 자리잡고 있다.<br />
				합리적인 요금에 호놀룰루 중심 위치와 리노베이션으로 쾌적한 숙박 환경, 조식 제공이 되어 요금대비 만족도가 높은 호텔이다.<br />
				또한 와이키키수족관, 카피올라니공원,다이아몬드헤드 분화구,아틀란티스 잠수함등 다양한 관광지가 근거리에 있어 하와이의 문화를 느끼기에 충분하다.<br /><br />
				스타일리쉬한 가구와 모던한 인테리어로 장식된 객실은 거실과 침실공간이 있는 여유있는 크기에 도시전경,산,바다등<br />
				객실별 각각의 다양한 전망을 감상할수 있는 발코니을 갖추었으며 고품질의 침대에서 기분좋은 숙면을 취할수있다.<br />
				뿐만아니라 호텔 고유의 하얏트 플러그 판넬은 투숙객의 랩탑컴퓨터,MP3 플레이어,비디오게임시스템등의 미디어기기들을<br />
				42 인치 고화질 평면 TV로 쉽게 연결이 가능하게 하며, 무료 Wi-Fi 및 고속 DSL 인터넷 연결, 화강암 세면대 등 고급스러운 설비가 편안한 투숙을 돕는다.<br /><br />
				그 외 야외수영장과 선데크, 피트니스센타가 마련되어 있고, 24시간 이용할수 있는 레스토랑 및 특제머핀과 갓구운 빵과<br />
				패스트리등을 즐길수 있는 베이커리 카페 등 다양한 다이닝 옵션이 가능하며 가족여행객들을 위하여 어린이메뉴를 마련하고 있다.<br />
				Hyatt Place Waikiki Beach는 합리적인 요금에 수준이상의 시설과 하얏트 호텔 체인의 서비스를 와이키키비치의 아름다움과 함께 경험할수 있는 탁월한 선택이 될것이다.<br /><br /><br />
				- 무료 조식 제공 (조식당 : 3층 풀사이드 , 월-금 6:30-9:30am , 토-일 6:30-10am)<br />
				- 객실종류 (전객실 소파베드가 비치되어 있으며 이동식 간이침대 추가는 불가능합니다)<br />
				- 일반 객실 최대 투숙인원 3명 ★(성인2+아동2 투숙불가)<br />
				- Diamond tower(235객실) -약 7 평~ 12평 , 객실분류 1 킹베드룸-80% , 2 퀸베드룸-20%<br />
				- City View /Mountian View/Ocean View 로 구분<br />
				- 전 객실 King Bed<br />
				- 전 객실 100% 금연호텔 입니다. (호텔 로비밖으로 나오셔서 흡연은 가능합니다.)<br />
				- 객실내 화장솜. 로션, 샤워캡, 치약, 여성용품, 바늘쌈지, 귀마개, 슈(구두)스폰지 등 다양한 비품들이 마련되어 있습니다. 그 외 다양한 용품의 구입이 가능합니다.<br />
				- 인터넷 사용 : 객실 및 건물 내에서 Wi-Fi 무료 사용가능(프론트에서 게스트전용 ID와 PW 제공) (유선인터넷은 불가)<br />
				- 주차 : $30 / 24hours (Self Parking will be $18 per night (based on space availability), and Valet Parking will be $28 per night.)<br />
				- 체크인 : 오후 15:00 이후 / 체크아웃 : 오전 11시 이전<br />
				- 홈페이지 : <a href="#" target="_blank">http://www.hyattplacewaikikibeach.com</a><br /><br />
				* 상기 내용은 호텔측의 고지 없이 변경될 수 있습니다.
			</div>

			<h3>호텔사진</h3>
			<div class="hotel-photo-article">
				<div class="hp-photo">
					<ul>
<c:forEach begin="1" end="10" varStatus="status">
						<li><img src="${Img}/data/${detail.hotelNo}/${status.count}.jpg"<%-- alt="873*552"--%> /></li>
</c:forEach>
					</ul>
				</div>
				<div class="hp-pager">
<c:forEach begin="1" end="10" varStatus="status">
					<a href="#"><img src="${Img}/data/${detail.hotelNo}/${status.count}_thum.jpg"<%-- alt="100*100"--%> /></a>
</c:forEach>
				</div>
			</div>

			<h3>시설안내</h3>
			<div class="facilities-guide-article">
				<dl>
					<dt>호텔 부대 시설</dt>
					<dd>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
					</dd>
					<dd>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
					</dd>
					<dd>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
					</dd>
				</dl>
				<dl>
					<dt>객실 편의 시설</dt>
					<dd>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
					</dd>
					<dd>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
						<span>- 수영장</span>
					</dd>
					<dd>
						<span>- 수영장</span>
						<span>- 수영장</span>
					</dd>
				</dl>
			</div>

			<h3>위치정보</h3>
			<div class="location-article">
				<div class="map-box"><img src="${Img}/temp/detail_map.jpg" alt="550*410" /></div>
				<dl>
					<dt>주소</dt>
					<dd>75-5660 Palani Road, 카일루아 코나, HI, 96740, 미국</dd>
					<dd>TEL : + 808 661 0031</dd>
					<dt>교통</dt>
					<dd>- 공항 Honolulu International Airport (HNL)- 16km</dd>
					<dd>- 공항에서 택시 이용시 약 $45-50</dd>
					<dd>- 호텔에서 운영하는 픽업서비스 및 셔틀서비스 없음</dd>
					<dt>위치</dt>
					<dd>- 메리엇 와이키키 비치 리조트 바로 뒷편에 위치</dd>
					<dd>- 와이키키 해변에서 도보 10분 거리</dd>
					<dd>- Paoakalani 및 Kuhio 애비뉴의 코너에 위치</dd>
					<dd>- Hawaii Convention Center - 3.6km</dd>
					<dd>- 알라모아나 쇼핑센터 - 3.6km</dd>
					<dd>- 호놀룰루 동물원, 와이키키 수족관등이 도보거리</dd>
					<dd>- 108에이커에 달하는 Kapiolani 공원 - 1.6km</dd>
					<dd>- 다이아몬드 헤드 분화구 - 2.4km</dd>
				</dl>
			</div>

			<h3>핏하와이 리뷰</h3>
			<div class="review-article">
				<div class="review-head">
					<div class="grade-info">
						<div class="item">
							<span class="tit">접근성</span>
							<span class="grade"><em style="width: 93%;"></em></span>
							<span class="num"><strong>9.3</strong>점</span>
						</div>
						<div class="item">
							<span class="tit">부대시설</span>
							<span class="grade"><em style="width: 93%;"></em></span>
							<span class="num"><strong>9.3</strong>점</span>
						</div>
						<div class="item">
							<span class="tit">객실시설</span>
							<span class="grade"><em style="width: 88%;"></em></span>
							<span class="num"><strong>8.8</strong>점</span>
						</div>
						<div class="item">
							<span class="tit">서비스</span>
							<span class="grade"><em style="width: 88%;"></em></span>
							<span class="num"><strong>8.8</strong>점</span>
						</div>
					</div>
					<div class="total-grade">
						<span class="tit">평점</span>
						<span class="star"><em style="width: 60%;"></em></span>
						<p class="num">총 리뷰 <strong>56</strong>건 기준</p>
						<span class="total"><strong>9.0</strong></span>
					</div>
				</div>
				<div class="review-write">
					<div class="star-rating-box">
						<div class="item">
							<div class="star-rating" data-base-score="<c:out value="${review.star1 == null ? '5' : review.star1}"/>">
								<span class="tit">접근성</span>
								<div class="star">
									<em></em>
									<a href="#" data-num="1">1점</a>
									<a href="#" data-num="2">2점</a>
									<a href="#" data-num="3">3점</a>
									<a href="#" data-num="4">4점</a>
									<a href="#" data-num="5">5점</a>
								</div>
								<strong class="num"><input id="star1" type="text" disabled="disabled" />점</strong>
							</div>
						</div>
						<div class="item">
							<div class="star-rating" data-base-score="<c:out value="${review.star2 == null ? '5' : review.star2}"/>">
								<span class="tit">부대시설</span>
								<div class="star">
									<em></em>
									<a href="#" data-num="1">1점</a>
									<a href="#" data-num="2">2점</a>
									<a href="#" data-num="3">3점</a>
									<a href="#" data-num="4">4점</a>
									<a href="#" data-num="5">5점</a>
								</div>
								<strong class="num"><input id="star2" type="text" disabled="disabled" />점</strong>
							</div>
						</div>
						<div class="item">
							<div class="star-rating" data-base-score="<c:out value="${review.star3 == null ? '5' : review.star3}"/>">
								<span class="tit">객실시설</span>
								<div class="star">
									<em></em>
									<a href="#" data-num="1">1점</a>
									<a href="#" data-num="2">2점</a>
									<a href="#" data-num="3">3점</a>
									<a href="#" data-num="4">4점</a>
									<a href="#" data-num="5">5점</a>
								</div>
								<strong class="num"><input id="star3" type="text" disabled="disabled" />점</strong>
							</div>
						</div>
						<div class="item">
							<div class="star-rating" data-base-score="<c:out value="${review.star4 == null ? '5' : review.star4}"/>">
								<span class="tit">서비스</span>
								<div class="star">
									<em></em>
									<a href="#" data-num="1">1점</a>
									<a href="#" data-num="2">2점</a>
									<a href="#" data-num="3">3점</a>
									<a href="#" data-num="4">4점</a>
									<a href="#" data-num="5">5점</a>
								</div>
								<strong class="num"><input id="star4" type="text" disabled="disabled" />점</strong>
							</div>
						</div>
						<div class="item total-num"><strong>평점 <input type="text" disabled="disabled" id="review-star-total" > 점</strong></div>
					</div>
					<div class="txt-box">
						<textarea id="comment" rows="5" placeholder="${review.comment == null ? '리뷰를 입력하세요.' : review.comment}"><c:out value="${review.comment == null ? '' : review.comment}"/></textarea>
						<p class="etc"><a href="#">이미지 첨부하기</a></p>
					</div>
					<div class="btn-box">
						<a href="javascript:review();" class="i-btn bt-review">리뷰작성</a>
					</div>
				</div>
				<div class="d-review-list">
					<ul>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<div class="info">
								<p class="name">Waiiki_Moderate</p>
								<p class="date">2016. 05. 26</p>
								<div class="txt-box">
									오늘은 하와이호텔중 많은분들이 추천하는 하와이 하얏트리젠시를 포스팅한다. 예전 포스팅을 보면은 하와이
									하얏트리젠시의 경우 실내가 낙후 되었다고 하는분들도 많은데...지금은 리모델링을 해서 그런지 전혀 그런것
									을 느낄수가 없다.나는 만약 다시 하와이를 간다면 하와이호텔은 하얏트리젠시로 ㅎㅎ그만큼 하와이호텔
									추천한다!ㅎ<br /><br />
									하와이 하얏트리젠시는 에바타워와 아이아몬트 타워로 나누어집니다.<br />
									하와이 호텔로 추천하는 확실한 이유는 뷰와 신호등 하나만 건너가면 바로 바다~<br />
									나와서 오른쪽으로 가면 갤러리아 백화점등 쇼핑센터가 왼쪽은 호텔촌? 먹거리가 많아서 리젠시가 하와이<br />
									호텔로 추천받는다.
								</div>
							</div>
							<div class="grade-info">
								<div class="item"><span class="star"><em style="width: 60%;"></em></span><span class="num">평점 <strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">접근성</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">부대시설</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">객실시설</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
								<div class="item"><span class="tit">서비스</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
							</div>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<div class="info">
								<p class="name">Waiiki_Moderate</p>
								<p class="date">2016. 05. 26</p>
								<div class="txt-box">
									오늘은 하와이호텔중 많은분들이 추천하는 하와이 하얏트리젠시를 포스팅한다. 예전 포스팅을 보면은 하와이
									하얏트리젠시의 경우 실내가 낙후 되었다고 하는분들도 많은데...지금은 리모델링을 해서 그런지 전혀 그런것
									을 느낄수가 없다.나는 만약 다시 하와이를 간다면 하와이호텔은 하얏트리젠시로 ㅎㅎ그만큼 하와이호텔
									추천한다!ㅎ<br /><br />
									하와이 하얏트리젠시는 에바타워와 아이아몬트 타워로 나누어집니다.<br />
									하와이 호텔로 추천하는 확실한 이유는 뷰와 신호등 하나만 건너가면 바로 바다~<br />
									나와서 오른쪽으로 가면 갤러리아 백화점등 쇼핑센터가 왼쪽은 호텔촌? 먹거리가 많아서 리젠시가 하와이<br />
									호텔로 추천받는다.<br /><br />
									<img src="${Img}/temp/hp_photo.jpg" alt="" />
								</div>
							</div>
							<div class="grade-info">
								<div class="item"><span class="star"><em style="width: 60%;"></em></span><span class="num">평점 <strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">접근성</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">부대시설</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">객실시설</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
								<div class="item"><span class="tit">서비스</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
							</div>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<div class="info">
								<p class="name">Waiiki_Moderate</p>
								<p class="date">2016. 05. 26</p>
								<div class="txt-box">
									오늘은 하와이호텔중 많은분들이 추천하는 하와이 하얏트리젠시를 포스팅한다. 예전 포스팅을 보면은 하와이
									하얏트리젠시의 경우 실내가 낙후 되었다고 하는분들도 많은데...지금은 리모델링을 해서 그런지 전혀 그런것
									을 느낄수가 없다.나는 만약 다시 하와이를 간다면 하와이호텔은 하얏트리젠시로 ㅎㅎ그만큼 하와이호텔
									추천한다!ㅎ<br /><br />
									하와이 하얏트리젠시는 에바타워와 아이아몬트 타워로 나누어집니다.<br />
									하와이 호텔로 추천하는 확실한 이유는 뷰와 신호등 하나만 건너가면 바로 바다~<br />
									나와서 오른쪽으로 가면 갤러리아 백화점등 쇼핑센터가 왼쪽은 호텔촌? 먹거리가 많아서 리젠시가 하와이<br />
									호텔로 추천받는다.
								</div>
							</div>
							<div class="grade-info">
								<div class="item"><span class="star"><em style="width: 60%;"></em></span><span class="num">평점 <strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">접근성</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">부대시설</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">객실시설</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
								<div class="item"><span class="tit">서비스</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
							</div>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<div class="info">
								<p class="name">Waiiki_Moderate</p>
								<p class="date">2016. 05. 26</p>
								<div class="txt-box">
									오늘은 하와이호텔중 많은분들이 추천하는 하와이 하얏트리젠시를 포스팅한다. 예전 포스팅을 보면은 하와이
									하얏트리젠시의 경우 실내가 낙후 되었다고 하는분들도 많은데...지금은 리모델링을 해서 그런지 전혀 그런것
									을 느낄수가 없다.나는 만약 다시 하와이를 간다면 하와이호텔은 하얏트리젠시로 ㅎㅎ그만큼 하와이호텔
									추천한다!ㅎ<br /><br />
									하와이 하얏트리젠시는 에바타워와 아이아몬트 타워로 나누어집니다.<br />
									하와이 호텔로 추천하는 확실한 이유는 뷰와 신호등 하나만 건너가면 바로 바다~<br />
									나와서 오른쪽으로 가면 갤러리아 백화점등 쇼핑센터가 왼쪽은 호텔촌? 먹거리가 많아서 리젠시가 하와이<br />
									호텔로 추천받는다.
								</div>
							</div>
							<div class="grade-info">
								<div class="item"><span class="star"><em style="width: 60%;"></em></span><span class="num">평점 <strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">접근성</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">부대시설</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">객실시설</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
								<div class="item"><span class="tit">서비스</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
							</div>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<div class="info">
								<p class="name">Waiiki_Moderate</p>
								<p class="date">2016. 05. 26</p>
								<div class="txt-box">
									오늘은 하와이호텔중 많은분들이 추천하는 하와이 하얏트리젠시를 포스팅한다. 예전 포스팅을 보면은 하와이
									하얏트리젠시의 경우 실내가 낙후 되었다고 하는분들도 많은데...지금은 리모델링을 해서 그런지 전혀 그런것
									을 느낄수가 없다.나는 만약 다시 하와이를 간다면 하와이호텔은 하얏트리젠시로 ㅎㅎ그만큼 하와이호텔
									추천한다!ㅎ<br /><br />
									하와이 하얏트리젠시는 에바타워와 아이아몬트 타워로 나누어집니다.<br />
									하와이 호텔로 추천하는 확실한 이유는 뷰와 신호등 하나만 건너가면 바로 바다~<br />
									나와서 오른쪽으로 가면 갤러리아 백화점등 쇼핑센터가 왼쪽은 호텔촌? 먹거리가 많아서 리젠시가 하와이<br />
									호텔로 추천받는다.<br /><br />
									<img src="${Img}/temp/hp_photo.jpg" alt="" />
								</div>
							</div>
							<div class="grade-info">
								<div class="item"><span class="star"><em style="width: 60%;"></em></span><span class="num">평점 <strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">접근성</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">부대시설</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">객실시설</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
								<div class="item"><span class="tit">서비스</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
							</div>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<div class="info">
								<p class="name">Waiiki_Moderate</p>
								<p class="date">2016. 05. 26</p>
								<div class="txt-box">
									오늘은 하와이호텔중 많은분들이 추천하는 하와이 하얏트리젠시를 포스팅한다. 예전 포스팅을 보면은 하와이
									하얏트리젠시의 경우 실내가 낙후 되었다고 하는분들도 많은데...지금은 리모델링을 해서 그런지 전혀 그런것
									을 느낄수가 없다.나는 만약 다시 하와이를 간다면 하와이호텔은 하얏트리젠시로 ㅎㅎ그만큼 하와이호텔
									추천한다!ㅎ<br /><br />
									하와이 하얏트리젠시는 에바타워와 아이아몬트 타워로 나누어집니다.<br />
									하와이 호텔로 추천하는 확실한 이유는 뷰와 신호등 하나만 건너가면 바로 바다~<br />
									나와서 오른쪽으로 가면 갤러리아 백화점등 쇼핑센터가 왼쪽은 호텔촌? 먹거리가 많아서 리젠시가 하와이<br />
									호텔로 추천받는다.
								</div>
							</div>
							<div class="grade-info">
								<div class="item"><span class="star"><em style="width: 60%;"></em></span><span class="num">평점 <strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">접근성</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">부대시설</span><span class="grade"><em style="width: 93%;"></em></span><span class="num"><strong>9.3</strong>점</span></div>
								<div class="item"><span class="tit">객실시설</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
								<div class="item"><span class="tit">서비스</span><span class="grade"><em style="width: 88%;"></em></span><span class="num"><strong>8.8</strong>점</span></div>
							</div>
						</li>
					</ul>
				</div>
				<div class="paging">
					<a href="#" class="btn first">처음</a>
					<a href="#" class="btn prev">이전</a>
					<a href="#">1</a>
					<a href="#">2</a>
					<a href="#" class="active">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#" class="btn next">다음</a>
					<a href="#" class="btn last">마지막</a>
					<span class="total">총 <em>10</em>건(<em>1</em>/1page)</span>
				</div><!-- end : paging -->
			</div>
		</div><!--  end : detail-info-sec -->

	</div><!-- end : #contents -->

</div><!-- end : #container -->


<div class="sticky">
	<div class="in-wrap">
		<span class="price"><strong>440,961</strong>원</span>
		<ul class="sch-data">
			<li><span>2017.12.13~2017.12.25</span></li>
			<li>
				<span>12박</span>
				<span>싱글 1실</span>
			</li>
		</ul>
		<div class="search-data">
			<div class="date-rang-picker">
				<div class="date-inputs">
					<input type="text" class="date-range1 cal" value="2017.02.01" />
					<input type="text" class="date-range2 cal" value="2017.03.01" />
				</div>
			</div>
			<div class="custom-select" style="width: 93px;">
				<label><span></span></label>
				<select>
					<option>객실 1개</option>
				</select>
			</div><!-- end : select-box -->
			<div class="custom-select" style="width: 109px;">
				<label><span></span></label>
				<select>
					<option>2인실(더블)</option>
				</select>
			</div><!-- end : select-box -->
		</div>
		<div class="btn-box">
			<a href="#" class="i-btn bt-search-st">조건검색</a>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/include/javascripts.jsp" %>

<script>
	$(".detail-slide ul").bxSlider({speed: 600, auto: true, autoControls:false});

	var hpSlider = $('.hp-photo ul').bxSlider({mode: 'fade', speed: 0, auto: false, autoControls:false, controls:false});
	$(".hp-pager a").each(function(i){
		$(this).append("<span></span>")
		if(hpSlider.getCurrentSlide()==i){$(this).addClass("act");}
		$(this).off("click").on("click", function(){
			$(this).siblings().removeClass("act")
			hpSlider.goToSlide(i);
			$(this).addClass("act");
			return false;
		});
	});

	ui.toggle($(".d-review-list li"));
	$('.hastip').tooltipsy({
		offset: [0, -10],
		content: function($el, $tip){
			$tip.html($el.siblings(".tooltip-text").html());
		}
	});
	ui.starRating();

    function review() {
        var htParam = {
            "hotelNo" : "${detail.hotelNo}",
            "star1" : $('#star1').val(),
            "star2" : $('#star2').val(),
            "star3" : $('#star3').val(),
            "star4" : $('#star4').val(),
            "comment" : $('#comment').val()
        };

        var _oRequest = $.ajax({
            type : "POST",
            url : "/review",
            cache : false,
            data : {
                "json":JSON.stringify(htParam)
            },
            error : function(request,status,error) {
                if (error != "") {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
                _oRequest = null;
            },
            complete : function(oRes) {
                console.log("status:" + oRes.status + ", responseText:" + oRes.responseText);
                alert("리뷰가 등록되었습니다.");
            }
        });
    }
</script>
