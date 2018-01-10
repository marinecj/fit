<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

	<div class="front-visual">
		<div class="fv-slides">
			<ul>
				<li style="background-image: url('${Img}/temp/main_visual.jpg')">
					<p class="tx1">하와이 호텔의 모든것! 핏하와이</p>
					<p class="tx2"><span>취향에 맞는 호텔 객실을 더 많은 혜택과 함께 경험해 보세요.</span></p>
				</li>
				<li style="background-image: url('${Img}/temp/main_visual.jpg')">
					<p class="tx1">하와이 호텔의 모든것! 핏하와이</p>
					<p class="tx2"><span>취향에 맞는 호텔 객실을 더 많은 혜택과 함께 경험해 보세요.</span></p>
				</li>
				<li style="background-image: url('${Img}/temp/main_visual.jpg')">
					<p class="tx1">하와이 호텔의 모든것! 핏하와이</p>
					<p class="tx2"><span>취향에 맞는 호텔 객실을 더 많은 혜택과 함께 경험해 보세요.</span></p>
				</li>
			</ul>
		</div>
	</div>
	<div id="container" class="main-wrap">
		<div id="contents">
			<div class="search-sec">
				<div class="row-group">
					<div class="keyword-input">
						<input type="text" id="keyword" maxlength="10" data-placeholder="어떤 스타일의 호텔을 원하세요?" placeholder="어떤 스타일의 호텔을 원하세요?" />
						<div class="ui-autocomplete-wrap">
							<div class="other">
								<span><a href="javascript:region('오하후');">오하후</a></span>
								<span><a href="javascript:region('마우이');">마우이</a></span>
								<span><a href="javascript:region('빅아일랜드');">빅아일랜드</a></span>
								<span><a href="javascript:region('카우아이');">카우아이</a></span>
							</div>
						</div>
					</div>
					<div class="date-rang-picker">
						<input type="hidden" id="startDate" />
						<input type="hidden" id="endDate" />
						<button><span><em data-txt="체크인"></em></span><span><em data-txt="체크아웃"></em></span></button>
						<div class="date-rang-layer">
							<div class="row"></div>
							<div class="gp-close-box">
								<a href="#" class="close">닫기</a>
							</div>
						</div>
					</div>
					<div class="guest-picker">
						<button type="button" class="guest-trigger">
							<span class="tt">숙박 인원</span>
							<span class="num">총 <em id="totalCnt"></em>명</span>
						</button>
						<div class="guest-picker-layer" style="display: none;">
							<div class="row" data-idx="0" data-min="2" data-max="15">
								<div class="label">
									<span>어른</span><input type="text" id="adultCnt" readonly />
								</div>
								<div class="spinner-btn">
									<button type="button" class="minus">빼기</button>
									<button type="button" class="plus">더하기</button>
								</div>
							</div>
							<div class="row" data-idx="1" data-min="0" data-max="5">
								<div class="label">
									<span>청소년(25개월~12살)</span><input type="text" id="youthCnt" readonly />
								</div>
								<div class="spinner-btn">
									<button type="button" class="minus">빼기</button>
									<button type="button" class="plus">더하기</button>
								</div>
							</div>
							<div class="row" data-idx="2" data-min="0" data-max="5">
								<div class="label">
									<span>유아(24개월미만)</span><input type="text" id="babyCnt" readonly />
								</div>
								<div class="spinner-btn">
									<button type="button" class="minus">빼기</button>
									<button type="button" class="plus">더하기</button>
								</div>
							</div>
							<div class="gp-close-box">
								<a href="#" class="close">닫기</a>
							</div>
						</div>
					</div>
					<button class="i-btn bt-sch" id="search_submit">검색</button>
				</div>
			</div>

			<div class="today-sec">
				<h2>오늘의 FIT한 가격</h2>
				<h3>핏하와이가 추천하는 금주의 호텔</h3>
				<div class="goods-list" data-over-ty="1">
					<ul>
						<c:forEach items="${hotelRecommendInfoList}" var="result" varStatus="status">
							<li>
								<a href="javascript:detail('${result.hotelInfo.hotelNo}');">
									<div class="photo-box">
										<div class="photo"><img src="${Img}/data/${detail.hotelNo}/list.jpg" alt="${result.hotelInfo.hotelNmKr}" /></div>
										<div class="flag"><em>FITPRICE</em><strong>1박당 5만원 할인</strong></div>
									</div>
									<div class="info-box">
										<div class="t1">${result.hotelInfo.hotelNmKr}</div>
										<div class="t2">${result.hotelInfo.hotelNm}</div>
										<div class="tag">
											<c:if test="${result.detailInfo.resortfeeYn == 'Y'}"><span><em class="i1">리조트피 포함</em></span></c:if>
											<c:if test="${result.roomInfo.breakfastYn == 'Y'}"><span><em class="i2">조식 포함</em></span></c:if>
											<c:if test="${result.detailInfo.grade == '5성급'}"><span><em class="i3">5성급 호텔</em></span></c:if>
										</div>
										<div class="price">
											<p class="p1"><em><fmt:formatNumber value="${result.roomInfo.price1Won * 1.2}" pattern="#,###"/>원</em>(20%DC)</p>
											<p class="p2"><strong><fmt:formatNumber value="${result.roomInfo.price1Won}" pattern="#,###"/></strong>원</p>
										</div>
										<div class="etc">
											<span>리뷰 <em>56</em>건</span>
											<span>평점 <em>9.0</em>점</span>
										</div>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="best-sec">
				<h2>FIT한 호텔 베스트 컬렉션</h2>
				<h3>가격도 구성도 내게 꼭 맞는 하와이 호텔을 만나보세요.</h3>
				<div class="fit-list" data-over-ty="2">
					<ul>
						<li class="ty2">
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best1.png" alt="725*350" /></div>
								<div class="info">
									<p class="t1">나에게 꼭 맞는 신혼여행</p>
									<p class="t2">달콤한 허니문을 위한 맞춤형 호텔 모음</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best2.png" alt="350*350" /></div>
								<div class="info">
									<p class="t1">빅아일랜드</p>
									<p class="t2">살아있는 화산속 씨크릿 호텔</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best3.png" alt="350*350" /></div>
								<div class="info">
									<p class="t1">마우이 호텔</p>
									<p class="t2">마우이 호텔 초특가 모음</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best4.png" alt="350*350" /></div>
								<div class="info">
									<p class="t1">오하우 호텔</p>
									<p class="t2">오하우가 들썩 들썩~ 핫한 호텔</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best5.png" alt="350*350" /></div>
								<div class="info">
									<p class="t1">패밀리 호텔</p>
									<p class="t2">가족여행을 준비중이시라면</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best6.png" alt="350*350" /></div>
								<div class="info">
									<p class="t1">요즘 대세!</p>
									<p class="t2">따끈따끈한 신상호텔</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
						<li class="ty2">
							<a href="#">
								<div class="photo"><img src="${Img}/main/fit_best7.png" alt="725*350" /></div>
								<div class="info">
									<p class="t1">골프투어 호텔</p>
									<p class="t2">골프투어에 FIT한 호텔 모음</p>
									<p class="price"><strong>445,920</strong><span>원~</span></p>
									<p class="t3"><span class="ico-num">12개의 상품</span></p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="sp-event-sec">
				<h2>아주 특별한 이벤트</h2>
				<h3>핏하와이는 현실적인 보상이벤트를 통해 혜택을 드립니다.</h3>
				<div class="fit-list">
					<ul>
						<li class="ty2">
							<a href="#">
								<div class="photo"><img src="${Img}/main/sp_event1.jpg" alt="725*350" /></div>
								<div class="info">
									<p class="t4">마일리지를 사용하실 수 없다구요? </p>
									<p class="t2">사용하지도 못하는 적립금은 이제 그만~<br />핏하와이에서는 결재시 바로 사용하실 수 있는 적립금을 드립니다. </p>
									<p class="t3"><span class="ico-detail">자세히보기</span></p>
								</div>
							</a>
						</li>
						<li>
							<a href="#">
								<div class="photo"><img src="${Img}/main/sp_event2.jpg" alt="350*350" /></div>
								<div class="info">
									<p class="t4">사진후기 이벤트</p>
									<p class="t2">이용후기 남기고 사은품도 챙기고~</p>
									<p class="t3"><span class="ico-comment">12개의 후기</span></p>
								</div>
							</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="review-sec">
				<h2>핏하와이 리뷰</h2>
				<h3>핏하와이를 이용하신 고객님의 생생 후기</h3>
				<div class="review-list">
					<ul>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<p class="name">Waiiki_Moderate</p>
							<span class="star"><em style="width: 40%;"></em></span>
							<a href="#">이번 여행은 전체적으로 편안한 휴식을 느끼는 시간이었습니다. 아름다운 봄빛과 붐비지 않은 여유로움이  좋았고 ...</a>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<p class="name">Waiiki_Moderate</p>
							<span class="star"><em style="width: 60%;"></em></span>
							<a href="#">이번 여행은 전체적으로 편안한 휴식을 느끼는 시간이었습니다. 아름다운 봄빛과 붐비지 않은 여유로움이  좋았고 ...</a>
						</li>
						<li>
							<div class="photo">
								<img src="${Img}/temp/review_photo.jpg" alt="" />
								<span class="bg"></span>
							</div>
							<p class="name">Waiiki_Moderate</p>
							<span class="star"><em style="width: 80%;"></em></span>
							<a href="#">이번 여행은 전체적으로 편안한 휴식을 느끼는 시간이었습니다. 아름다운 봄빛과 붐비지 않은 여유로움이  좋았고 ...</a>
						</li>
					</ul>
				</div>
			</div>
		</div><!-- end : #contents -->
	</div>

<%@ include file="/WEB-INF/jsp/include/javascripts.jsp" %>

<script>
	$(document).ready(function () {
		$("#search_submit").click(function() {

			var htParam = {
				"keyword" : $('#keyword').val(),
				"startDate" : $('#startDate').val(),
				"endDate" : $('#endDate').val(),
				"adultCnt" : $('#adultCnt').val(),
				"youthCnt" : $('#youthCnt').val(),
				"babyCnt" : $('#babyCnt').val(),
				"totalCnt" : $('#totalCnt').html()
			};

			_oRequest = $.ajax({
				type : "POST",
				url : "/search",
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
					$("#container").empty();
					$("#container").html(oRes.responseText);
				}
			});
		});
	});

	$(".fv-slides ul").bxSlider({speed: 600, auto: true, autoControls:false});
</script>
