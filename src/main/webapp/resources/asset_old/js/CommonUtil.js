
/**
 * @(#)fb.Util.js 2013.02.01
 *
 * Copyright NHN Corp. All rights Reserved.
 * NHN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

/** @namespace * */
fb = (typeof fb != "undefined") ? fb : {};

/**
 * @author hclee
 * @since 2013.01.31
 * @description 공통 유틸리티 함수
 */
fb.Util = {
	/**
	 * @description 문자열로부터 네임스페이스를 생성하는 함수
	 * @param {String} sNamespace 네임스페이스 문자열 (예: fb.ComponentName)
	 * @return {Object}
	 */
	createNamespace : function(sNamespace) {
		var aSpace = sNamespace.split(".");
		var oParent = window;
		var sObjectName = null;
		for ( var i = 0, len = aSpace.length; i < len; i++) {
			sObjectName = aSpace[i];
			if (i == (len - 1)) {
				break;
			}
			if (typeof oParent[sObjectName] !== "object") {
				oParent[sObjectName] = {};
			}
			oParent = oParent[sObjectName];
		}
		return {
			container : oParent,
			name : sObjectName
		};
	},

	/**
	 * @description 간단한 템플릿 치환 함수
	 * @param {String} sTemplate 템플릿 문자열
	 * @param {Hash Table} htData 데이터
	 * @example processTpl("My name is {=name}", {name: 'John Doe'}); // My name is John Doe processTpl("1st item of Array is '{=0}'", ['a','b','c']); // 1st item of Array is 'a'
	 */
	processTpl : function(sTemplate, htData) {
		this._rxTemplate = this._rxTemplate || /{=([^{}]*)}/g;
		return sTemplate.replace(this._rxTemplate, function(a, b) {
			// 지정한 데이터에 없는 항목은 그냥 빈 문자열로 대체 "{="+b+"}"
			return (typeof htData[b] == "undefined") ? "" : htData[b];
		});
	},


	/**
	 * @description 동적 스크립트 로딩 함수
	 * @param {Variant} vURL 스크립트 파일의 경로 문자열 또는 그 배열
	 * @param {Function} fCallback 로딩 완료 후 실행할 콜백 함수. vURL이 배열인 경우 모두 로딩 완료된 뒤 실행
	 * @example // Multiple URL var aURL ["/js/lib/jindo.mobile.all.js", "/js/lib/jindo_mobile_component.js"]; fb.Util.loadScript(aURL, function(){ ... }); // Single URL
	 *          fb.Util.loadScript("/js/service/main/line.myhome.main.Controller.js");
	 */
	loadScript : function(vURL, fCallback) {
		var aURL = (vURL.constructor === Array) ? vURL : [ vURL ];
		var elFragment = document.createDocumentFragment();
		var elScript = null;

		// initVar
		this._aLoadScriptQueue = this._aLoadScriptQueue || [];
		this._htLoadScriptCallbacks = this._htLoadScriptCallbacks || {};

		// LoadQueue
		var nQueueKey = this._aLoadScriptQueue.push(aURL) - 1;
		this._htLoadScriptCallbacks[nQueueKey] = fCallback;
		
		// <script> Fragment
		var fIEVersion = this.getIEVersion();
		if(fIEVersion > 0 && fIEVersion < 9.0) {
			var self = this;
			for(var i = 0, nLen = aURL.length ; i < nLen ; i++) {
				fb.Util.log("Loading Script... " + aURL[i]);
				$.ajax({
					"url" : aURL[i],
					"dataType" : "script",
					"success" : function() {
						self._onLoadScriptIE(self, this, nQueueKey);
					},
					"cache" : true
				});
			}
		} else {
			var fOnLoad = function() {
				fb.Util._onLoadScript(this);
			};
			
			for(var i = 0, nLen = aURL.length ; i < nLen ; i++) {
				if(aURL[i].length > 0) {
					fb.Util.log("Loading Script... " + aURL[i]);
					elScript = document.createElement("SCRIPT");
					elScript.src = aURL[i];
					elScript.url = aURL[i];
					elScript.key = nQueueKey;
					elScript.charset = "utf-8";
					elScript.type = "text/javascript";
					$(elScript).load(fOnLoad);
					$(elScript).error(fOnLoad);
					elFragment.appendChild(elScript);
				}
			}

			// append fragment to document.body
			document.body.appendChild(elFragment);
			aURL = elFragment = elScript = fOnLoad = null; // gc
		}
	},

	/**
	 * @description loadScript 실행시 하나의 <script> 로딩이 완료되었을 때 이벤트 핸들러
	 * @private
	 * @param {HTMLScriptElement} elScript
	 */
	_onLoadScript : function(elScript) {
		document.body.removeChild(elScript); // memory leak 방지용

		// pop out from chunk
		var aQueue = this._aLoadScriptQueue[elScript.key];
		aQueue.splice(elScript.url, 1);
		if (aQueue.length > 0) {
			return;
		}

		// callback function
		var fCallback = this._htLoadScriptCallbacks[elScript.key];
		if (typeof fCallback === "function") {
			fCallback();
			delete this._htLoadScriptCallbacks[elScript.key];
		}
	},
	
	/**
	 * @description loadScript 실행시 하나의 <script> 로딩이 완료되었을 때 이벤트 핸들러 (IE 8.0 이하용)
	 * @private
	 */
	_onLoadScriptIE : function(oThis, oRes, nKey) {
		// pop out from chunk
		var aQueue = oThis._aLoadScriptQueue[nKey];
		aQueue.splice(oRes.url, 1);
		if (aQueue.length > 0) {
			return;
		}

		// callback function
		var fCallback = oThis._htLoadScriptCallbacks[nKey];
		if (typeof fCallback === "function") {
			fCallback();
			delete oThis._htLoadScriptCallbacks[nKey];
		}
	},	

	/**
	 * @description 동적 스타일시트 로딩 함수
	 * @param {Variant} vURL 스크립트 파일의 경로 문자열 또는 그 배열
	 */
	loadCSS : function(vURL) {
		var aURL = (vURL.constructor === Array) ? vURL : [ vURL ];
		var elFragment = document.createDocumentFragment();
		var elLink = null;

		for(var i = 0, nLen = aURL.length ; i < nLen ; i++) {
			elLink = document.createElement("link");
			elLink.rel = "stylesheet";
			elLink.type = "text/css";
			elLink.href = aURL[i];
			elFragment.appendChild(elLink);
		}

		// append fragment to document.head
		document.head.appendChild(elFragment);
		aURL = elFragment = elLink = null; // gc
	},

	/**
	 * @description 입력된 숫자를 문자열로 반환하는 함수 
	 * @param {number} nNum : 입력숫자
	 * @param {number} nDigit : 자릿수
	 */
	num2str : function(nNum, nDigit) {
		var i, j;
		var sIn = nNum + "";
		var sRet = "";
		for(i = 0 ; i < nDigit ; i++) {
			if(i < nDigit - sIn.length) {
				sRet += "0";
			} else {
				sRet += sIn.charAt(i-(nDigit - sIn.length));
			}
		}
		
		return sRet;
	},
	
	/**
	 * @description 주어진 범위안의 랜덤값
	 * @param {number} nStart : 최소값
	 * @param {number} nRange : 값의 범위
	 */
	random : function (nStart, nRange) {
		return Math.floor((Math.random()*nRange)+nStart);
	},
	
	randoms : function(max, size) {
		// generate random numbers
		var randoms = [];
		while (randoms.length < size) {
			var random = fb.Util.random(max);
			if (-1 == randoms.indexOf(random)) {
				randoms.push(random);
			}
		}
		return randoms;
	},
	
	/**
	 * @description 세자리마다 자릿수 표시 
	 * @param {number} x : 입력값
	 */
	numWithCommas : function(x) {
		var sLocale;
		if(fb && fb.Static) {
			sLocale = fb.Static.get("sLocale");
		} 
		
		if(sLocale == "de" || sLocale == "fr" || sLocale == "es" || sLocale == "nl" || sLocale == "tr" || sLocale == "it" || sLocale == "pl" || sLocale == "pt") {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
		} else {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
	},
	
	setDebugMode: function(bIsDebug) {
		fb.Util.bIsDebug = bIsDebug;
		fb.log = fb.Util.log;
		
		if(bIsDebug == false) {
			if(typeof console != "undefined") {
				console.log = function() {};
				console.debug = function() {};
				console.error = function() {};
			}
		}
	},
	
	log: function (arg) {
		if(typeof console != "undefined" && typeof console.log != "undefined" ) {
			console.log(typeof arg == "string" ? arg : arguments);
		}
	},
	
	/**
	 * @description regular expression 모음 
	 */
	re: {
		en: /[a-zA-Z]/gi,
		sp: /[~!@\#$%^&*\()\-=+_'`]/gi,
		num: /[0-9]/gi,
		en: /[a-zA-Z]/,
		ko: /[ㄱ-ㅎㅏ-ㅣ가-힣]/
	},
	
	/**
	 * @description 각종 String Utils 
	 */
	SPECIAL_CHAR_RE : /[ \{\}\[\]\/?.,;:|\)*~\`!^\-_+<>@\#$%&\\\=\(\'\"]/,
	hasSpecialChar : function(str) {
		return fb.Util.SPECIAL_CHAR_RE.test(str);
	},
	
	removeKrChar : function(str) {
		return str.split(/[\u1100-\u11FF\u3130-\u318F\uAC00-\uD7AF]/).join("");
	},
	
	removeJaChar : function(str) {
		return str.split(/[\u3040-\u30ff\u31f0-\u31ff]/).join("");
	},
	
	removeZhChar : function(str) {
		return str.split(/[\u2E80-\u2EFF\u31C0-\u31EF\u3200-\u32FF\u3400-\u4DBF\u4E00-\u9FBF\uF900-\uFAFF]/).join("");
	},
	
	removeSpecialChar : function(str) {
		//return text.replace(fb.Util.SPECIAL_CHAR_RE, "");
		return str.split(fb.Util.SPECIAL_CHAR_RE).join("");

	},
	
	removeNonEnglish : function (str) {
		return str.split(/[^a-zA-Z]/).join("");
	},
	
	isSpecialChar : function(keyCode) {
		if ((keyCode >= 33 && keyCode <= 47) ||
			(keyCode >= 58 && keyCode <= 64) ||
			(keyCode >= 91 && keyCode <= 96) ||
			(keyCode >= 123 && keyCode <= 126) ||
			(keyCode == 32)) {
			return true;
		}
		return false;
	},
	
	isFuncKey: function(keyCode) {
		// backspace, tab, shift, capslock, 한/영, end, home, 방향키, insert, delete
		return (keyCode == 8 || keyCode == 9 ||  keyCode == 16 ||  keyCode == 20 || keyCode == 21 || keyCode == 35 || keyCode == 36 ||
				keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 45 || keyCode == 46);
	},
	
	isDelete: function(keyCode) {
		return keyCode == 46;
	},
	
	isBackspace: function(keyCode) {
		return keyCode == 8;
	},
	
	isSpace: function(keyCode) {
		return 32 == keyCode;
	},
	
	isEng : function(keyCode) {
		return (65 <= keyCode && keyCode <= 90) || (97 <= keyCode && keyCode <= 122);
	},
	
	isKor : function(keyCode) {
		return (keyCode >= 12592 && keyCode <= 12687);
	},
	
	isNum : function(keyCode) {
		return (keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105);
	},
	
	isSingleByteKeyCode: function(keyCode) {
		if (48 <= keyCode && keyCode <= 57) {
			return true;
		}
		if (65 <= keyCode && keyCode <= 90) {
			return true;
		}
		return false;
	},
	
	size : function(text) {
		var size = 0;
		for ( var i = 0; i < text.length; i++) {
			size += (text.charCodeAt(i) > 128) ? 2 : 1;
		}
		return size;
	},
    
	/**
	 * @description 한글이 포함된 문자열의 substr을 위한 함수 
	 */
	substr2 : function(str, len) {
		var str_tmp = fb.Util.recut(str, len);
		return fb.Util.cut(str_tmp, len);
	},
	
	cut : function(str, len) {
		 var l = 0;
		 for (var i = 0; i < str.length; i++) {
			 l += (str.charCodeAt(i) > 128) ? 2 : 1;
			 if (l > len) { 
				 return str.substring(0,i) ;
			 }
		 }
		 return str;
	 },
    
    recut : function(str, len) {
        var l = 0;
        for (var i=0; i < str.length; i++) {
        	l += (str.charCodeAt(i) > 128) ? 2 : 1;
        	if (l > len) {
        		return str.substr(0,i) ;
        	} 
        }
        return str;
    },
	
	/**
	 * * Date 타입의 날짜를 원하는 Format 의 문자열로 변환한다.
	 * 
	 * @TODO: 다국어 처리!!!
	 * 
	 * @param {Date}
	 *            oDate 문자열로 변환하려고 하는 문자
	 * @param {String}
	 *            sFormat 날짜 포맷 예) "yyyy년 MM월 dd일 a/p hh시 mm분 ss초" -> 2013년
	 *            03월 27일 오후 03시 45분 42초 "yyyy-MM-dd" -> 2013-03-27 "'yy
	 *            MM.dd" -> '13 03.27 "yyyy-MM-dd E" -> 2013-03-27 일요일
	 *            "yyyy" -> 2013
	 * 
	 * MM 과 mm 에 주의한다.!!!
	 * 
	 * @returns String
	 */
	dateFormat : function(oDate, sFormat) {
		if (!oDate)
			return " ";

		var weekName = [fb.i18n.get("common.util.sun"), fb.i18n.get("common.util.mon"), fb.i18n.get("common.util.tue"), fb.i18n.get("common.util.wed"), fb.i18n.get("common.util.thu"), fb.i18n.get("common.util.fri"), fb.i18n.get("common.util.sat")];
		var d = oDate;

		return sFormat.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi,
				function($1) {
					switch ($1) {
					case "yyyy":
						return d.getFullYear();
					case "yy":
						return num_zf((d.getFullYear() % 1000), 2);
					case "MM":
						return num_zf(d.getMonth() + 1, 2);
					case "dd":
						return num_zf(d.getDate(), 2);
					case "E":
						return weekName[d.getDay()];
					case "HH":
						return num_zf(d.getHours(), 2);
					case "hh":
						return num_zf(((h = d.getHours() % 12) ? h : 12), 2);
					case "mm":
						return num_zf(d.getMinutes(), 2);
					case "ss":
						return num_zf(d.getSeconds(), 2);
					case "a/p":
						return d.getHours() < 12 ? fb.i18n.get("common.util.am") : fb.i18n.get("common.util.pm");
					default:
						return $1;
					}
				});

		// len 갯수 만큼 sStr 을 붙여주는 함수
		// 2자리로 시간을 표현하기 위해 한자리 숫자에 0으로 매꾸기 위해 만들어진 함수
		//TODO: 좀 더 직관적이고 효율적인 방식으로 변환 필요 할 듯
		function string(sStr, len) {
			var s = '', i = 0;
			while (i++ < len) {
				s += sStr;
			}
			return s;
		}

		//2자리로 시간을 표현하기 위해 한자리 숫자에 0으로 매꾸기 위해 만들어진 함수
		function str_zf(sStr, len) {
			return string("0", len - sStr.length) + sStr;
		}

		//2자리로 시간을 표현하기 위해 한자리 숫자에 0으로 매꾸기 위해 만들어진 함수
		function num_zf(nNum, len) {
			return str_zf(nNum.toString(), len);
		}
	},


    getLiveTime : function(dtCompare, dNow, dToday){
        if(!dNow){
            dNow = new Date();
        }
        if(!dToday){
            dToday = new Date(dNow.getFullYear(), dNow.getMonth(), dNow.getDate());
        }
        var sReturnText = "";
        var msecPerMinute = 1000 * 60;
        var msecPerHour = msecPerMinute * 60;
        var msecPerDay = msecPerHour * 24;
        var dTodayTime = dToday.getTime();
        var nDistance = dTodayTime-dtCompare;
        var nDistanceDay  = Math.floor(nDistance / msecPerDay );
        if(nDistanceDay<0){
            var nDistanceNow = dNow-dtCompare;
            var nDistanceHours = Math.floor(nDistanceNow / msecPerHour);
            if(nDistanceHours>0){
                sReturnText = fb.i18n.get("common.util.before.hour",[(nDistanceHours+1)]);
            }else{
                var nDistanceMinutes = Math.floor(nDistanceNow / msecPerMinute );
                if(nDistanceMinutes>0){
                    sReturnText = fb.i18n.get("common.util.before.minute",[nDistanceMinutes]);
                }else{
                    sReturnText = fb.i18n.get("common.util.before.now");
                }
            }
        }else{
            if(nDistanceDay==0){
                sReturnText = fb.i18n.get("common.util.yesterday");
            }else if(nDistanceDay<6){
                sReturnText = fb.i18n.get("common.util.before.day",[(nDistanceDay+1)]);
            }else{
                sReturnText =fb.i18n.get("common.util.before.week");
            }
        }
        return sReturnText;
    },


	/**
	 * * IE의 버전을 가져오는 함수
	 */
	getIEVersion : function() {
		var rv = -1;
		if (navigator.appName == 'Microsoft Internet Explorer') {
			var ua = navigator.userAgent;
			var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
			if (re.exec(ua) != null) {
				rv = parseFloat( RegExp.$1 );
			}
		} else if (navigator.appName == 'Netscape') {
			var ua = navigator.userAgent;
			var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
			if (re.exec(ua) != null) {
				rv = parseFloat( RegExp.$1 );
			}
		}
		return rv;
	},


	setWindowSizeByElement:function(welBody){
        setTimeout(function(){
            try{
                var welWindow = $(window);
                var nHeight = welBody.height();
                var nRealHeight = welWindow.innerHeight();
                var nWidth = welBody.width();
                var nRealWidth = welWindow.innerWidth();
                window.resizeBy(nWidth-nRealWidth, nHeight-nRealHeight);
            }catch(e){}
        },100);
	},
	
	setCookie: function(a,b,c) {
		// http://www.w3schools.com/js/js_cookies.asp
		var d=new Date;d.setDate(d.getDate()+c);var e=escape(b)+(null==c?"":"; expires="+d.toUTCString());document.cookie=a+"="+e;
	},
	
	getCookie: function(a) {
		// http://www.w3schools.com/js/js_cookies.asp		
		var b=document.cookie,c=b.indexOf(" "+a+"=");if(-1==c&&(c=b.indexOf(a+"=")),-1==c)b=null;else{c=b.indexOf("=",c)+1;var d=b.indexOf(";",c);-1==d&&(d=b.length),b=unescape(b.substring(c,d))}return b;
	},
	
	/**
	 * sDestText 에 마지막 글자의 받힘 여부에 따라 조사 sOption1, sOption2 중에 하나를 
	 * 선택하고 해당 조사를 반환한다.
	 * 
	 * @param sDestText 조사가 적용될 대상
	 * @param sOption1 받힘이 있는 sDestText 에 붙여질 조사 
	 * @param sOption2 받힘이 없는 sDesetText 에 붙여질 조사
	 */
	getPostPosition: function(sDestText, sOption1, sOption2) {
		return ((sDestText.charCodeAt(sDestText.length - 1) - 0xAC00) % 28 ? sOption1 : sOption2); 
	}, 
	
	getTh: function(nVal, sLocale) {
		sLocale = sLocale || "kr";
		if(sLocale == "en" || sLocale == "de" || sLocale == "fr" || sLocale == "es" || sLocale == "nl" || sLocale == "tr" || sLocale == "it" || sLocale == "pl" || sLocale == "pt") {
			if(nVal % 10 == 1) {
				//return "st";
				return fb.i18n.get("common.postfix.st") || "";
			} else if(nVal % 10 == 2) {
				//return "nd";
				return fb.i18n.get("common.postfix.nd") || "";
			}  else if(nVal % 10 == 3) {
				//return "rd";
				return fb.i18n.get("common.postfix.rd") || "";
			} else {
				//return "th";
				return fb.i18n.get("common.postfix.th") || "";
			}
		} else {
			return fb.i18n.get("league.schedule.seasonth");
		}
	},
	
	parseFloat: function (fVal, nFixed) {
		var sLocale = fb.Static.get("sLocale");
		if(typeof nFixed !="undefined") {
			fVal = fVal.toFixed(nFixed);
		}
		if(sLocale == "de" || sLocale == "fr" || sLocale == "es" || sLocale == "nl" || sLocale == "tr" || sLocale == "it" || sLocale == "pl" || sLocale == "pt") {
			return fVal.toString().replace(".",",");
		} else {
			return fVal;
		}
	}, 
	
	getRating: function (fOrg) {
		// dedicated by 과학고
		var sLocale = fb.Static.get("sLocale");
		if(sLocale == "de") {
			// 5.00 ~ 1.00
			return this.parseFloat(5.0 - ((fOrg - 1.0) * 4.0 / 9.0), 1); 
		} else {
			// 1.0 ~ 10.0
			return fOrg.toFixed(1);
		}
	},
	
	logout: function(_fCallback) {
		var fCallback = typeof(_fCallback) != 'undefined' ? _fCallback : function(){};
		if (fb.Static.get("sPublisherName") == "nxeu") {
			$.get('/nxeu/logout.json', {}, fCallback);
		} else if (fb.Static.get("sPublisherName") == "nhnpa") {
			$.get('/nhnpa/logout.json', {}, fCallback);
		}
		return;
	},

    openClubhouse : function(nTeamNo, sType){
        var sUrl = ((nTeamNo == 0) ? ("/club") : ("/club/" + nTeamNo));
        if(sType){
            sUrl = sUrl + "?type=" + sType;
        }

        if (fb.Static.get("sPublisherName") == "mbg"){ // 모바게인경우
            fb.Popup.showLoading();

            var welParent = $("#d_popup_iframe");
            var welIframe = $('<iframe src="'+sUrl+'" style="width:990px; height:690px;" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" allowTransparency="true" scrolling="no"></iframe>');
            welIframe.on("load", function() {
                welParent.fadeIn(200);
                fb.Popup.hideLoading();
                fb.Dimmed.show("full", {
                    "lock" : "popupClubhouse"
                });
            });
            welIframe.appendTo(welParent);

            //레이어 처리
        }else{
            //팝업처리
            var popupWindow = window.open(sUrl, "clubhouse", String(["width=940", "height=620", "toolbar=no", "location=no", "status=no", "menubar=no", "resizable=no", "scrollbars=no"]));
            setTimeout(function(){if(popupWindow){popupWindow.focus();}},1);
        }
    },

    closeClubhouse : function (sLoadPage){
        if (fb.Static.get("sPublisherName") == "mbg") { // 모바게인경우
            parent.fb.Dimmed.hide(200, {
                "lock" : "popupClubhouse"
            });
            if(sLoadPage){
                parent.fb.MenuCtrl.loadPage(sLoadPage, {
                    "reload" : true
                }, true);
            }
            var welParent = $("#d_popup_iframe",parent.document);
            welParent.html("");
        }else{
            window.close();
        }
    },
    
    isAllowPublihser: function (aPublisher) {
		var sLocale = fb.Static.get("sPublisherName");
		for (var i = 0; i < aPublisher.length; i++) {
			if (sLocale == aPublisher[i]) {
				return true;
			}
		}
		return false;
	},
	
	getAbilityColor: function(fValue) {
		if (fValue >= 125) {
			return "red";
		} else if (fValue >= 100) {
			return "org";
		} else if (fValue >= 80) {
			return "blue";
		} else if (fValue >= 65) {
			return "green";
		}
		return "gray";
	},
	
	getMaxPlayerAbility : function() {
		return 150.0;
	},
	
	getMaxTeamAbility : function() {
		return 180;
	}
};

/*
 * Extra code for cross-browsing (especially for IE 8 and under   
 */
if (!Array.prototype.indexOf) {
	Array.prototype.indexOf = function(elt /*, from*/) {
		var len = this.length >>> 0;

		var from = Number(arguments[1]) || 0;
		from = (from < 0) ? Math.ceil(from) : Math.floor(from);
		if (from < 0)
			from += len;

		for (; from < len; from++) {
			if (from in this && this[from] === elt)
				return from;
		}
		return -1;
	};
}

/*
 * Extra code for cross-browsing (especially for IE 8 and under   
 */
if (!Array.prototype.filter) {
	Array.prototype.filter = function(fun /*, thisp*/) {
		"use strict";

		if (this == null) throw new TypeError();

		var t = Object(this);
		var len = t.length >>> 0;
		if (typeof fun != "function") throw new TypeError();

		var res = [];
		var thisp = arguments[1];
		for (var i = 0; i < len; i++) {
			if (i in t) {
				var val = t[i]; // in case fun mutates this
				if (fun.call(thisp, val, i, t)) res.push(val);
			}
		}

		return res;
	};
}

/*
 * Extra code for cross-browsing (especially for IE 8 and under   
 */
if (!window.console) console = {
		log: function() {}
}

/*
 * Extra code for cross-browsing (especially for IE 8 and under)
 */
if (!Object.keys) {
	Object.keys = (function() {
		'use strict';
		var hasOwnProperty = Object.prototype.hasOwnProperty,
			hasDontEnumBug = !({ toString: null }).propertyIsEnumerable('toString'),
			dontEnums = [
			    'toString',
				'toLocaleString',
				'valueOf',
				'hasOwnProperty',
				'isPrototypeOf',
				'propertyIsEnumerable',
				'constructor'
			],
			dontEnumsLength = dontEnums.length;

		return function(obj) {
			if (typeof obj !== 'object' && (typeof obj !== 'function' || obj === null)) {
				throw new TypeError('Object.keys called on non-object');
			}

			var result = [], prop, i;

			for (prop in obj) {
				if (hasOwnProperty.call(obj, prop)) {
					result.push(prop);
				}
			}

			if (hasDontEnumBug) {
				for (i = 0; i < dontEnumsLength; i++) {
					if (hasOwnProperty.call(obj, dontEnums[i])) {
						result.push(dontEnums[i]);
					}
				}
			}
			return result;
		};
	}());
}

/*
 * Extra code for array manipulation 
 */
Array.prototype.remove = function() {
    var what, a = arguments, L = a.length, ax;
    while (L && this.length) {
        what = a[--L];
        while ((ax = this.indexOf(what)) !== -1) {
            this.splice(ax, 1);
        }
    }
    return this;
};
