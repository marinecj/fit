<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="google-signin-scope" content="profile email">
	<meta name="google-signin-client_id" content="389273714993-v39nbotiok1lt1s6uv4p1pbcp4m6qpd6.apps.googleusercontent.com">
	<title><tiles:getAsString name="title" />Fit Hawaii</title>

	<link href="${commonCss}" rel="stylesheet" />
	<%--<link href="${depCss}" rel="stylesheet" />--%>
	<link rel="shortcut icon" type="image/x-icon" href="${Img}/common/favicon.png"/>
	<style>
		#loading {
			width: 100%;
			height: 100%;
			top: 0px;
			left: 0px;
			position: fixed;
			display: block;
			opacity: 0.7;
			background-color: #fff;
			z-index: 99;
			text-align: center; }

		#loading-image {
			position: absolute;
			top: 50%;
			left: 50%;
			z-index: 100; }
	</style>
</head>

<body>


<div class="wrap">
	<!-- start : Header -->
	<div id="includeHeader">
		<tiles:insertAttribute name="header" />
	</div>
	<!-- end : Header -->

	<!-- container  -->
	<div id="container" class="main-wrap">
		<tiles:insertAttribute name="content" />
	</div>
	<!-- //container -->

	<!-- start : includeFooter -->
	<div id="includeFooter">
		<tiles:insertAttribute name="footer" />
	</div>
	<!-- end : includeFooter -->
</div><!-- end : wrap -->

<div id="loading"><img id="loading-image" src="/resources/asset/images/common/loading2.gif" alt="Loading..." /></div>

<div class="layer-area-wrap">

	<div class="layer-pop" id="pop-join">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>회원가입</span></p>
				<div class="btn-box">
					<a href="#" class="i-btn bt-login-facebook" onclick="fb_login();">Facebook으로 회원가입하기</a>
					<%--<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>--%>

					<%--<a href="#" class="i-btn bt-login-google">Google로 회원가입하기</a>--%>
					<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
				</div>
				<div class="banner-ad">
					<a href="#" class="item">배너광고 376*162</a>
				</div>
				<p class="copyright">Copyright © fithawaii Corp. All Rights Reserved.</p>
			</div>
		</div>
	</div><!-- end : #login -->

	<div class="layer-pop" id="pop-login">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>로그인</span></p>
				<div class="btn-box">
					<a href="#" class="i-btn bt-login-facebook" onclick="fb_login();">Facebook으로 시작하기</a>
					<%--<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>--%>

					<%--<a href="#" class="i-btn bt-login-google">Google로 시작하기</a>--%>
					<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
				</div>
				<div class="banner-ad">
					<a href="#" class="item">배너광고 376*162</a>
				</div>
				<p class="copyright">Copyright © fithawaii Corp. All Rights Reserved.</p>
			</div>
		</div>
	</div><!-- end : #login -->

	<div class="layer-pop pop-point-gift" id="pop-gift-step1">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>포인트 선물하기</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<span class="label">사용가능 포인트</span>
							<div class="item"><strong class="pt1">300,000원</strong></div>
						</li>
						<li>
							<span class="label">선물한 포인트</span>
							<div class="item"><input type="number" placeholder="숫자로 입력하세요." /></div>
						</li>
					</ul>
				</div>
				<ul class="tx-list-ty2">
					<li>- 포인트 최소 사용 가능 금액은 5,000원 입니다.</li>
				</ul>
				<div class="btn-box">
					<a href="#" class="t-btn block ty1">핏하와이 회원에게 선물하기</a>
					<a href="#" class="t-btn block ty2">비회원에게 선물하기</a>
				</div>
			</div>
		</div>
	</div><!-- end : #gift-step1 -->

	<div class="layer-pop pop-point-gift" id="pop-gift-step2">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>회원검색</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<p class="msg"><strong class="pt1">40,000</strong>포인트를 선택하셨습니다.</p>
							<div class="item-input">
								<input type="text" placeholder="아이디를 입력하세요" />
								<a href="#" class="t-btn ty1"><span class="pt2">검색</span></a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div><!-- end : #gift-step2 -->

	<div class="layer-pop pop-point-gift" id="pop-gift-step3">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>회원검색 결과</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<p class="msg"><strong class="pt1">'수미'</strong>의 검색결과 <strong class="pt1">2</strong>건</p>
							<div class="sel-cover">
								<label for="member-search1"><input type="radio" name="member-search" id="member-search1" checked="checked" />수미마키게</label>
								<label for="member-search2"><input type="radio" name="member-search" id="member-search2" />초코 수미꺼</label>
							</div>
						</li>
					</ul>
				</div>
				<div class="btn-box">
					<a href="#" class="t-btn block ty1"><span class="pt2">확인</span></a>
				</div>
			</div>
		</div>
	</div><!-- end : #gift-step3 -->

	<div class="layer-pop pop-point-gift" id="pop-gift-step4">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>선물하기 완료</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<p class="msg2">선택하신 포인트의 <strong class="pt1">2배</strong>가<br />선물로 발송되었습니다.</p>
						</li>
					</ul>
				</div>
				<div class="btn-box">
					<a href="#" class="t-btn block ty1"><span class="pt2">확인</span></a>
				</div>
			</div>
		</div>
	</div><!-- end : #gift-step4 -->

	<div class="layer-pop pop-point-gift" id="pop-gift-step2-no">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>선물하기</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<p class="msg"><strong class="pt1">40,000</strong>포인트를 선택하셨습니다.</p>
							<div class="item-input">
								<input type="text" placeholder="www.fithawaii.com/gift.html" />
								<a href="#" class="t-btn ty1"><span class="pt2">링크 복사</span></a>
							</div>
						</li>
					</ul>
				</div>
				<ul class="tx-list-ty2">
					<li>- '링크 복사'버튼을 눌러서 포인트 선물을 받으실 분의 이메일, SNS등 원하는 곳에 붙여넣기(ctrl+V) 해주세요.</li>
				</ul>
			</div>
		</div>
	</div><!-- end : #gift-no-step2 -->

	<div class="layer-pop pop-point-gift" id="pop-gift-step3-no">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>선물하기 완료</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<p class="msg2">주소가 복사되었습니다. 포인트 선물을<br />받으실 분의 이메일, SNS등 원하는 곳에<br /><span class="pt1">붙여넣기(ctrl+V)</span> 해주세요. </p>
							<p class="msg3"><span class="pt1">X2배</span>로 포인트가 발송됩니다.</p>
						</li>
					</ul>
				</div>
				<div class="btn-box">
					<a href="#" class="t-btn block ty1"><span class="pt2">확인</span></a>
				</div>
			</div>
		</div>
	</div><!-- end : #gift-no-step2 -->

	<div class="layer-pop pop-share" id="pop-share-step1">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>공유하기</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<div class="sns-btn">
								<a href="#"><img src="${Img}/btn/sns1.png" alt="facebook" /></a>
								<a href="#"><img src="${Img}/btn/sns2.png" alt="kakaotalk" /></a>
								<a href="#"><img src="${Img}/btn/sns3.png" alt="" /></a>
								<a href="#"><img src="${Img}/btn/sns4.png" alt="naver" /></a>
							</div>
							<div class="item-input">
								<input type="text" placeholder="www.fithawaii.com/gift.html" />
								<a href="#" class="t-btn ty1"><span class="pt2">링크 복사</span></a>
							</div>
						</li>
					</ul>
				</div>
				<ul class="tx-list-ty2">
					<li>- 'URL 복사'버튼을 눌러서 이메일, SNS등 원하는 곳에<br />붙여넣기(ctrl+V) 해주세요.</li>
				</ul>
			</div>
		</div>
	</div><!-- end : #share-step1 -->
	<div class="layer-pop pop-share" id="pop-share-step2">
		<div class="in-row">
			<a href="#" class="i-btn bt-close">닫기</a>
			<div class="pop-body">
				<p class="tit"><span>공유하기</span></p>
				<div class="gp-step">
					<ul>
						<li>
							<p class="msg2">주소가 복사되었습니다. 이메일, SNS등<br />원하는 곳에<span class="pt1">붙여넣기(ctrl+V)</span> 해주세요. </p>
						</li>
					</ul>
				</div>
				<div class="btn-box">
					<a href="#" class="t-btn block ty1"><span class="pt2">확인</span></a>
				</div>
			</div>
		</div>
	</div><!-- end : #share-step1 -->

</div><!-- end : layer-area-wrap -->

</body>
</html>