$(document).ready(function(){
  $(".menu-item").hover(function(){
    $(this).find(".submenu").slideDown();
  }, function(){
    $(this).find(".submenu").slideUp();
  });
});