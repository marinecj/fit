/**
 * @description 상단메뉴바
 * @usage
 */

fb.Util.createNamespace("fb.MenuCtrl");
fb.MenuCtrl = (function() {
	var _welWrapper, _welLogo;
	var _sCurPage;
	var _htBtnCfg = {};
	var _htPageCategory = {};
	var _htPageInfo = {};
	var _htOption = {};
	var _oRequest;
	var _sDebug;

	function _init(welWrapper, sDebug) {
		var fIEVer = fb.Util.getIEVersion();
		if (fIEVer > 0 && fIEVer < 8.0) {
			// ie6,7에서 hashChange를 사용할때 document.domain문제로 불러와야 함
			$.fn.hashchange.src = "/document-domain.html";
			$.fn.hashchange.domain = fb.Static.get("sPublisherDomain");
		}
		_sDebug = sDebug || "N";

		_initVar();
		_initElement(welWrapper);
		_initEvent();
		_initPage();
	}

	function _initVar() {
		for (cat in fb.MENUTREE) {
			_htBtnCfg[cat] = {};
			_htBtnCfg[cat].submenu = fb.MENUTREE[cat];
			_htBtnCfg[cat].element = null;
		}

		for (page in fb.PAGELINKS) {
			_htPageCategory[page] = _getCategory(page);
		}

		_oRequest = null;
	}

	function _initElement(welWrapper) {
		_welWrapper = welWrapper;
		_welLogo = _welWrapper.find("a.tit_fbday");

		_htBtnCfg["store"].element = _welWrapper.find("a.m_store");
		_htBtnCfg["league"].element = _welWrapper.find("a.m_league");
		_htBtnCfg["squad"].element = _welWrapper.find("a.m_squad");
		_htBtnCfg["training"].element = _welWrapper.find("a.m_training");
		_htBtnCfg["match"].element = _welWrapper.find("a.m_match");
		_htBtnCfg["inventory"].element = _welWrapper.find("a.m_inventory");
		_htBtnCfg["super"].element = _welWrapper.find("a.m_super");
		_htBtnCfg["ranking"].element = _welWrapper.find("a.m_ranking");
	}

	function _initEvent() {
		$(window).hashchange(_onHashChange);
		_welWrapper.click(_onClickMenu);
		for (type in _htBtnCfg) {
			if (_htBtnCfg[type].submenu.length > 0) {
				_htBtnCfg[type].element.closest("dd").mouseenter(_onMouseEnter);
				_htBtnCfg[type].element.closest("dd").mouseleave(_onMouseLeave);
			}
		}
	}

	function _initPage() {
		$(window).hashchange();
	}

	function _onMouseEnter(we) {
		var welTarget = $(we.currentTarget);
		if (welTarget.find("div.d_in li").length == 0) {
			return;
		}

		_showDropdown(we.currentTarget);
	}

	function _onMouseLeave(we) {
		var welTarget = $(we.currentTarget);
		if (welTarget.find("div.d_in li").length == 0) {
			return;
		}

		_hideDropdown(we.currentTarget);
	}

	function _onClickMenu(we) {
		// prevent screen scrolling to top caused from href="#"
		we.preventDefault();
		fb.Static.init(function() {
			var elAnchor = we.target.tagName == "A" ? we.target : $(we.target).closest("a")[0];
			var sPageKey = $(elAnchor).attr("data-target");
			if (!sPageKey) {
				return false;
			}

			// load page
			_changeHash(sPageKey);
		});

		return false;
	}

	function _changeHash(sKey, htOption, bForceLoad) {
		_htOption = htOption || {};
		if (bForceLoad !== true) {
			var htPageInfo = _getPageInfo(_sCurPage);
			if (htPageInfo.listeners && htPageInfo.listeners["beforeUnload"]) {
				var bRet = htPageInfo.listeners["beforeUnload"]({
					"page" : sKey
				});
				if (bRet === false) {
					return;
				}
				_htOption.reload = true;
			}
		} else {
			_htOption.reload = true;
		}

		location.hash = sKey;
		if (_sCurPage == sKey) {
			if (_htOption.reload === true) {
				$(window).hashchange();
			}
		}
	}

	function _onHashChange() {
		var sPageKey = location.hash.substr(1, 100);

		if (location.href.indexOf("#") < 0) {
			_loadPage("11");
		} else {
			if (typeof fb.PAGELINKS[sPageKey] != "undefined") {
				if (_isExceptionCase(sPageKey) == false) {
					_loadPage(sPageKey, _htOption);
				}
			} else {
				location.replace("/gmc/main");
			}
		}
	}

	function _isExceptionCase(sPageKey) {
		// 예외처리를 _changeHash에서 처리하지 않고 _onHashChange에서 처리하는 이유 = url를 직접 입력하는 들어오는 경우 대비 위해서
		if (_htOption.skipExceptionCheck === true) {
			return false;
		}

		// 퍼블리셔별 예외처리#0 퍼블리셔별 로딩가능한 페이지인지 확인
		var sPublisherName = fb.Static.get("sPublisherName");
		// nhnpa/MBG 일 경우 로그인 쿠키유효성 검사
		if (sPublisherName == "nhnpa" || sPublisherName == "mbg") {
			var sLoginCookie = fb.Util.getCookie(sPublisherName == "nhnpa" ? "C8_FB_USER" : "MBG_FB_USER");
			if (sLoginCookie == null || sLoginCookie == "") {
				fb.Popup.alert({
					"message" : "タイムアウトしました。<br>再度、接続をお試しください。",
					"btnText1" : "確認",
					"onOk" : function() {
						window.open('', '_self', '');
						window.close();
						setTimeout(function() {
							location.reload();
						}, 10);
					}
				});
				return true;
			}
		}

		// 퍼블리셔별 예외처리#1 퍼블리셔별 로딩가능한 페이지인지 확인
		if (fb.PAGELINKS[sPageKey].publisher) {
			if (fb.PAGELINKS[sPageKey].publisher.indexOf(sPublisherName) < 0) {
				return true;
			}
		}

		// 공통 예외처리#0 - 창단하자마자 리그가 구성되지 않는 사용자는 "경기일정" 이 있는 페이지 진입 불가
		if (fb.Static.get("sLeageGrdCd") == "") {
			if (sPageKey == "schedule" || sPageKey.indexOf("tactics") > -1) {
				var sMsg = _getBeforeOrganizeMsg();
				fb.Log.chaseLog(sPageKey + "(league_not_ready)");
				fb.Popup.alert({
					"message" : sMsg,
					"onOk" : function() {
						_changeHash("home", {
							"reload" : true
						}, true);
					}
				});
				return true;
			}
		}

		// 공통 예외처리#1 - livegame 이고, param이 없는 경우 > schedule로 이동
		if (sPageKey == "livegame" && (!_htOption.param || !_htOption.param.seq)) {
			_changeHash("schedule", {
				"reload" : true
			}, true);
			return true;
		}

		// 공통 예외처리#2 - 슈퍼컵 > 진행 경우, 슈퍼컵 대상자인지 확인하지 않은 슈퍼컵 경기일정 확인
		if (sPageKey == "supercupschedule/tournament" || sPageKey == "supercupschedule" || sPageKey == "top16" || sPageKey == "top16/silver") {
			$.post("/supercup/getMySuperCupStatus", function(oRes) {
				var htRes = JSON.parse(oRes);
				if (htRes.participation != true && (sPageKey == "supercupschedule/tournament" || sPageKey == "supercupschedule")) {
					// 슈퍼컵 대상자이 아닐 때는, 경기 진행이나 대진표 들어갈 수 없음
					fb.Popup.alert({
						"message" : fb.i18n.get("supercup.vs.not.supercup"),
						"onOk" : function() {
							_changeHash("supercup", {
								"reload" : true
							}, true);
						}
					});
				} else if (htRes.participation == true && htRes.unopenedGameCount > 0 && (sPageKey == "supercupschedule/tournament" || sPageKey == "top16" || sPageKey == "top16/silver")) {
					// 슈퍼컵 대상자 이고 미확이 경기가 있는 경우, 경기진행, 대진표, 16강 대진표는 들어갈 수 없음
					fb.Popup.alert({
						"message" : fb.i18n.get("supercup.vs.unreadgamecnt", [ htRes.unopenedGameCount ]),
						"btnText1" : fb.i18n.get("supercup.vs.gotosupercuplive"),
						"onOk" : function() {
							_changeHash("supercupschedule", {
								"reload" : true
							}, true);
						}
					});
				} else {
					_loadPage(sPageKey, _htOption);
				}
			});
			return true;
		}

		// 공통 예외처리#3 - 확인되지 않은 경기가 있는 경우 > schedule로 이동
		// 월드투어, 데일리매치는 경기일정을 확인하지 않는다.
		if (sPageKey != "schedule" && sPageKey != "dailymatch" && sPageKey != "worldtour" && sPageKey != "pvp") {
			var htParam = {};
			if (fb.Static.get("skpSchdChk") == true) {
				htParam.admin = "Y";
			}
			$.ajax({
				url : "/gmc/checkMySchedule",
				cache : false,
				type : "GET",
				data : htParam,
				complete : function(oRes) {
					var htRes = JSON.parse(oRes.responseText);
					if (htRes.unopenedGameCount > 0) {
						fb.Popup.alert({
							"message" : fb.i18n.get("home.notyetviewedmsg", [ htRes.unopenedGameCount ]),
							"btnText1" : fb.i18n.get("home.goschedulebtn"),
							"onOk" : function() {
								_changeHash("schedule", {
									"reload" : true
								}, true);
							}
						});
					} else {
						_loadPage(sPageKey, _htOption);
					}
				}
			});
			return true;
		}

		return false;
	}

	function _getBeforeOrganizeMsg() {
		if (fb.Static.get("sPublisherName") == "nxeu") {
			var d = new Date();
			var now = d.getTime(); // time to check
			var x = new Date((d.getMonth() + 1) + '/' + d.getDate() + '/' + d.getFullYear() + '/20:45:00').getTime(); // time x
			var y = new Date((d.getMonth() + 1) + '/' + d.getDate() + '/' + d.getFullYear() + '/23:01:00').getTime(); // time x
			//var dist = Math.abs(x - y); // time distance

			//if (d.getDay() == 6 && now - Math.min(x, y) <= dist) {
			if (d.getDay() == 6 && now > x && now < y) {
				// 토요일, 21:45 ~ 23:01 사이면
				return fb.i18n.get("home.organizeleaguemsg2");
			} else {
				// 그 외의 시간
				return fb.i18n.get("home.organizeleaguemsg");
			}
		} else {
			return fb.i18n.get("home.organizeleaguemsg");
		}
	}

	function _beforeLoadPage(sPageKey) {
		// home
		if (sPageKey == "home") {
			fb.Alarm.update();
		}

		// lineup
		if (sPageKey.indexOf("lineup") > -1 && sPageKey.indexOf("ranklineup")==-1) {
			$("#d_multilineup_loading").show();
			$("#li_lineup_sublink").addClass("lineup");
		} else {
			$("#d_multilineup_loading").hide();
			$("#li_lineup_sublink").removeClass("lineup");
		}

		// on all page
		fb.MatchTimer.update();
		fb.Alarm.initUpdate();
		fb.home.leaguetalk.LnbCheck.update();
		if (fb.Static.get("sPublisherName") == "shanda") {
			fb.shanda.FirstGuide.hide();
		}
		if (fb.Static.get("sPublisherName") == "naver") {
		    if(fb.chat){
			    fb.chat.View.hideWatch();
		    }
		}

	}

	function _loadPage(sPageKey, htOption) {
		htOption = htOption || {};
		if (!htOption.reload && _sCurPage == sPageKey) {
			return true;
		}

		_beforeLoadPage(sPageKey);

		if (!fb.PAGELINKS[sPageKey].url || fb.PAGELINKS[sPageKey].url == "") {
			fb.Popup.alert({
				"message" : "준비중입니다"
			});
			return;
		}

		var sCategory, sSubCategoryegory;
		if (sPageKey.indexOf("/") > -1) {
			var aComp = sPageKey.split("/");
			sSubCategory = aComp[0];
			sCategory = _htPageCategory[sSubCategory];
		} else {
			sCategory = _htPageCategory[sPageKey];
			sSubCategory = sPageKey;
		}

		if(sPageKey =="newplayercard"){
			sCategory = "squad";
		}

		if (sCategory == "") {
			fb.log("ERROR! page key error, check fb.MENUTREE in Config.js.");
			return false;
		}

		// hide dropdown menu
		_hideAllDropdown();

		// highlight main category
		_highlightCategory(sCategory);

		// hide previous submenu if opened
		_hideSubmenu();

		// clean event listeners
		_removeCustomEvents();

		// show submenu & highlight subcategory
		if (_htBtnCfg[sCategory].submenu.length > 0) {
			_showSubmenu(sCategory);
			if (sCategory == sPageKey) {
				_highlightSubCategory(sCategory, "");
			} else {
				_highlightSubCategory(sCategory, sSubCategory);
			}
		}

		// load content with Ajax call
		_loadContentWithKey(sPageKey, htOption);

		// save current selected page
		_sCurPage = sPageKey;
	}

	function _loadContentWithKey(sPageKey, htOption) {
		htOption = htOption || {};

		// change background image
		$("div#g_area")[0].className = fb.PAGELINKS[sPageKey].className;

		// Cache current game content sub tree
		_saveCachedDOMTree(_sCurPage);

		// Clear cached sub tree if reload param is true
		if (htOption.reload === true || fb.PAGELINKS[sPageKey].reload === true) {
			_clearCachedDOMTree(sPageKey);
		}

		// Save onload callback function for later
		_saveOnloadCallback(sPageKey, htOption.onload);

		// Resotre sub tree or Load game content
		if (!_restoreCachedDOMTree(sPageKey)) {
			if (htOption.useDimmed !== false) {
				fb.Dimmed.show("loading");
			}

			if (_oRequest != null) {
				if (_oRequest._pageKey == sPageKey) {
					return;
				}
				_oRequest.abort();
				fb.log("[fb.MenuCtrl] Request Aborted!");
			}

			htOption.param = htOption.param || {};
			htOption.param.debug = _sDebug;
			_oRequest = $.ajax({
				url : fb.PAGELINKS[sPageKey].url,
				cache : false,
				data : htOption.param,
				type : htOption.type || "GET",
				error : function() {
					// TODO : Error Control
					if (htOption.useDimmed !== false) {
						fb.Dimmed.hide(200);
					}
					_oRequest = null;
				},
				complete : function(oRes) {
					/* Clean Up */
					$("#d_popup_layer").html("");
					$("#d_popup_layer_full").html("");

					fb.Sound.stop(true);
					fb.SettingPanel.hide();

					$("#g_loader").html(oRes.responseText);
					if (htOption.useDimmed !== false) {
						fb.Dimmed.hide(200);
					}
					_fireOnloadCallback(sPageKey);
					_oRequest = null;
					_htOption = {};

					if (fb.Static.get("sPublisherName") == "naver") {
						lcs_do();
					} else if (fb.Static.get("sPublisherName") == "nxeu") {
						ga('send', 'pageview', {
							'page' : sPageKey
						});
					}

					// user chase log
					fb.Log.chaseLog(sPageKey);
				}
			});
			_oRequest._pageKey = sPageKey;
		}
	}

	function _loadContentWithUrl(sUrl, htOption, bForceLoad) {
		htOption = htOption || {};

		if (bForceLoad !== true) {
			var htPageInfo = _getPageInfo(_sCurPage);
			if (htPageInfo.listeners && htPageInfo.listeners["beforeUnload"]) {
				var bRet = htPageInfo.listeners["beforeUnload"]({
					"page" : sUrl
				});
				if (bRet === false) {
					return;
				}
			}
		}

		if (typeof htOption.onload !== "function") {
			htOption.onload = function() {};
		}

		// Cache current game content sub tree
		_saveCachedDOMTree(_sCurPage);

		// Clear cached sub tree if reload param is true
		if (htOption.reload === true) {
			_clearCachedDOMTree(sUrl);
		}

		// Resotre sub tree or Load game content
		if (!_restoreCachedDOMTree(sUrl)) {
			if (htOption.useDimmed !== false) {
				fb.Dimmed.show("loading");
			}

			if (_oRequest != null) {
				_oRequest.abort();
				fb.log("fb.MenuCtrl - Request Aborted!");
			}

			htOption.param = htOption.param || {};
			htOption.param.debug = _sDebug;
			_oRequest = $.ajax({
				url : sUrl,
				cache : false,
				data : htOption.param,
				type : htOption.type || "GET",
				error : function() {
					// TODO : Error Control
					if (htOption.useDimmed !== false) {
						fb.Dimmed.hide(200);
					}
					_oRequest = null;
				},
				complete : function(oRes) {
					$("#g_loader").html(oRes.responseText);
					_fireOnloadCallback(sUrl);
					if (htOption.useDimmed !== false) {
						fb.Dimmed.hide(200);
					}
					_oRequest = null;

					if (fb.Static.get("sPublisherName") == "naver") {
						/* lcs log */
						lcs_do();
					}
				}
			});
		}
		_sCurPage = sUrl;
	}

	function _loadPageWithKeyOrUrl(sIputStr, htOption, bForceLoad) {
		if (sIputStr.indexOf("/gmc/") > -1) {
			_loadContentWithUrl(sIputStr, htOption, bForceLoad);
		} else {
			_changeHash(sIputStr, htOption, bForceLoad);
		}
	}

	function _forceLoad(sIputStr, htOption) {
		_loadPageWithKeyOrUrl(sIputStr, htOption, true);
	}

	function _saveOnloadCallback(sKey, fOnload) {
		if (typeof fOnload == "function") {
			var htPageInfo = _getPageInfo(sKey);
			htPageInfo.onpageload = fOnload;
		}
	}

	function _fireOnloadCallback(sKey) {
		var htPageInfo = _getPageInfo(sKey);
		if (htPageInfo.onpageload) {
			htPageInfo.onpageload();
		}
	}

	function _onPageReady(fOnLoad) {
		_loadScripts(fOnLoad);
	}

	function _loadScripts(fOnLoad) {
		var htPageInfo = _getPageInfo(_sCurPage);

		if (htPageInfo.isScriptLoaded) {
			htPageInfo.onpageload = fOnLoad;
			return;
		}
		htPageInfo.isScriptLoaded = true;

		if (typeof gaScriptsToLoad == "undefined" || gaScriptsToLoad == null) {
			htPageInfo.onpageload = fOnLoad;
			return;
		}

		var nLen = gaScriptsToLoad.length;
		var aScripts = gaScriptsToLoad.slice(0, nLen - 1);
		fb.Util.loadScript(aScripts, fOnLoad);
		gaScriptsToLoad = null;
	}

	function _highlightCategory(sSelected) {
		_welWrapper.find("div.menu dd").removeClass("on");
		$(".m_" + sSelected).closest("dd").addClass("on");
	}

	function _highlightSubCategory(sMainCat, sPageKey) {
		// clear all
		var awelLi = $("ul.sub_" + sMainCat).children("li");
		awelLi.removeClass("on");

		// highlight selected
		if (sPageKey == "") {
			$(awelLi[0]).addClass("on");
		} else {
			for ( var i = 0, nLen = awelLi.length; i < nLen; i++) {
				if ($(awelLi[i]).find("a").attr("data-target") == sPageKey) {
					$(awelLi[i]).addClass("on");
					break;
				}
			}
		}
	}

	function _getCategory(sPageKey) {
		if (typeof fb.MENUTREE[sPageKey] != "undefined") {
			return sPageKey;
		} else {
			for (cat in fb.MENUTREE) {
				if (jQuery.inArray(sPageKey, fb.MENUTREE[cat]) >= 0) {
					return cat;
				}
			}
		}
		return "";
	}

	function _showDropdown(elTarget) {
		var welWrapper = $(elTarget).find("div.d_over");
		var welSlider = welWrapper.find("div.d_in");

		welWrapper.show();
		welSlider.css({
			"margin-top" : -1 * welSlider.height()
		});
		welSlider.animate({
			"margin-top" : "0"
		}, 250, "swing", function() {

		});
	}

	function _hideDropdown(elTarget) {
		$(elTarget).find("div.d_over").hide();
	}

	function _hideAllDropdown() {
		_welWrapper.find("div.d_over").hide();
	}

	function _showSubmenu(sCategory) {
		$("ul.sub_" + sCategory).show();
	}

	function _hideSubmenu() {
		$("div.depth ul").hide();
	}

	function _getPageInfo(sKey) {
		_htPageInfo[sKey] = _htPageInfo[sKey] || {};
		return _htPageInfo[sKey];
	}

	function _clearCachedDOMTree(sKey) {
		var htPageInfo = _getPageInfo(sKey);
		if (htPageInfo.cached) {
			delete htPageInfo.cached;
		}
	}

	function _saveCachedDOMTree(sKey) {
		if ($("#g_content")[0]) {
			var htPageInfo = _getPageInfo(sKey);
			htPageInfo.cached = $("#g_content").detach();
			// console.log("_saveCachedDOMTree - " + sKey + " - " + htPageInfo.cached);
		}
	}

	function _restoreCachedDOMTree(sKey) {
		var htPageInfo = _getPageInfo(sKey);
		if (htPageInfo.cached) {
			$("#g_loader").empty().append(htPageInfo.cached);
			// console.log("_restoreCachedDOMTree - " + sKey + " - " + htPageInfo.cached);
			if (htPageInfo.onpageload) {
				htPageInfo.onpageload();
			}
			return true;
		} else {
			return false;
		}
	}

	function _getCurPageKey() {
		return _sCurPage;
	}

	function _attachEvent(sEvent, fFunction) {
		var htPageInfo = _getPageInfo(_sCurPage);
		htPageInfo.listeners = htPageInfo.listeners || {};
		htPageInfo.listeners[sEvent] = fFunction;
	}

	function _detachEvent(sEvent) {
		var htPageInfo = _getPageInfo(_sCurPage);
		if (htPageInfo.listeners && htPageInfo.listeners[sEvent]) {
			delete htPageInfo.listeners[sEvent];
		}
	}

	function _removeCustomEvents() {
		var htPageInfo = _getPageInfo(_sCurPage);
		delete htPageInfo.listeners;
	}

	return {
		init : _init,
		loadPage : _loadPageWithKeyOrUrl,
		changeHash : _changeHash,
		forceLoad : _forceLoad,
		getCurPageKey : _getCurPageKey,
		attach : _attachEvent,
		detach : _detachEvent,
		onPageReady : _onPageReady
	};
})();
