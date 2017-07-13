var popup = (function($){
  var bg=null, popWrap=null, linkHref=null;
  function pos(obj){
    var popObj=obj;
    var topPos = popObj.height()/2;
    var leftPos = popObj.width()/2;

    if(bg==null){
      if($(".layer-bg").length==0){popWrap.prepend("<div class='layer-bg'></div>");}
      bg = $(".layer-bg");
    }
    popObj.css({"margin-top": -topPos +"px","margin-left": -leftPos +"px"}).show();
    bg.show();

    /*focus*/
    var popChild = obj.find("a, area, button, input, object, select, textarea");
    popChild.first().focus();
    if(popChild.length==1){
      popChild.off("keydown").on("keydown", function(e){if(e.keyCode == 9){popChild.first().focus(); return false;}});
    }else{
      popChild.last().off("keydown").on("keydown", function(e){if(e.keyCode == 9){if(!e.shiftKey) {popChild.first().focus(); return false;}}});
      popChild.first().off("keydown").on("keydown", function(e){if(e.keyCode == 9){if(e.shiftKey) {popChild.last().focus(); return false;}}});
    }
  }
  function layerPop(link){
    popWrap = $(".layer-area-wrap");
    var popObj=$(link.attr("href"));
    linkHref = link
    pos(popObj);
    popObj.on("click", '.bt-close', function(){layerPopClose(popObj); linkHref.focus(); return false;});
  }
  function layerPopClose(obj){
    linkHref.focus();
    bg.hide();
    if(obj.hasClass("alert-pop")){obj.remove();}else{obj.hide();}
  }
  return {layerPop:layerPop, layerPopClose:layerPopClose}
})(jQuery);