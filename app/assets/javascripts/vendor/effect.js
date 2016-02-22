$(function(){
  $('.effect').css("opacity",".7");
  $(window).scroll(function (){
    $('.effect').each(function(){
      var imgPos = $(this).offset().top;    
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + 200){
        $(this).animate({ 
          "opacity": "1"
        }, 500);
      }
    });
  });
});
