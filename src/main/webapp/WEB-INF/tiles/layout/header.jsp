<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/jsp/include/urls.jsp" %>

<div id="header" class="wide">
	<div class="in-wrap">
		<h1><a href="/"><img src="${Img}/layout/logo.png" alt="FITHAWALL" /></a></h1>
		<div class="gnb">
			<ul>
				<li><a href="javascript:region('오하후');">오하후</a></li>
				<li><a href="javascript:region('마우이');">마우이</a></li>
				<li><a href="javascript:region('빅아일랜드');">빅아일랜드</a></li>
				<li><a href="javascript:region('카우아이');">카우아이</a></li>
			</ul>
		</div>
		<div class="util">
			<ul>
				<li><a href="#">도움말</a></li>
				<li><a href="#" id="link-join" style="display: none;">회원가입</a></li>
				<li><a href="#" id="link-login" style="display: none;" onclick="popup.layerPop($(this)); return false;">로그인</a></li>
				<li><a href="#" id="login-info" style="display: none;"></a></li>
			</ul>
		</div>
	</div>
</div>

