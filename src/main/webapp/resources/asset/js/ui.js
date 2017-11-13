

$(document).ready(function() {
  ui.init();
});

var ui = (function () {
  var init = function () {
    this.menuSet();
    this.radioCheck();
    this.selectChange();
    this.imgZoom();
    this.fitSearch.init();
    this.browserSet();
    this.detailView.init();
    this.lastList();
  }

  return {
    init: init,
    range: this.range,
    toggle: this.toggle,
    starRating : this.starRating,
    mapSize : this.mapSize,
    radioCheck : this.radioCheck
  }
})();

ui.browserSet = function(){
  if(isIE()){$("html").addClass("ie");}else{$("html").addClass("other-browser");}
  function isIE() { return ((navigator.appName == 'Microsoft Internet Explorer') || ((navigator.appName == 'Netscape') && (new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent) != null))); }
}

ui.menuSet = function(){
  $(document).on('mouseleave mouseenter', '.login-on', function(e){
    if(e.type == "mouseenter"){$(this).addClass("act");}else{$(this).removeClass("act");}
  });
}

ui.radioCheck = function(){
  var obj = $("input[type=checkbox], input[type=radio]");

  obj.each(function(){
    if($(this).prop('type')=='radio') $(this).parent().wrap("<span class='custom-radio'></span>");
    if($(this).prop('type')=='checkbox') $(this).parent().wrap("<span class='custom-checkbox'></span>");
    if($(this).is(":checked")){$(this).parent().addClass("on");}
    else{$(this).parent().parent().find("label").removeClass("on");}
  });
  obj.off("click").on("click", function(){
    if($(this).is(":checked")){
      if($(this).prop('type')=='radio'){
        $(this).parent().parent().siblings().find("label").removeClass("on");
      }
      $(this).parent().addClass("on");
    }else{
      $(this).parent().removeClass("on");
    }
  });
  obj.off("focus").on("focus", function(){$(this).parent().addClass("focus");});
  obj.off("blur").on("blur", function(){$(this).parent().removeClass("focus");});
}

ui.selectChange = function(){
  $(".custom-select").each(function(){
    var select = $(this).find('select');
    var select_name = select.children("option:selected").text();

    if(!select.siblings('label').hasClass("tit")){
      select.siblings('label').find("span").text(select_name);
    }
    select.off("focusin click keypress").on("focusin click keypress", function(e){
      if(e.type=="focusin"){
        $(this).parent().addClass("focus");
      }else{
        if($(this).parent().hasClass("active")){
          $(this).parent().removeClass("active");
        }else{
          $(this).parent().addClass("active");
        }
      }
    }).off("blur").on("blur", function(e){
      $(this).parent().removeClass("active focus");
    });
    select.change(function(){
      var select_name = $(this).children("option:selected").text();
      $(this).siblings('label').find("span").text(select_name);
    });
  });
}

ui.imgZoom = function(){
  if($(".fit-list, .goods-list").length==0){return;}
  var imgObj = $(".fit-list, .goods-list");
  var time = 0.4;
  imgObj.find("li").each(function(){
    if($(this).parents("div").attr("data-over-ty")=="1"){
      $(this).find(".photo-box").prepend('<span class="bg"></span><span class="ico-zoom"></span>');
    }else{
      $(this).find("a").prepend('<span class="bg"></span>');
    }
    $(this).mouseenter(function(){
      $(this).find(".bg").addClass("over");
      $(this).find(".ico-zoom").show();
      TweenLite.to($(this).find('.photo img'), time, {css:{className:'+=over'}});
    });
    $(this).mouseleave(function(){
      $(this).find(".bg").removeClass("over");
      $(this).find(".ico-zoom").hide();
      TweenLite.to($(this).find('.photo img'), time, {css:{className:'-=over'}});
    });
  });
}

ui.fitSearch = (function() {
  var init = function() {
    if($( ".search-sec" ).length==0){return;}
    keywordSch();
    checkInOut();
    guestNumber();
  }
  var keywordSch = function(){
    $( "#keyword" ).autocomplete({
      source: autoCompleteCall(),
      minLength: 1,
      autoFocus: true,
      appendTo:".ui-autocomplete-wrap",
      select : function(event, ui){
        if($(this).length >= 14){
          return input.substr(0,20)+"...";
        }
      }
    }).on("focus blur", function(e){
      if(e.type=="focus"){
        $(this).removeAttr('placeholder');
        $(this).autocomplete("search", " ");
      }else{
        if($(this).val()==""){
          $(this).attr('placeholder', $(this).data('placeholder'));
        }
      }
    }).autocomplete( "instance" )._renderItem = function(ul, item){
      if(item.ty!="etc"){return $("<li>").append("<div><span>" + item.label + "</span><em>" + item.num + "개</em></div>").appendTo(ul);}
      else {
        return $('<li class="etc">').append($(".ui-autocomplete-wrap .other").html()).appendTo(ul);
      }
    };
  }
  var checkInOut = function(){
    var objData = $(".date-rang-picker");
    var objDataLayer = $(".date-rang-layer");
    var objDataBtn = objData.find("button");
console.log("objData - " + objData);
    resetTxt();
    objDataLayer.find(".close").click(function(){
      objData.find("button").removeClass("act");
      objDataLayer.hide();
      return false;
    });
    objDataBtn.dateRangePicker({
      inline:true,
      container: '.date-rang-layer .row',
      alwaysOpen:true,
      autoClose: true,
      format: 'YYYY.MM.DD',
      language: 'ko',
      stickyMonths: true,
      duration: 0,
      hoveringTooltip: false,
      startDate: new Date(),
      selectForward: true,
      setValue: function(s, s1, s2){
        $(this).addClass("sel");
        $(this).parent().find('input').eq(1).val(s2);
        $(this).parent().find('input').eq(0).val(s1);
        $(this).find('span').eq(1).find("em").html(s2);
        $(this).find('span').eq(0).find("em").html(s1);
      }
    }).bind('datepicker-change', function(){
      objDataLayer.hide();
      objDataBtn.addClass("sel").removeClass("act");
    });
    $(document).on("click",".date-rang-picker button", function(){
      if($(this).hasClass('sel')){
        objDataBtn.data('dateRangePicker').clear();
        objDataBtn.removeClass("sel");
        resetTxt();
      }else{
        if(!$(this).hasClass("act")){
          $(this).addClass("act");
          objDataLayer.show();
        }
      }
      hideFocus();
    });

    function resetTxt(){
      objData.find("input").val();
      objDataBtn.find("em").each(function(){
        $(this).text($(this).attr("data-txt"));
      });
    }
    function hideFocus(){
      $(document).on('focusin.date-rang-picker click.date-rang-picker', function(e){
        if ($(e.target).closest('.date-rang-picker').length) return;
        $(document).off('.date-rang-picker');
        objDataBtn.removeClass("act");
        objDataLayer.hide();
      });
    }
  }
  var guestNumber = function(){
    var wrap = $(".guest-picker");
    var trigger = wrap.find(".guest-trigger");
    var itemPop = wrap.find(".guest-picker-layer");
    var item = wrap.find('.row');
    var min = [], max = [], num = [];
    item.each(function(i){
      min[i]=parseInt($(this).attr("data-min"));
      max[i]=parseInt($(this).attr("data-max"));
      num[i]=parseInt($(this).attr("data-min"));
      guestWriteTxt(i)
    });
    guestNumChange();
    guestLayer();

    function guestNumChange(){
      item.on("click", ".minus", function(){
        var idx = $(this).closest(".row").index();
        num[idx] = parseInt((num[idx]-1) <= min[idx] ? min[idx] : num[idx]-1);
        guestWriteTxt(idx);
      });
      item.on("click", ".plus", function(){
        var idx = $(this).closest(".row").index();
        num[idx] = parseInt((num[idx]+1) >= max[idx] ? max[idx] : num[idx]+1);
        guestWriteTxt(idx);
      });
    }
    function guestWriteTxt(n){
      trigger.find(".num em").html(num[0]+num[1]+num[2]);
      item.eq(n).find('.label input').val(num[n]);
      if(num[n]<=min[n]){
        item.eq(n).find('.minus').addClass("off").attr('disabled', true);
      }else{
        item.eq(n).find('.minus').removeClass("off").attr("disabled", false);
      }
      if(num[n]>=max[n]){
        item.eq(n).find('.plus').addClass("off").attr('disabled', true);
      }else{
        item.eq(n).find('.plus').removeClass("off").attr("disabled", false);
      }
    }
    function guestLayer(){
      trigger.off("click").on("click", function(){
        $(this).addClass("total");
        if(!$(this).hasClass("act")){
          $(this).addClass("act");
          itemPop.show();
          guestHideFocus();
        }else{
          $(this).removeClass("act");
          itemPop.hide();
        }
      });
      itemPop.find(".close").on("click", function(){
        trigger.removeClass("act");
        itemPop.hide();
        trigger.focus();
        return false;
      });
    }
    function guestHideFocus(){
      $(document).on('focusin.guest-picker click.guest-picker', function(e){
        if ($(e.target).closest('.guest-picker').length) return;
        $(document).off('.guest-picker');
        trigger.removeClass("act");
        itemPop.hide();
      });
    }
  }
  return {init:init}
})();
ui.rangeSlider = function(m1, m2){
  $("#slider-range").slider({
    range: true,
    min: m1,
    max: m2,
    values: [m1, m2],
    slide: function( event, ui ) {
      $("#amountMin").val(ui.values[0].format());
      $("#amountMax").val(ui.values[1].format());
    }
  });
  $("#amountMin").val($("#slider-range" ).slider( "values", 0).format());
  $("#amountMax").val($("#slider-range" ).slider( "values", 1).format());
}

ui.detailView = (function(){
  var init = function() {
    if($( ".detail-wrap" ).length==0){return;}
    dateChk();
    sticky();
  }
  var dateChk = function(){
    var objData = $(".date-rang-picker");
    var objDataBtn = objData.find(".date-inputs");
    var objDataLayer = objData.find(".date-rang-layer");

    objDataLayer.find(".close").click(function(){
      objData.find("button").removeClass("act");
      objDataLayer.hide();
      return false;
    });
    objDataBtn.dateRangePicker({
      inline:true,
      container: objDataLayer.find(".row"),
      alwaysOpen:true,
      autoClose: true,
      format: 'YYYY.MM.DD',
      language: 'ko',
      stickyMonths: true,
      duration: 0,
      hoveringTooltip: false,
      startDate: new Date(),
      selectForward: true,
      separator : ' to ',
      getValue: function(){
        if ($('.date-range1').val() && $('.date-range2').val()) {return $('.date-range1').val() + ' to ' + $('.date-range2').val();}
        else {return '';}
      },
      setValue: function(s,s1,s2){
        $('.date-range1').val(s1);
        $('.date-range2').val(s2);
      }
    }).bind('datepicker-change', function(){
      objDataLayer.hide();
      objDataBtn.removeClass("act");
    });
    $(document).on("click",".date-rang-picker .date-inputs", function(){
      if($(this).parents(".sticky").length!=0){objDataLayer.addClass("sticky-pos");}else{objDataLayer.removeClass("sticky-pos");}
      if(!$(this).hasClass("act")){$(this).addClass("act"); objDataLayer.show();}else{$(this).removeClass("act");}
      hideFocus();
    });
    function hideFocus(){
      $(document).on('focusin.date-rang-picker click.date-rang-picker', function(e){
        if ($(e.target).closest('.date-rang-picker').length){return;}
        $(document).off('.date-rang-picker');
        objDataBtn.removeClass("act");
        objDataLayer.hide();
      });
    }
  }
  var sticky = function(){
    var obj = $(".detail-top");
    var obj_pos = obj.offset().top + obj.height();
    $(window).scroll(function(){if($(document).scrollTop() > obj_pos){$(".sticky").show();}else{$(".sticky").hide();}});
  }
  return {init:init}
})();

ui.toggle = function(o){
  var obj = o;
  var flag = (o.closest("table").length==1);
  var flag2 = (o.closest("dl").length==1);

  obj.each(function(){
    $(this).click(function(){
      if($(this).hasClass("act")){
        $(this).removeClass("act");
        if(flag || flag2){$(this).next().removeClass("act");}
      }else{
        $(this).addClass("act").siblings().removeClass("act");
        if(flag || flag2){$(this).next().addClass("act");}
      }
    });
  });
}

ui.starRating = function(){
  var obj = $(".review-write");
  var objN = obj.find(".star-rating").length;
  var w = obj.find("a").width();
  var totalNumObj = $("#review-star-total");
  var totalNum = 0;

  obj.find(".star-rating").each(function(){
    gradeNum($(this), $(this).attr("data-base-score"));
    totalCal();
    $(this).on("click", "a", function(){
      gradeNum($(this).closest(".star-rating"), $(this).attr("data-num"));
      totalCal();
      return false;
    });
  });

  function gradeNum(o, n){
    o.find("em").width(n*w);
    o.find(".num input").val(parseFloat(n).toFixed(1));
  }

  function totalCal(){
    totalNum = 0;
    obj.find(".star-rating .num input").each(function(){
      totalNum = totalNum + parseFloat($(this).val());
    });
    totalNumObj.val(parseFloat(totalNum/objN).toFixed(1));
  }
}

ui.lastList = function(){
  var o = $(".last-chk-view");
  if(o.length==0){return;}
  var slider = $(".last-chk-view .col1 .lv-list ul").bxSlider({minSlides: 5, maxSlides: 5, speed: 600, pager:false, auto: false, slideWidth: 140, slideMargin: 11, autoControls:false, infiniteLoop: false});
  //slider.reloadSlider();
  o.find("li .in").hover(function(){$(this).closest(".lv-list").addClass("over");}, function(){$(this).closest(".lv-list").removeClass("over");});
  o.off("click").on("click", ".bt-last-open", function(){
    var k = $(this).closest(".last-chk-view");
    if(!k.hasClass("act")){
      k.addClass("act");
      if($(document).scrollTop() + $(window).height() >= $(".wrap").height()){$(document).scrollTop($(document).height());}
    }else{k.removeClass("act");}
    return false;
  });

  function positionFooter() {
    if($(document).scrollTop() + $(window).height() >= $(".wrap").height()){
      o.css("position",'static');
      if($(document).scrollTop() + $(window).height() - $("#footer").outerHeight(true, true) >= $(".wrap").height()){
        $(document).scrollTop($(document).height());
      }
    }else{
      o.css("position",'fixed');
    }
  }

  $(window).scroll(positionFooter).resize(positionFooter);
}

ui.mapSize = function(){
  var mObj = $(".map-wrap"), sObj = $("#contents");
  var wS;
  if($("#includeHeader").length==1){
    setTimeout(posCal, 300);
  }else{
    posCal();
  }
  $(window).resize(posCal);

  function posCal(){
    wS = $(document).width()-sObj.outerWidth(true, true);
    if(wS<=0){mObj.hide();}else{mObj.show().width(wS).height(sObj.outerHeight(true, true)).css("top", sObj.offset().top);}
  }
}

Number.prototype.format = function(n, x) {
  var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
  return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};