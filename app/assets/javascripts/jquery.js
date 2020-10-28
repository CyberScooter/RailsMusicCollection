
$(function() {
    
	$(window).on('scroll', function(){
        if(window.matchMedia('(max-width: 767px)').matches){
            if($(this).scrollTop() <= 160){
                $(".navbar").removeClass('navbar-scroll');
            } else if($(this).scrollTop() > 160){
                $(".navbar").addClass('navbar-scroll');
            } 
        }else{
            if($(this).scrollTop() <= 40){
                $(".navbar").removeClass('navbar-scroll');
            } else if($(this).scrollTop() > 40){
                $(".navbar").addClass('navbar-scroll');
            } 
        }
		
	});
})