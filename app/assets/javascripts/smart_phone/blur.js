$('#slidemenu #button_open').click(function() {
  $('#menu ul').removeClass('menu-bg-after');
  $('.all-wrapper').addClass('dialog');
  $('#menu ul').addClass('menu-bg');
});
$('#slidemenu #button_close').click(function() {
  $('.all-wrapper').removeClass('dialog');
  $('#menu ul').removeClass('menu-bg');
  $('#menu ul').addClass('menu-bg-after');
});

$('#slidemenu-left #button_open-left').click(function() {
  $('#menu-left').removeClass('menu-bg-after');
  $('.all-wrapper').addClass('dialog');
  $('#menu-left').addClass('menu-bg');
});
$('#slidemenu-left #button_close-left').click(function() {
  $('.all-wrapper').removeClass('dialog');
  $('#menu-left').removeClass('menu-bg');
  $('#menu-left').addClass('menu-bg-after');
});
