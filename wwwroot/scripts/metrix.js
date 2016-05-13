(function($){
$(function(){

	//клик на почту
$('a').on('click', function()
{
	if ($(this).attr('href')=='mailto:help@railfgk.ru')
	{
		void(yaCounter31804437.reachGoal('pochta') );
		ga('send', 'pageview', 'pochta');
		//console.log('pochta');
		
	}
});
	
	//подписаться
$('button.fright').on('click', function()
{
		void(yaCounter31804437.reachGoal('podpisatsja') );
		ga('send', 'pageview', 'podpisatsja');
		//console.log('podpisatsja');

});
	
	//обратная связь
$('button#go').on('click', function()
{
		void(yaCounter31804437.reachGoal('otpravit') );
		ga('send', 'pageview', 'otpravit');
		//console.log('otpravit');

});
	
	

});

})(jQuery);

