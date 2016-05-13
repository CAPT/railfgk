
$( document ).ready(function() {
	$('#scrollup').hide();
	
	$('#scrollup img').mouseover( function(){
		$( this ).animate({opacity: 0.7},100);
	
	}).mouseout( function(){
		$( this ).animate({opacity: 1},100);
		
		}).click( function(){
			$('body,html').animate({ scrollTop: 0 }, 800);
		/*window.scroll(0 ,0); */
		return false;
	});

	$(window).scroll(function(){
		if ( $(document).scrollTop() > 0 ) {
			$('#scrollup').fadeIn(500);
		} else {
			$('#scrollup').fadeOut(500);
		}
	});
});