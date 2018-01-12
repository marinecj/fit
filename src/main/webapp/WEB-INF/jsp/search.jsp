<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

	<div id="container" class="goods-list-wrap">
		<div id="contents">
			<div class="search-sec">
				<div class="row-group">
					<div class="keyword-input">
						<input type="text" id="keyword" value="${searchInfo.keyword}" maxlength="10" data-placeholder="어떤 스타일의 호텔을 원하세요?" placeholder="어떤 스타일의 호텔을 원하세요?" />
						<div class="ui-autocomplete-wrap">
							<div class="other">
								<span><a href="javascript:region('오아후');">오아후</a></span>
								<span><a href="javascript:region('마우이');">마우이</a></span>
								<span><a href="javascript:region('빅아일랜드');">빅아일랜드</a></span>
								<span><a href="javascript:region('카우아이');">카우아이</a></span>
							</div>
						</div>
					</div>
					<div class="date-rang-picker">
                        <input type="hidden" id="startDate" value="${searchInfo.startDate}" />
                        <input type="hidden" id="endDate" value="${searchInfo.endDate}" />
						<button${searchInfo.startDate != '' ? ' class="sel"' : ''}><span><em data-txt="${searchInfo.startDate != '' ? searchInfo.startDate : '체크인'}"></em></span><span><em data-txt="${searchInfo.endDate != '' ? searchInfo.endDate : '체크아웃'}"></em></span></button>
						<div class="date-rang-layer">
							<div class="row"></div>
							<div class="gp-close-box">
								<a href="#" class="close">닫기</a>
							</div>
						</div>
					</div>
					<div class="guest-picker">
						<button type="button" class="guest-trigger">
							<span class="tt">
								<c:choose>
									<c:when test="${searchInfo.totalCnt != ''}">총 ${searchInfo.totalCnt}명</c:when>
									<c:otherwise>숙박 인원</c:otherwise>
								</c:choose>
							</span>
							<span class="num">총 <em id="totalCnt">${searchInfo.totalCnt}</em>명</span>
						</button>
						<div class="guest-picker-layer" style="display: none;">
							<div class="row" data-idx="0" data-min="2" data-max="15">
								<div class="label">
									<span>어른</span><input type="text" id="adultCnt" value="${searchInfo.adultCnt}" readonly />
								</div>
								<div class="spinner-btn">
									<button type="button" class="minus">빼기</button>
									<button type="button" class="plus">더하기</button>
								</div>
							</div>
							<div class="row" data-idx="1" data-min="0" data-max="5">
								<div class="label">
									<span>청소년(25개월~12살)</span><input type="text" id="youthCnt" value="${searchInfo.youthCnt}" readonly />
								</div>
								<div class="spinner-btn">
									<button type="button" class="minus">빼기</button>
									<button type="button" class="plus">더하기</button>
								</div>
							</div>
							<div class="row" data-idx="2" data-min="0" data-max="5">
								<div class="label">
									<span>유아(24개월미만)</span><input type="text" id="babyCnt" value="${searchInfo.babyCnt}" readonly />
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
				<div class="row-group">
					<div class="room-num">
						<div class="custom-select">
							<label class="tit"><span>객실수</span></label>
							<select>
								<option>1</option>
								<option>2</option>
								<option>3</option>
							</select>
						</div><!-- end : select-box -->
					</div>
					<div class="room-type">
						<span class="tit">객실유형</span>
						<div class="sel-cover">
							<label for="room-type1"><input type="checkbox" id="room-type1" /> 1인실</label>
							<label for="room-type2"><input type="checkbox" id="room-type2" /> 2인실</label>
							<label for="room-type3"><input type="checkbox" id="room-type3" /> 2인실(더블침대)</label>
							<label for="room-type4"><input type="checkbox" id="room-type4" /> 3인실</label>
						</div>
					</div>
				</div>
				<div class="row-group">
					<div class="price-range">
						<span class="tit">가격선택</span>
						<span class="amount min"><input type="text" id="amountMin" readonly />원</span>
						<span class="amount max"><input type="text" id="amountMax" readonly />원</span>
						<div id="slider-range"></div>
					</div>
				</div>
			</div>

			<div class="tit-box">
				<h2>${keyword} 검색 결과</h2>
				<h3><strong class="pt1">${keyword}</strong>로 총 <strong class="pt1">${resultListSize}</strong>개가 검색 되었습니다.</h3>
				<div class="sort">
					<div class="custom-select" style="width: 162px;">
						<label><span></span></label>
						<select>
							<option>인기순</option>
							<option>추천순</option>
							<option>이름순</option>
							<option>가격순</option>
						</select>
					</div><!-- end : select-box -->
				</div>
			</div>
			<div class="goods-list" data-over-ty="1">
				<ul>
<c:forEach items="${resultList}" var="result" varStatus="status">
					<li>
						<a href="javascript:detail('${result.hotelInfo.hotelNo}');">
							<div class="photo-box">
								<div class="photo"><img src="${Img}/data/${result.hotelInfo.hotelNo}/list.jpg" alt="${result.hotelInfo.hotelNmKr}" /></div>
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
			<%--<div class="paging">
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
			</div><!-- end : paging -->--%>

		</div><!-- end : #contents -->
	</div><!-- end : #container -->

	<%-- Spec Out GoogleMap
	<div id="map" class="map-wrap"></div>
	<script async defer src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyC13Gq6zInR7gY_OdFsmc3zySocZeU3sus&callback=initMap"></script>
	--%>

<%@ include file="/WEB-INF/jsp/include/javascripts.jsp" %>

<script>
	ui.rangeSlider(231560, 3541650);
	$("#slider-range" ).on("slidechange", function(event, ui) {console.log(2)});
    <%-- Spec Out GoogleMap ui.mapSize();--%>

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

    <%-- Spec Out GoogleMap
    var gmap;
    var geocoder;
    function initMap() {
        gmap = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 21.3281792, lng: -157.8691128},
            zoom: 11
        });
        geocoder = new google.maps.Geocoder();

        //document.getElementById('submit').addEventListener('click', function() {
        //geocodeAddress(geocoder, map);
        //});

        <c:forEach items="${resultList}" var="result" begin="0" end="9">
            geocodeAddress("${result.hotelInfo.hotelAddress}");
        </c:forEach>
        //geocodeAddress("${resultList[0].hotelInfo.hotelAddress}");
	}

	//function geocodeAddress(geocoder, resultsMap) {
	function geocodeAddress(address) {
		//var address = document.getElementById('address').value;
		console.log(address);
		//var address = "5000 Kahala Ave, Honolulu, HI 96816";
		geocoder.geocode({'address': address}, function(results, status) {
			if (status === 'OK') {
				console.log('address : ' + address + ', result location : ' + results[0].geometry.location);
				gmap.setCenter(results[0].geometry.location);
				var marker = new google.maps.Marker({
					map: gmap,
					position: results[0].geometry.location
				});
			} else {
				alert('Geocode was not successful for the following reason: ' + status);
			}
		});
	}
	--%>
</script>
<%-- Spec Out GoogleMap
<script async defer src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyC13Gq6zInR7gY_OdFsmc3zySocZeU3sus&callback=initMap"></script>
--%>