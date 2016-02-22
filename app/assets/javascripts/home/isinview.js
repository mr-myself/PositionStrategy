$(function() {
  $('.title-wrapper').on('inview', function() {
      $('.title-home img').delay(1500).animate({
        "opacity": "1",
        "bottom": "130px"
      }, 1500);
      $('.title-home h1, .title-home h2').animate({
        "opacity": "1"
      }, 1000);
      $('.title-home .home-suggest').delay(2500).animate({
        "opacity": "1"
      }, 500);
      $('#index').delay(1000).animate({
        "opacity": "1"
      }, 500);
      $('#loopslider').delay(3500).animate({
        "opacity": "1"
      }, 500);
      setTimeout(function () {
        $('#index').addClass('blur-graph');
      }, 1500);
  });
});

$(function(){
  $('#loopslider').each(function(){
    var loopsliderWidth = $(this).width();
    var loopsliderHeight = $(this).height();
    $(this).children('ul').wrapAll('<div id="loopslider_wrap"></div>');

    var listWidth = $('#loopslider_wrap').children('ul').children('li').width();
    var listCount = $('#loopslider_wrap').children('ul').children('li').length;

    var loopWidth = (listWidth)*(listCount);

    $('#loopslider_wrap').css({
      top: '0',
      left: '0',
      width: ((loopWidth) * 2),
      height: (loopsliderHeight),
      overflow: 'hidden',
      position: 'absolute'
    });

    $('#loopslider_wrap ul').css({
      width: (loopWidth)
    });
    loopsliderPosition();

    function loopsliderPosition(){
      $('#loopslider_wrap').css({left:'0'});
      $('#loopslider_wrap').stop().animate({left:'-' + (loopWidth) + 'px'},25000,'linear');
      setTimeout(function(){
        loopsliderPosition();
      },25000);
      $('#loopslider ul li').hover(
        function() {
          $('#loopslider_wrap').stop().animate({left:'-' + (loopWidth) + 'px'},40000,'linear');
          setTimeout(function(){
            loopsliderPosition();
          },40000);
        },
        function() {
          $('#loopslider_wrap').stop().animate({left:'-' + (loopWidth) + 'px'},25000,'linear');
          setTimeout(function(){
            loopsliderPosition();
          },25000);
        }
      );
    };

    $('#loopslider_wrap ul').clone().appendTo('#loopslider_wrap');
  });
});
