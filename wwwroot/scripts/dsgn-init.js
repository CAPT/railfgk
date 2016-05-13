function theSlider(slidetime, interval) {
    setInterval('rotate(' + slidetime + ')', interval);
}

function hideFlash() {
    var embeds = document.getElementsByTagName('embed');
    for (i = 0; i < embeds.length; i++) embeds[i].style.visibility = 'hidden';
    var objects = document.getElementsByTagName('object');
    for (i = 0; i < objects.length; i++) objects[i].style.visibility = 'hidden';
}

function showFlash() {
    var embeds = document.getElementsByTagName('embed');
    for (i = 0; i < embeds.length; i++) embeds[i].style.visibility = 'visible';
    var objects = document.getElementsByTagName('object');
    for (i = 0; i < objects.length; i++) objects[i].style.visibility = 'visible';
}

function rotate(slidetime) {
    var selector = 'div.sliderMain ul.frames';
    var current = ($(selector + ' li.current') ? $(selector + ' li.current') : $(selector + ' li:first'));
    var next = current.next('li').length > 0 ? current.next('li') : $(selector + ' li:first');
    var selIdx = 'div.sliderMain ul.navi';
    var currIdx = ($(selIdx + ' li.selected') ? $(selIdx + ' li.selected') : $(selIdx + ' li:first'));
    var nextIdx = currIdx.next('li').length > 0 ? currIdx.next('li') : $(selIdx + ' li:first');
    current.fadeOut(slidetime, function() {
        $(this).removeClass('current');
        currIdx.removeClass('selected');
    });

    next.fadeIn(slidetime, function() {
        nextIdx.addClass('selected');
        $(this).addClass('current');
    });
};

$(function() {

    // main page slider ----------------
    theSlider(2000, 9000);
    $('div.sliderMain ul.navi a').delegate(null, 'click', function() {
        var newIdx = $('div.sliderMain ul.navi li').index($(this).parent());
        $('div.sliderMain ul.frames li.current').removeClass('current').hide();
        $('div.sliderMain ul.navi li.selected').removeClass('selected');
        $('div.sliderMain ul.frames li:eq(' + newIdx + ')').fadeIn('slow').addClass('current');
        $('div.sliderMain ul.navi li:eq(' + newIdx + ')').addClass('selected');
        return (false);
    });
    // RussiaMap ------------------------
    $("#RussiaMap").on({
        mouseenter: function() {
            var areaId = $(this).attr("id").replace("area-", "");
            $("#amap-" + areaId).stop(true, true).fadeIn(100);
            $("#affiliatesList a[rel=" + areaId + "]").css("color", "red");
        },
        mouseleave: function() {
            var areaId = $(this).attr("id").replace("area-", "");
            $("#amap-" + areaId).stop(true, true).fadeOut(200);
            $("#affiliatesList a[rel=" + areaId + "]").css("color", "");
        }
    }, "area");
    $("#affiliatesList a").on({
        mouseenter: function() {
            var areaId = $(this).attr("rel");
            $("#amap-" + areaId).stop(true, true).fadeIn(100);
        },
        mouseleave: function() {
            var areaId = $(this).attr("rel");
            $("#amap-" + areaId).stop(true, true).fadeOut(200);
        }
    });
    //-----------------------------------
});


$( document ).ready(function() {
	$('#scrollup img').mouseover( function(){
		$( this ).animate({opacity: 0.65},100);
	}).mouseout( function(){
		$( this ).animate({opacity: 1},100);
	}).click( function(){
		window.scroll(0 ,0); 
		return false;
	});

	$(window).scroll(function(){
		if ( $(document).scrollTop() > 0 ) {
			$('#scrollup').fadeIn('fast');
		} else {
			$('#scrollup').fadeOut('fast');
		}
	});
});