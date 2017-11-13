<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

<p><h1>RETURN_URL (인증결과)</h1></p>
<div>
	<p>LGD_RESPCODE (결과코드) : <c:out value="${PAYREQ_MAP.LGD_RESPCODE}"/></p>
	<p>LGD_RESPMSG (결과메시지): <c:out value="${PAYREQ_MAP.LGD_RESPMSG}"/></p>
</div>
<form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO">
	<c:forEach items="${PAYREQ_MAP}" var="payReqMap" varStatus="status">
		<input type='hidden' name='${payReqMap.key}' id='${payReqMap.key}' value='${payReqMap.value}'>
	</c:forEach>
</form>

<div id="container" class="col-group-wrap">
	<div id="contents">

		<div class="col-group">
			<div class="left-menu">
				<div class="my-profile">
					<div class="photo"></div>
					<a href="#" class="i-btn bt-photo-add"></a>
					<p class="mail"><a href="mailto:fithawaiihotel@gmail.com">fithawaiihotel@gmail.com</a></p>
				</div>
				<ul>
					<li><a href="#" class="act">구매 내역</a></li>
					<li><a href="#">지난 구매 내역</a></li>
					<li><a href="#">관심 상품</a></li>
				</ul>
				<ul>
					<li><a href="#">회원 정보</a></li>
					<li><a href="#">포인트</a></li>
					<li><a href="#">문의내역</a></li>
				</ul>
			</div><!-- end : .left-menu -->

			<div class="con-section">
				<h2 class="sr-only">마이페이지</h2>

				<h3>구매 내역 상세</h3>
				<div class="my-buy-top">
					<div class="item">
						<span class="label">호텔 이름</span>
						<p class="line"><c:out value="${PAYREQ_MAP.LGD_PRODUCTINFO}"/></p>
					</div>
					<div class="item">
						<span class="label">호텔 주소</span>
						<p>75-5660 Palani Road, 카일루아 코나, HI, 96740, 미국</p>
						<p>TEL : + 808 661 0031    FAX : + 808 661 0031    426객실</p>
					</div>
				</div>

				<h4>숙박 정보</h4>
				<div class="tb-ty4">
					<table>
						<colgroup>
							<col width="164px" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th>객실</th>
							<td>Two Queens bed</td>
						</tr>
						<tr>
							<th>숙박 일정</th>
							<td>201C7년 1월 29일 -  2017년 2월 2일</td>
						</tr>
						<tr>
							<th>숙박 일수</th>
							<td>5박</td>
						</tr>
						<tr>
							<th>숙박 인원</th>
							<td>성인 : <span class="pt1">2명</span> ,  어린이/청소년 : <span class="pt1">2명</span>, 나이 : 10,11세</td>
						</tr>
						<tr>
							<th>요청 사항</th>
							<td>금연, 싱글침대 2개</td>
						</tr>
						<tr>
							<th>특전 사항</th>
							<td><span class="pt1">2인 조식 포함, 리조트피 무료, 발렛파킹, 허니문 샴페인 1병 무료</span></td>
						</tr>
						</tbody>
					</table>
				</div>

				<h4>투숙객 정보</h4>
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
							<td colspan="7">KIM SUMI<span class="tel">010 - ***  - 2341</span></td>
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
							<td>김수미</td>
							<td>SUMI</td>
							<td>KIM</td>
							<td>F</td>
							<td>38</td>
						</tr>
						<tr>
							<td>2</td>
							<td>김수미</td>
							<td>SUMI</td>
							<td>KIM</td>
							<td>M</td>
							<td>38</td>
						</tr>
						</tbody>
					</table>
				</div>

				<h4>예약자 정보</h4>
				<div class="tb-ty4">
					<table>
						<colgroup>
							<col width="164px" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th>아이디</th>
							<td>sumimakig</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><c:out value="${PAYREQ_MAP.LGD_BUYEREMAIL}"/></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>010-****-234</td>
						</tr>
						</tbody>
					</table>
				</div>

				<h4>결제 정보</h4>
				<div class="tb-ty4">
					<table>
						<colgroup>
							<col width="164px" />
							<col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th>청구 이름</th>
							<td><c:out value="${PAYREQ_MAP.LGD_BUYER}"/></td>
						</tr>
						<tr>
							<th>카드 종류</th>
							<td>Visa</td>
						</tr>
						<tr>
							<th>카드 번호</th>
							<td>XXXXXXXXXXXX4309</td>
						</tr>
						<tr>
							<th>최종 결제 금액</th>
							<td><strong class="pt1">3,560,000원</strong></td>
						</tr>
						</tbody>
					</table>
				</div>

				<h4>취소 정보</h4>
				<div class="my-detail-info">
					<ul>
						<li class="pt1">- 무료 취소 기한 : 2017년 1월 2일</li>
						<li>- 2017년 1월 2일 오후 6:00((GMT-10:00) Hawaii) 이후에 예약을 변경하거나 취소하시는 경우 2박에 해당하는 요금(세금 포함)이<br />수수료로 부과됩니다.</li>
						<li>- 예약 후 오지 않거나 예정보다 일찍 체크아웃하는 경우 환불해 드리지 않습니다.</li>
					</ul>
				</div>

				<h4>추가 정보</h4>
				<div class="my-detail-info">
					<dl>
						<dt>체크인</dt>
						<dd>숙박 시설 정책에 따라 추가 인원에 대한 요금이 부과될 수 있습니다. 체크인 시 부대 비용 발생에 대비해 정부에서 발급한 사진이 부착된 신분증과 신용카드 또는 현금으로 보증금이 필요합니다. 고객이 별도로 요청한 사항은 체크인 시 가능한 경우에 한하여 제공되며 추가 요금이 부과될 수 있습니다. 또한, 반드시 보장되지는 않습니다.</dd>
						<dt>중요 공지 사항</dt>
						<dd>23:00 이후에 도착 예정이신 경우에는 예약 확인에 나와 있는 연락처로 미리 숙박 시설에 연락해 주시기 바랍니다.<br />도시세는 숙박 시설에서 수납합니다.</dd>
						<dt>대표적인 편의 시설</dt>
						<dd>식사 공간으로는 호텔에 있는 3 개의 레스토랑 중 한 곳을 이용하실 수 있으며, 숙박 고객께서는 2 개의 커피숍/카페 중 한 곳에서 커피를 드실 수 있습니다. 또한, 숙박 시설에는 식료품점/편의점도 있습니다. 초고속 유선 및 무선 인터넷을 무료로 이용하실 수 있습니다. 또한, 호롤루루에 위치한 이 호텔에는 스파 서비스, 세탁 시설, 드라이클리닝/세탁 서비스 등이 마련되어 있습니다.<br />시설 내 주차장을 이용하실 수 있습니다.(요금 별도)</dd>
						<dt>공지사항 및 요금안내</dt>
						<dd>셀프 주차 요금은 1박 기준, $ 24</dd>
						<dt>호텔 이용약관</dt>
						<dd>숙박 시설 정책에 따라 추가 인원에 대한 요금이 부과될 수 있습니다. 체크인 시 부대 비용 발생에 대비해 정부에서 발급한 사진이 부착된 신분증과 신용카드 또는 현금으로 보증금이 필요합니다. 고객이 별도로 요청한 사항은 체크인 시 가능한 경우에 한하여 제공되며 추가 요금이 부과될 수 있습니다. 또한, 반드시 보장되지는 않습니다. </dd>
					</dl>
				</div>
			</div><!-- end : .con-section -->
		</div><!-- end : .col-group -->

	</div><!-- end : #contents -->
</div><!-- end : #container -->

<%@ include file="/WEB-INF/jsp/include/javascripts.jsp" %>

<script>
	$(document).ready(function () {
		parent.payment_return();
		try {
		} catch (e) {
			alert(e.message);
		}
	});
</script>