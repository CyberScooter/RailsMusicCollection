
$(function() {
    
    //if scrolling on windows and top scroll height is over 40 then display the scroll
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
    

    // after input is touched and if empty then display red outline
    $('.InputJQuery input').on("click", function(){
        if($(this).val().length == 0){
            $(this).addClass("error");
        } else{
            $(this).removeClass("error");
        }
    });
})