<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

<div id="header" class="wide">
	<div class="in-wrap">
		<h1><a href="/"><img src="${Img}/layout/logo.png" alt="FITHAWALL" /></a></h1>
		<div class="gnb">
			<ul>
				<li><a href="javascript:region('오아후');">오아후</a></li>
				<li><a href="javascript:region('마우이');">마우이</a></li>
				<li><a href="javascript:region('빅아일랜드');">빅아일랜드</a></li>
				<li><a href="javascript:region('카우아이');">카우아이</a></li>
			</ul>
		</div>
		<div class="util">
			<ul>
				<li><a href="#">도움말</a></li>
				<li><a href="#" id="login-info" style="display: none;"></a></li>
				<li class="login-on">
					<span class="on-name">sumimakigae님</span>
					<div class="login-over">
						<div class="info-row">
							<div class="col1">
								<div class="photo"></div>
								<a href="#" class="i-btn bt-photo-add2">사진추가하기</a>
							</div>
							<div class="col2">
								<a href="#" class="name"><strong class="pt3">sumimakigae</strong>님</a>
								<a href="#" class="i-btn bt-logout">로그아웃</a>
								<div class="mail-row">
									<a href="mailto:lwa8010@naver.com" class="mail">lwa8010@naver.com</a>
								</div>
								<div class="links">
									<a href="#">1:1 문의사항</a>
									<a href="#">비밀번호 변경</a>
								</div>
								<a href="#" class="point"><span>사용가능 포인트</span><strong>350,000원</strong></a>
							</div>
						</div>
						<div class="btn-box">
							<a href="#" class="bt1">마이페이지</a>
							<a href="#" class="bt2">관심상품</a>
							<a href="#" class="bt3">핏하와이 포인트</a>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>

