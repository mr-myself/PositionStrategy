$(function() {
  $('.title-wrapper').on('inview', function() {
      $('.title-wrapper span').animate({
        "opacity": "1"
      }, 1000);
      $('.posi-m').delay(1000).animate({
        "opacity": "1"
      }, 1000);
      $('#index').delay(1500).animate({
        "opacity": "1"
      }, 1000);
      $('#before-login').delay(1500).animate({
        "opacity": "1"
      }, 1000);
      $('#after-login').delay(1500).animate({
        "opacity": "1"
      }, 1000);
  });
});

